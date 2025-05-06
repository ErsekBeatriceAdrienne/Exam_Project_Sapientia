import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../helpers/essentials.dart';
import '../../../strings/datastructure_strings/array_strings.dart';
import 'array_page.dart';

class ImplementationArrayPage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final String? userId;

  const ImplementationArrayPage({Key? key, required this.toggleTheme, required this.userId}) : super(key: key);

  @override
  State<ImplementationArrayPage> createState() => _ImplementationArrayPageState();
}

class _ImplementationArrayPageState extends State<ImplementationArrayPage> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            pinned: true,
            floating: false,
            expandedHeight: 70,
            leadingWidth: 90,
            automaticallyImplyLeading: false,
            leading: TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: Colors.green,
                padding: const EdgeInsets.only(left: 8.0),
              ),
              onPressed: () {
                Navigator.pop(
                  context,
                  Essentials().createSlideRoute(ArrayPage(toggleTheme: widget.toggleTheme, userId: widget.userId),
                  ),
                );
              },

              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
              ),
              label: const Text(
                'Back',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 17,
                ),
              ),
            ),
            centerTitle: true,
            title: Text(
              ArrayStrings.code_functions_title,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF255f38),
              ),
            ),
            flexibleSpace: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  color: Theme
                      .of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.2),
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  // Allocating memory pseudo code title
                  Text(
                    ArrayStrings.func_allocating_memory_title,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  // Allocating memory pseudo code comment
                  Text(
                    ArrayStrings.allocating_memory_function_comment,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  // Allocating array code with copy button
                  Center(
                    child: Stack(
                      children: [
                        // Code
                        Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Color(0xFF255f38),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                offset: const Offset(2, 2),
                                blurRadius: 6,
                                spreadRadius: 2,
                              ),
                            ],
                          ),

                          child: SelectableText(
                            ArrayStrings.allocating_memory_function,
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Monospace',
                              color: Colors.white,
                            ),
                          ),
                        ),

                        // Copy button on right up corner
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            icon: Icon(
                              Icons.copy,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: ArrayStrings.allocating_memory_function,));
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Printing code title
                  Text(
                    ArrayStrings.func_printing_array_title,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  // Printing code comment
                  Text(
                    ArrayStrings.printing_function_comment,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  // Printing code and copy button
                  Center(
                    child: Stack(
                      children: [
                        // Code
                        Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Color(0xFF255f38),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                offset: const Offset(2, 2),
                                blurRadius: 6,
                                spreadRadius: 2,
                              ),
                            ],
                          ),

                          child: SelectableText(
                            ArrayStrings.printing_function,
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Monospace',
                              color: Colors.white,
                            ),
                          ),
                        ),

                        // Copy button on right up corner
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            icon: Icon(
                              Icons.copy,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: ArrayStrings.printing_function,));
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Inserting first code title
                  Text(
                    ArrayStrings.func_inserting_element_first_title,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  // Inserting first code comment
                  Text(
                    ArrayStrings.insert_first_function_comment,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  // Inserting first code and copy button
                  Center(
                    child: Stack(
                      children: [
                        // Code
                        Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Color(0xFF255f38),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                offset: const Offset(2, 2),
                                blurRadius: 6,
                                spreadRadius: 2,
                              ),
                            ],
                          ),

                          child: SelectableText(
                            ArrayStrings.insert_first_function,
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Monospace',
                              color: Colors.white,
                            ),
                          ),
                        ),

                        // Copy button on right up corner
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            icon: Icon(
                              Icons.copy,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: ArrayStrings.insert_first_function,));
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Inserting at code title
                  Text(
                    ArrayStrings.func_inserting_element_at_title,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  // Inserting at code comment
                  Text(
                    ArrayStrings.insert_at_function_comment,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  // Inserting at code and copy button
                  Center(
                    child: Stack(
                      children: [
                        // Code
                        Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Color(0xFF255f38),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                offset: const Offset(2, 2),
                                blurRadius: 6,
                                spreadRadius: 2,
                              ),
                            ],
                          ),

                          child: SelectableText(
                            ArrayStrings.insert_at_function,
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Monospace',
                              color: Colors.white,
                            ),
                          ),
                        ),

                        // Copy button on right up corner
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            icon: Icon(
                              Icons.copy,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: ArrayStrings.insert_at_function,));
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Inserting last code title
                  Text(
                    ArrayStrings.func_inserting_element_last_title,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  // Inserting last code comment
                  Text(
                    ArrayStrings.insert_last_function_comment,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  // Inserting last code and copy button
                  Center(
                    child: Stack(
                      children: [
                        // Code
                        Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Color(0xFF255f38),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                offset: const Offset(2, 2),
                                blurRadius: 6,
                                spreadRadius: 2,
                              ),
                            ],
                          ),

                          child: SelectableText(
                            ArrayStrings.insert_last_function,
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Monospace',
                              color: Colors.white,
                            ),
                          ),
                        ),

                        // Copy button on right up corner
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            icon: Icon(
                              Icons.copy,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: ArrayStrings.insert_last_function,));
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Empty code title
                  Text(
                    ArrayStrings.func_empty_array_title,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  // Empty code comment
                  Text(
                    ArrayStrings.isempty_function_comment,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  // isEmpty code and copy button
                  Center(
                    child: Stack(
                      children: [
                        // Code
                        Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Color(0xFF255f38),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                offset: const Offset(2, 2),
                                blurRadius: 6,
                                spreadRadius: 2,
                              ),
                            ],
                          ),

                          child: SelectableText(
                            ArrayStrings.isempty_function,
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Monospace',
                              color: Colors.white,
                            ),
                          ),
                        ),

                        // Copy button on right up corner
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            icon: Icon(
                              Icons.copy,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: ArrayStrings.isempty_function,));
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Full code title
                  Text(
                    ArrayStrings.func_full_array_title,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  // Full code comment
                  Text(
                    ArrayStrings.isfull_function_comment,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  // isFull code and copy button
                  Center(
                    child: Stack(
                      children: [
                        // Code
                        Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Color(0xFF255f38),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                offset: const Offset(2, 2),
                                blurRadius: 6,
                                spreadRadius: 2,
                              ),
                            ],
                          ),

                          child: SelectableText(
                            ArrayStrings.isfull_function,
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Monospace',
                              color: Colors.white,
                            ),
                          ),
                        ),

                        // Copy button on right up corner
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            icon: Icon(
                              Icons.copy,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: ArrayStrings.isfull_function,));
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Deallocating memory code title
                  Text(
                    ArrayStrings.func_deallocating_array_title,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  // Deallocating memory code comment
                  Text(
                    ArrayStrings.deallocating_memory_function_comment,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  // Deallocating memory code and copy button
                  Center(
                    child: Stack(
                      children: [
                        // Code
                        Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Color(0xFF255f38),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                offset: const Offset(2, 2),
                                blurRadius: 6,
                                spreadRadius: 2,
                              ),
                            ],
                          ),

                          child: SelectableText(
                            ArrayStrings.deallocating_memory_function,
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Monospace',
                              color: Colors.white,
                            ),
                          ),
                        ),

                        // Copy button on right up corner
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            icon: Icon(
                              Icons.copy,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: ArrayStrings.deallocating_memory_function));
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                              );
                            },
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

  Widget _buildCardItem(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 4,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Color(0xFF27391c)),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF27391c)),
            ),
            Spacer(),
            Icon(Icons.chevron_right, color: Color(0xFF27391c)),
          ],
        ),
      ),
    );
  }
}