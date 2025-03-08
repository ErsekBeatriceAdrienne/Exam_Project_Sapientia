import 'package:flutter/material.dart';
import '../../../backend/compiler/c_compiler.dart';

class TestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CodeCompilerPage(),
    );
  }
}