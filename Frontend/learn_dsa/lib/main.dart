import 'package:flutter/material.dart';
import 'package:learn_dsa/pages/login_page.dart';

void main()
{
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
      home: LoginPage(toggleTheme: _toggleTheme),
    );
  }
}
