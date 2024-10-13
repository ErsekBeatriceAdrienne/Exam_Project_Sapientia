import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

/*
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
}*/

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

// supabase
final supabase = Supabase.instance.client;

class _LoginPageState extends State<LoginPage> {
  String? _user_id;

  @override
  void initState()
  {
    super.initState();

    supabase.auth.onAuthStateChange.listen((onData) {
      setState(() {
        // user will be signed in
        _user_id = onData.session?.user.id;
      });
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_user_id ?? 'Not Signed in'),
            ElevatedButton(onPressed: () async
            {
              const webClientId = '485441696681-7lt2qm26apvugkcqnos782uhkeihn46b.apps.googleusercontent.com';

              /// iOS Client ID that you registered with Google Cloud.
              const iosClientId = '485441696681-4q2ph5npc6mn0e3h3ci57kare8soi7vu.apps.googleusercontent.com';

              // Google sign in on Android will work without providing the Android
              // Client ID registered on Google Cloud.

              final GoogleSignIn googleSignIn = GoogleSignIn(
                clientId: iosClientId,
                serverClientId: webClientId,
              );
              final googleUser = await googleSignIn.signIn();
              final googleAuth = await googleUser!.authentication;
              final accessToken = googleAuth.accessToken;
              final idToken = googleAuth.idToken;

              if (accessToken == null) {
                throw 'No Access Token found.';
              }
              if (idToken == null) {
                throw 'No ID Token found.';
              }

              await supabase.auth.signInWithIdToken(
                provider: OAuthProvider.google,
                idToken: idToken,
                accessToken: accessToken,
              );
            },
                child: Text('Sign in with Google'))
          ],
        ),
      ),
    );
  }
}