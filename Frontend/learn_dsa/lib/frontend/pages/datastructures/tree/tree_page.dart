import 'package:flutter/material.dart';

class BSTPage extends StatelessWidget {
  const BSTPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BST'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Ez egy üres oldal',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
