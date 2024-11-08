import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login/login_page.dart';

class ProfilePage extends StatelessWidget
{
  final VoidCallback toggleTheme;

  const ProfilePage({Key? key, required this.toggleTheme, String? userId}) : super(key: key);

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
            (route) => false, // Clear all previous routes
      );
    } catch (e) {
      // Show error message if sign-out fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error signing out: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Center(

      ),
    );
  }
}
