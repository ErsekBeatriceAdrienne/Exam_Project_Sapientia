import 'dart:io';
import 'package:flutter/material.dart';
import 'package:learn_dsa/frontend/pages/splashscreen/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../customClasses/custom_bottomnavigationbar.dart';
import '../customClasses/custom_sidemenu.dart';

class InitialSplash extends StatefulWidget {
  final Function(Widget) onInitializationComplete;
  final VoidCallback toggleTheme;

  const InitialSplash({
    super.key,
    required this.onInitializationComplete,
    required this.toggleTheme,
  });

  @override
  _InitialSplashState createState() => _InitialSplashState();
}

class _InitialSplashState extends State<InitialSplash> {
  String? _userId;

  @override
  void initState() {
    super.initState();
    _startInitialization();
  }

  Future<void> _startInitialization() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    Widget nextScreen;
    if (Platform.isWindows) {
      nextScreen = WindowsMenu(
        toggleTheme: widget.toggleTheme,
        userId: userId!,
      );
    } else {
      nextScreen = CustomBottomNavigationBar(
        toggleTheme: widget.toggleTheme,
        userId: userId,
      );
    }

    widget.onInitializationComplete(nextScreen);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SplashScreen(toggleTheme: widget.toggleTheme, userId: _userId),
      ),
    );
  }
}
