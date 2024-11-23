import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List'),
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
