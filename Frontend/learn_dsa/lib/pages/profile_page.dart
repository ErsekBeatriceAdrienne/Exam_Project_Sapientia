import 'package:flutter/material.dart';

import 'custom_scaffold.dart';

class ProfilePage extends StatelessWidget
{
  final VoidCallback toggleTheme;
  final String? userId;

  const ProfilePage({Key? key, required this.userId, required this.toggleTheme}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return CustomScaffold(
      toggleTheme: toggleTheme,
      userId: userId,
      appBar: AppBar(
        title: const Text('Profile'),
      ),

      body: Center(

      ),
    );
  }
}