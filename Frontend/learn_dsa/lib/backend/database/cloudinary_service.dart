import 'dart:io';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import '../../frontend/strings/cloudinary/cloudinary_apis.dart';

class CloudinaryService {
  late Cloudinary cloudinary;

  CloudinaryService()
  {
    cloudinary = Cloudinary.full(
      apiKey: CloudinaryData.apiKey,
      apiSecret: CloudinaryData.apiSecret,
      cloudName: CloudinaryData.cloudName,
    );
  }

  Future<String?> uploadImageUnsigned(File image, String presetName) async
  {
    try {
      final response = await cloudinary.unsignedUploadResource(
        CloudinaryUploadResource(
          uploadPreset: presetName,
          filePath: image.path,
          fileBytes: image.readAsBytesSync(),
          resourceType: CloudinaryResourceType.image,
          folder: CloudinaryData.folder,
          fileName: "${CloudinaryData.folder}_${DateTime.now().millisecondsSinceEpoch}",
          progressCallback: (count, total) {
            print('Uploading in progress: $count/$total');
          },
        ),
      );

      if (response.isSuccessful) {
        print('Uploaded pic URL-je: ${response.secureUrl}');
        return response.secureUrl;
      } else {
        print('Error when uploading: ${response.error}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<void> deleteImage(String publicId) async {
    try {
      final response = await cloudinary.deleteResource(
        publicId: publicId,
        resourceType: CloudinaryResourceType.image,
      );

      if (response.isSuccessful) {
        print("Image successfully deleted from Cloudinary.");
      } else {
        print("Error deleting image from Cloudinary: ${response.error}");
      }
    } catch (e) {
      print('Error deleting image: $e');
    }
  }

}
