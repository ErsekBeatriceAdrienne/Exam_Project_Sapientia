import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../helpers/essentials.dart';
import '../../customClasses/custom_bottomnavigationbar.dart';
import '../../customClasses/custom_sidemenu.dart';
import '../registration/register_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class LoginPage extends StatefulWidget {
  final VoidCallback toggleTheme;

  const LoginPage({required this.toggleTheme, super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late AnimationController _controller;
  late Animation<Offset> _animation;
  late Animation<Color?> _colorAnimation;

  // State variable for password visibility
  bool _obscurePassword = true;
  String? emailError;
  String? passwordError;

  Future<void> _handleLogin() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    setState(() {
      emailError = null;
      passwordError = null;
    });

    if (email.isEmpty || password.isEmpty) {
      _showMessage("Please fill in both fields.");
      setState(() {
        if (email.isEmpty) emailError = 'Email cannot be empty';
        if (password.isEmpty) passwordError = 'Password cannot be empty';
      });
      return;
    }

    if (!validator.email(email)) {
      _showMessage("Please enter a valid email address.");
      setState(() {
        emailError = 'Invalid email address';
      });
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String? userId = userCredential.user?.uid;
      var userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();

      if (userSnapshot.exists) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', userId!);
        Widget nextPage;

        if (!kIsWeb && Platform.isWindows) {
          nextPage = WindowsMenu(
            toggleTheme: widget.toggleTheme,
            userId: userId,
          );
        } else {
          nextPage = CustomBottomNavigationBar(
            toggleTheme: widget.toggleTheme,
            userId: userId,
          );
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => nextPage
          ),
        );
      } else {
        _showMessage("User data not found in Firestore.");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showMessage("No user found for that email.");
        setState(() {
          emailError = 'No user found for this email';
        });
      } else if (e.code == 'wrong-password') {
        _showMessage("Wrong password provided for that user.");
        setState(() {
          passwordError = 'Incorrect password';
        });
      } else {
        _showMessage("An error occurred: ${e.message}");
      }
    } catch (e) {
      _showMessage("An unexpected error occurred.");
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(1, 1),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Color animation for RGB effect (alternating between two colors)
    _colorAnimation = ColorTween(
      begin: Color(0xFFcdebc5),
      end: Color(0xFFcdebc5),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Make the status bar transparent
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(_animation.value.dx, _animation.value.dy),
                end: Alignment.bottomRight,
                colors: [
                  _colorAnimation.value ?? Color(0xFFb4d3b2),
                  _colorAnimation.value ?? Color(0xFFb4d3b2),
                ],
                stops: [0.2, 0.8],
              ),
            ),
            child: child,
          );
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Email TextField
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.email,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Password TextField
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        controller: passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.password,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_off : Icons.visibility,
                            ),
                            onPressed: () {
                              // Toggle password visibility
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Sign in button with less rounded corners
                    ElevatedButton(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        _handleLogin();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: isDarkMode ? Colors.black :Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.signin_text,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Register button as text only
                    TextButton(
                      onPressed: () {
                        // Trigger haptic feedback
                        HapticFeedback.lightImpact();

                        // Navigate to the Register page
                        Navigator.push(
                          context,
                          Essentials().createSlideRoute(RegisterPage(
                              toggleTheme: widget.toggleTheme
                          ),
                          ),
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.register_text,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
