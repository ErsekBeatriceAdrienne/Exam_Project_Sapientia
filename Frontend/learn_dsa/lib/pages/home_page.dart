import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'customClasses/custom_scaffold.dart';

class HomePage extends StatelessWidget
{
  final VoidCallback toggleTheme;
  final String? userId;

  const HomePage({Key? key, required this.toggleTheme, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return CustomScaffold (
      toggleTheme: toggleTheme,
      userId: userId,
      appBar: AppBar(
        title: const Text('Home'),
      ),

      body: const Center (

      ),
    );
  }
}
