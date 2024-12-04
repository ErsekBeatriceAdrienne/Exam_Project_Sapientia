import 'package:flutter/material.dart';

class HashTablePage extends StatelessWidget {
  const HashTablePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hash Table'),
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
