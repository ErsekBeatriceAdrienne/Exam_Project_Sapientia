import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget
{
  final String? userId;

  const ProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Text('Email: $userId'),
      ),
    );
  }
}