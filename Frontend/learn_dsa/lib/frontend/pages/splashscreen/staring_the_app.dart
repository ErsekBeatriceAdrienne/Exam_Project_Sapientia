import 'dart:io';

import 'package:flutter/material.dart';
import 'package:learn_dsa/frontend/pages/splashscreen/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../customClasses/custom_bottomnavigationbar.dart';
import '../customClasses/custom_sidemenu.dart';
import '../profile/login/login_page.dart';

class InitialSplash extends StatefulWidget {
  final Function(Widget) onInitializationComplete;
  final VoidCallback toggleTheme;

  const InitialSplash({
    Key? key,
    required this.onInitializationComplete,
    required this.toggleTheme,
  }) : super(key: key);

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

    setState(() {
      _userId = userId;
    });

    Widget nextScreen;
    if (Platform.isWindows) {
      nextScreen = userId != null
          ? WindowsMenu(toggleTheme: widget.toggleTheme, userId: userId)
          : LoginPage(toggleTheme: widget.toggleTheme);
    } else {
      nextScreen = userId != null
          ? CustomBottomNavigationBar(toggleTheme: widget.toggleTheme, userId: userId)
          : LoginPage(toggleTheme: widget.toggleTheme);
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
