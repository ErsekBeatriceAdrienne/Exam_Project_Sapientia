import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget
{
  final VoidCallback toggleTheme;
  const LoginPage({required this.toggleTheme, super.key});
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

// supabase
final supabase = Supabase.instance.client;

class _LoginPageState extends State<LoginPage>
{
  String? _userId;

  @override
  void initState()
  {
    super.initState();

    // Listen for authentication state changes
    supabase.auth.onAuthStateChange.listen((onData)
    {
      setState(() {
        _userId = onData.session?.user.id;
        if (_userId != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                toggleTheme: widget.toggleTheme,
                userId: _userId,
              ),
            ),
          );
        }
      });
    });
  }

  Future < void > _nativeGoogleSignIn() async
  {
    const webClientId = '485441696681-7lt2qm26apvugkcqnos782uhkeihn46b.apps.googleusercontent.com';
    const iosClientId = '485441696681-4q2ph5npc6mn0e3h3ci57kare8soi7vu.apps.googleusercontent.com';
    const androidClientId = '485441696681-c11mgobo2u777so6sgknfuo2hhtuer67.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: Platform.isAndroid ? androidClientId : iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null || idToken == null)
    {
      throw 'No Access Token or ID Token found.';
    }

    await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  @override
  Widget build(BuildContext context)
  {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: FloatingActionButton.extended(
              onPressed: () async {
                HapticFeedback.mediumImpact();
                await _nativeGoogleSignIn();
              },
              icon: Image.asset(
                'assets/images/google_logo.png',
                height: 32,
                width: 32,
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
                HapticFeedback.mediumImpact();
                widget.toggleTheme();
              },
            ),
          ),
        ],
      ),
    );
  }
}
