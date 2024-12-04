import 'package:flutter/material.dart';

class SortingAlgorithmsPage extends StatelessWidget {
  const SortingAlgorithmsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sorting Algorithms'),
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
