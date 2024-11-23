import 'package:flutter/material.dart';

class QueuePage extends StatelessWidget {
  const QueuePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Queue'),
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
