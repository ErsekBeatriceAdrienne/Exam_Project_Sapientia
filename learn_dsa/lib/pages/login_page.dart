import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget
{
  final VoidCallback toggleTheme;

  const LoginPage({required this.toggleTheme, super.key});

  @override
  Widget build(BuildContext context)
  {
    // Determine the current theme mode
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: FloatingActionButton.extended(
              onPressed: () {
                HapticFeedback.mediumImpact();
                // Navigate to the HomePage when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(toggleTheme: toggleTheme),
                  ),
                );
              },
              icon: Image.asset(
                'assets/images/google_logo.png', // Load the Google logo
                height: 32, // Adjust the height as needed
                width: 32,  // Adjust the width as needed
              ),
              label: const Text('Sign in with Google'),
              backgroundColor: isDarkMode ? Colors.grey[850] : Colors.white,
              foregroundColor: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: Icon(
                Icons.brightness_6,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {
                HapticFeedback.mediumImpact(); // Add haptic feedback
                toggleTheme(); // Call the toggleTheme function
              },
            ),
          ),
        ],
      ),
    );
  }
}