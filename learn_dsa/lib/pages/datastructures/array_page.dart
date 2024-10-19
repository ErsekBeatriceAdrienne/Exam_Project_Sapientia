import 'package:flutter/material.dart';
import '../custom_scaffold.dart';

class ArrayPage extends StatelessWidget
{
  final VoidCallback toggleTheme;
  final String? userId;

  const ArrayPage( {Key? key, required this.toggleTheme, required this.userId} ) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return CustomScaffold (
      toggleTheme: toggleTheme,
      userId: userId,
      appBar: AppBar (
        title: const Text (
          'Array',
          style: TextStyle (
            fontWeight: FontWeight.normal,
            fontSize: 23,
          ),
        ),
        centerTitle: true,
        toolbarHeight: kToolbarHeight,
      ),
      body: Padding (
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            /*Image.asset(
              'assets/images/array.png',
              width: 200,
              height: 200,
            ),*/
            const SizedBox(height: 20), // Add spacing
            // Add more widgets as needed
          ],
        ),
      ),
    );
  }
}
