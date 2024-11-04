import 'package:flutter/material.dart';

class AlgorithmsPage extends StatelessWidget {
  final VoidCallback toggleTheme;
  final String? userId;

  const AlgorithmsPage({
    Key? key,
    required this.toggleTheme,
    this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return Center(
      child: Text(
        'Algorithms Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
