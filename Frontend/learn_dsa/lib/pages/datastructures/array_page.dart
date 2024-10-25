import 'package:flutter/material.dart';
import '../../styles/app_colors.dart';
import '../custom_scaffold.dart';

class ArrayPage extends StatelessWidget
{
  final VoidCallback toggleTheme;
  final String? userId;

  const ArrayPage({Key? key, required this.toggleTheme, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return CustomScaffold(
      toggleTheme: toggleTheme,
      userId: userId,
      appBar: AppBar(
        title: const Text(
          '',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 23,
          ),
        ),
        centerTitle: true,
        toolbarHeight: kToolbarHeight,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              'Array',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.normal,
                color: isDarkTheme ? AppColors.textDark : AppColors.textLight,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDarkTheme ? AppColors.backgroundDark : AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 8.0,
                    spreadRadius: 2.0,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),

              child: Text(
                'What is an array ?!',
                style: TextStyle(
                  color: isDarkTheme ? AppColors.textDark : AppColors.textLight,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkTheme ? AppColors.primaryColorLight : AppColors.primaryColorDark,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 8.0,
                    spreadRadius: 2.0,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: const Text(
                'An array is a collection of a datatype where the elements are stored along each-other so we can access every item quickly.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Image.asset(
              'assets/images/array_photos/array.png',
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkTheme ? AppColors.primaryColorLight : AppColors.primaryColorDark,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 8.0,
                    spreadRadius: 2.0,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: const Text(
                'This is an int type array, where the elements are integer numbers. We count the amount of items from 0, not 1, because the computer memory can’t. There is a solution to this, but first let’s understand the basics.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDarkTheme ? AppColors.backgroundDark : AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 8.0,
                    spreadRadius: 2.0,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: const Text(
                'int array[ ] = { 3, 12, 4, 8, 20, 6 };',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color.alphaBlend(
                  Colors.black.withOpacity(isDarkTheme ? 0.5 : 0.05),
                  Theme.of(context).colorScheme.background,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: isDarkTheme ? Colors.black54 : Colors.grey.withOpacity(0.4),
                    blurRadius: 8.0,
                    spreadRadius: 2.0,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/array_photos/array.png',
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      'int array[5];',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
*/