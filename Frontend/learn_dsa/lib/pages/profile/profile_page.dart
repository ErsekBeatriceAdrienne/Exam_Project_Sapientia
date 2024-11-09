import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_dsa/pages/profile/profile_components/profile_design/profile_page_design.dart';
import 'package:learn_dsa/pages/profile/profile_components/profile_functionality/profile_page_actions.dart';
import '../../database/cloudinary_service.dart';
import 'login/login_page.dart';

class ProfilePage extends StatefulWidget
{
  final VoidCallback toggleTheme;

  const ProfilePage({Key? key, required this.toggleTheme}) : super(key: key);

  Future<void> signOut(BuildContext context) async
  {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate back to LoginPage with toggleTheme
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(toggleTheme: toggleTheme),
        ),
            (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error signing out: $e")),
      );
    }
  }

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
{
  String? _profileImageUrl;
  String? _oldProfileImageUrl;

  final CloudinaryService _cloudinaryService = CloudinaryService();
  final ImagePicker _picker = ImagePicker();

  Future<Map<String, dynamic>?> _fetchUserData() async
  {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return null;

    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();

    return userDoc.data() as Map<String, dynamic>?;
  }

  Future<void> _updateProfileImage(File image) async
  {
    try {
      // Upload the new image to Cloudinary
      String? imageUrl = await _cloudinaryService.uploadImageUnsigned(image, 'your_preset_name');

      if (imageUrl != null) {
        // Update Firestore with the new image URL
        User? currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser.uid)
              .update({'profilePicture': imageUrl});

          // If there was an old image URL, delete it from Cloudinary
          if (_oldProfileImageUrl != null) {
            String publicId = _getPublicIdFromUrl(_oldProfileImageUrl!);
            await _cloudinaryService.deleteImage(publicId);
          }

          setState(() {
            _profileImageUrl = imageUrl;
            _oldProfileImageUrl = imageUrl;
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating profile image: $e")),
      );
    }
  }

  Future<void> _pickImage() async
  {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File image = File(pickedFile.path);
      await _updateProfileImage(image);
    }
  }

  String _getPublicIdFromUrl(String url)
  {
    // Extract the publicId from the URL (you may need to adjust this based on your Cloudinary setup)
    final uri = Uri.parse(url);
    final segments = uri.pathSegments;
    return segments.isNotEmpty ? segments.last.split('.').first : '';
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return const Center(child: CircularProgressIndicator());
          if (snapshot.hasError)
            return const Center(child: Text('Error loading profile data.'));
          final userData = snapshot.data;
          if (userData == null)
            return const Center(child: Text('User data not found.'));

          _profileImageUrl = userData['profilePicture'];
          _oldProfileImageUrl = _profileImageUrl;

          final String firstName = userData['firstName'] ?? 'First Name';
          final String lastName = userData['lastName'] ?? 'Last Name';
          final String username = userData['username'] ?? 'Username';
          final String email = FirebaseAuth.instance.currentUser?.email ?? 'Email not available';

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ProfileHeader(
                          profileImageUrl: _profileImageUrl,
                          firstName: firstName,
                          lastName: lastName,
                          email: email,
                        ),
                        const SizedBox(height: 10),
                        ProfileActions(
                          onPickImage: _pickImage,
                          onNotes: () {
                            // Action for Notes button
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
