import 'package:flutter/material.dart';
import 'package:learn_dsa/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async
{
  await Supabase.initialize(
    url: 'https://xeevlbogvfvmqkdigqkf.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhlZXZsYm9ndmZ2bXFrZGlncWtmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjg3OTkzOTEsImV4cCI6MjA0NDM3NTM5MX0.Qwp3VYsSpmd5qLxbqEe-hLdzi3Y0YuARSUDjloZeXjA',
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: LoginPage(), //LoginPage(toggleTheme: _toggleTheme),
    );
  }
}