import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_dsa/pages/home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:learn_dsa/pages/profile/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async
{
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
  const MyApp ( { super.key } );

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
{
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme()
  {
    setState(()
    {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context)
  {
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
      home: SplashScreen(toggleTheme: _toggleTheme),//LoginPage(toggleTheme: _toggleTheme),
    );
  }
}

class SplashScreen extends StatelessWidget
{
  final VoidCallback toggleTheme;

  const SplashScreen({Key? key, required this.toggleTheme}) : super(key: key);

  Future <void> _checkLoginStatus(BuildContext context) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    if (userId != null)
    {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(toggleTheme: toggleTheme, userId: userId),
        ),
      );
    }
    else
    {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(toggleTheme: toggleTheme),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context)
  {
    _checkLoginStatus(context);
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
