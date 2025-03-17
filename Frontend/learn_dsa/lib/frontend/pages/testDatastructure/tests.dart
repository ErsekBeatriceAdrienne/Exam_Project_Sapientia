import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../backend/compiler/c_compiler.dart';
import '../../strings/test/test_strings.dart';
import '../profile/test_results.dart';

class TestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Appbar title
          SliverAppBar(
            backgroundColor: Colors.transparent,
            pinned: true,
            floating: false,
            expandedHeight: 70,
            flexibleSpace: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
                  child: FlexibleSpaceBar(
                    titlePadding: EdgeInsets.only(left: 40, bottom: 20),
                    title: Text(
                      TestStrings.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFDFAEE8),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Body
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  // Donut chart
                  /*DonutChart(),

                  const SizedBox(height: 20),

                  Text(
                    TestStrings.compiler_description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),

                  // Linear Data Structure Buttons
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2.2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildCategoryButton(context, TestStrings.compiler_button, isDarkTheme),
                    ],
                  ),*/

                  // Array tests
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TestStrings.array_test_title,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          TestStrings.array_test_functions,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Stack tests
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TestStrings.stack_test_title,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          TestStrings.stack_test_functions,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Queue tests
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TestStrings.queue_test_title,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          TestStrings.queue_test_functions,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // List tests
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TestStrings.list_test_title,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          TestStrings.list_test_functions,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(BuildContext context, String title, bool isDarkTheme) {
    final gradient = LinearGradient(
      colors: [Color(0xFFa1f7ff), Color(0xFFDFAEE8)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    // Define a map for title-to-page navigation
    final pageMap = {
      "Code Compiler": () => CodeCompilerPage(),
    };

    return ElevatedButton(
      onPressed: () {
        HapticFeedback.heavyImpact();
        final pageBuilder = pageMap[title];

        if (pageBuilder != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => pageBuilder()),
          );
        } else {
          print("Page not found for title: $title");
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
      ),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: gradient,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const Positioned(
                top: 8,
                right: 8,
                child: Icon(
                  Icons.arrow_circle_right_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}


/*@override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Test Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }*/