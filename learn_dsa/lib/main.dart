import 'package:flutter/material.dart';
import 'package:learn_dsa/pages/login_page.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:learn_dsa/pages/theme_notifier.dart';

void main() async
{
  await Supabase.initialize(
    url: 'https://xeevlbogvfvmqkdigqkf.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhlZXZsYm9ndmZ2bXFrZGlncWtmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjg3OTkzOTEsImV4cCI6MjA0NDM3NTM5MX0.Qwp3VYsSpmd5qLxbqEe-hLdzi3Y0YuARSUDjloZeXjA',
  );

  runApp(ChangeNotifierProvider(
    create: (context) => ThemeNotifier(),
    child: MyApp(),
  ),);
}

class MyApp extends StatefulWidget
{
  const MyApp({super.key});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State < MyApp >
{
  ThemeMode _themeMode = ThemeMode.light;
  Color _seedColor = Colors.blue;

  void _toggleTheme()
  {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context)
  {
    final themeNotifier = Provider.of <ThemeNotifier> (context);

    return MaterialApp(
      title: 'Learn DSA',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: themeNotifier.highlightColor,
          brightness: themeNotifier.isDarkMode ? Brightness.dark : Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seedColor,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: _themeMode,
      home: LoginPage(toggleTheme: _toggleTheme),
    );
  }
}