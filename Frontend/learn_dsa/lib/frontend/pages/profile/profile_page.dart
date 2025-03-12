import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_dsa/frontend/pages/profile/profile_components/profile_functionality/profile_page_actions.dart';
import 'package:learn_dsa/frontend/pages/profile/profile_components/profile_userinfo/profile_page_userinfo.dart';
import 'package:learn_dsa/frontend/pages/profile/settings/settings_page.dart';
import 'package:learn_dsa/frontend/pages/profile/test_results.dart';
import '../../../backend/database/cloudinary_service.dart';
import '../../strings/firestore/firestore_docs.dart';
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

class _ProfilePageState extends State<ProfilePage> {
  String? _profileImageUrl;
  String? _oldProfileImageUrl;

  final CloudinaryService _cloudinaryService = CloudinaryService();
  final ImagePicker _picker = ImagePicker();

  Future<Map<String, dynamic>?> _fetchUserData() async
  {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return null;

    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection(FirestoreDocs.user_doc)
        .doc(currentUser.uid)
        .get();

    return userDoc.data() as Map<String, dynamic>?;
  }

  Future<void> _updateProfileImage(File image) async
  {
    try {
      // Upload the new image to Cloudinary
      String? imageUrl = await _cloudinaryService.uploadImageUnsigned(
          image, '?');

      if (imageUrl != null) {
        // Update Firestore with the new image URL
        User? currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          await FirebaseFirestore.instance
              .collection(FirestoreDocs.user_doc)
              .doc(currentUser.uid)
              .update({FirestoreDocs.userProfilePic: imageUrl});

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

  String _getPublicIdFromUrl(String url) {
    // Extract the publicId from the URL (you may need to adjust this based on your Cloudinary setup)
    final uri = Uri.parse(url);
    final segments = uri.pathSegments;
    return segments.isNotEmpty ? segments.last
        .split('.')
        .first : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading profile data.'));
          }

          final userData = snapshot.data;
          if (userData == null) {
            return const Center(child: Text('User data not found.'));
          }

          _profileImageUrl = userData[FirestoreDocs.userProfilePic];
          _oldProfileImageUrl = _profileImageUrl;

          final String firstName = userData[FirestoreDocs.userFirstName];
          final String lastName = userData[FirestoreDocs.userLastName];
          final String email = FirebaseAuth.instance.currentUser?.email ??
              'Email not available';

          return CustomScrollView(
            slivers: [
              // SliverAppBar with disappearing on scroll
              SliverAppBar(
                backgroundColor: Colors.transparent,
                pinned: true,
                floating: false,
                expandedHeight: 70,
                flexibleSpace: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
                      child: FlexibleSpaceBar(
                        titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                        title: Text(
                          userData[FirestoreDocs.userUsername],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFDFAEE8)
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                actions: [
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.pending_outlined, color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    onSelected: (String value) async {
                      if (value == 'settings') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsPage(),
                          ),
                        );
                      } else if (value == 'logout') {
                        await widget.signOut(context);
                      }
                    },
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem<String>(
                        value: 'settings',
                        child: Row(
                          children: const [
                            Icon(Icons.settings, color: Colors.pink),
                            SizedBox(width: 8),
                            Text('Settings', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'logout',
                        child: Row(
                          children: const [
                            Icon(Icons.logout, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Logout', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Profile Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
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
                              onNotes: () {},
                            ),
                            const SizedBox(height: 10),

                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Donut chart
                      DonutChart(),
                      Text(
                        "Test results",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),

                      const SizedBox(height: 65),


                    ],
                  ),
                ),
              ),

            ],
          );
        },
      ),
    );
  }
}
