import 'package:flutter/material.dart';
import '../custom_scaffold.dart';

class ArrayPage extends StatelessWidget {
  final VoidCallback toggleTheme;
  final String? userId;

  const ArrayPage({Key? key, required this.toggleTheme, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return CustomScaffold(
      toggleTheme: toggleTheme,
      userId: userId,
      appBar: AppBar(
        title: const Text(
          'Array',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 23,
          ),
        ),
        centerTitle: true,
        toolbarHeight: kToolbarHeight,
      ),
      body: SingleChildScrollView( // Make the body scrollable
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            /*Image.asset(
              'assets/images/object_array.png',
            ),*/

            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color.alphaBlend(
                  Colors.black.withOpacity(isDarkTheme ? 0.5 : 0.05), // Adjust opacity based on theme
                  Theme.of(context).colorScheme.background,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: isDarkTheme ? Colors.black54 : Colors.grey.withOpacity(0.5),
                    blurRadius: 8.0, // Softness of the shadow
                    spreadRadius: 2.0, // Size of the shadow
                    offset: const Offset(2, 2), // Position of the shadow
                  ),
                ],
              ),
              child: Align(
                alignment: Alignment.centerLeft, // Aligns the container to the left
                child: Text(
                  'This is an array',
                  style: TextStyle(
                    color: isDarkTheme ? Colors.white : Colors.black, // Adjust text color based on theme
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Image.asset(
              'assets/images/array.png',
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color.alphaBlend(
                  Colors.black.withOpacity(isDarkTheme ? 0.5 : 0.05), // Adjust opacity based on theme
                  Theme.of(context).colorScheme.background,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: isDarkTheme ? Colors.black54 : Colors.grey.withOpacity(0.5),
                    blurRadius: 8.0, // Softness of the shadow
                    spreadRadius: 2.0, // Size of the shadow
                    offset: const Offset(2, 2), // Position of the shadow
                  ),
                ],
              ),
              child: Text(
                '1. We count the objects and put a number so we know on which place is the searched object',
                style: TextStyle(
                  color: isDarkTheme ? Colors.white : Colors.black, // Adjust text color based on theme
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}
