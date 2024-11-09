import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:learn_dsa/pages/customClasses/custom_bottomnavigationbar.dart';
import 'package:learn_dsa/pages/profile/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget
{
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State <MyApp>
{
  ThemeMode _themeMode = ThemeMode.light;
  bool _isLoading = true;
  Widget? _initialScreen;

  @override
  void initState()
  {
    super.initState();
    _checkLoginStatus();
  }

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  Future <void> _checkLoginStatus() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    setState(()
    {
      _initialScreen = userId != null
          ? CustomBottomNavigationBar(toggleTheme: _toggleTheme, userId: userId,)
          : LoginPage(toggleTheme: _toggleTheme);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context)
  {
    if (_isLoading)
    {
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return MaterialApp(
      title: 'Learn DSA',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: _themeMode,
      home: _initialScreen,
    );
  }
}