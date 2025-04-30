import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../strings/datastructure_strings/array_strings.dart';
import 'animations/array_allocating.dart';
import 'animations/array_deleteAt.dart';
import 'animations/array_insertAt.dart';
import 'animations/array_insertFirst.dart';
import 'animations/array_insertLast.dart';
import 'array_animations.dart';

class ArrayPage extends StatelessWidget
{
  final VoidCallback toggleTheme;
  final String? userId;

  const ArrayPage({Key? key, required this.toggleTheme, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              pinned: true,
              floating: false,
              expandedHeight: 70,
              flexibleSpace: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    color: Theme
                        .of(context)
                        .scaffoldBackgroundColor
                        .withOpacity(0.2),
                    child: FlexibleSpaceBar(
                      titlePadding: EdgeInsets.only(left: 40, bottom: 20),
                      title: Text(
                        ArrayStrings.title,
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

            // Main Content as a SliverList
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [

                    const SizedBox(height: 15),

                    // What is an array?
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              // Array description, what is an array
                              Text(
                                ArrayStrings.array_definition,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),

                              const SizedBox(height: 10),

                              // Struct array code example
                              Align(
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    // Struct array code snippet with copy button
                                    Center(
                                      child: Stack(
                                        children: [
                                          // Static array code snippet
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            margin: const EdgeInsets.only(bottom: 10),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFDFAEE8),
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
                                              ArrayStrings.struct_array_empty_initialization,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'monospace',
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
                                                Clipboard.setData(ClipboardData(text: ArrayStrings.struct_array_empty_initialization,));
                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    // Struct array explanation
                                    Text(
                                      ArrayStrings.struct_array_animation_title,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    // Animation of the struct array
                                    AnimatedArrayWidget(),

                                    const SizedBox(height: 10),

                                    // Struct array explanation
                                    Text(
                                      ArrayStrings.struct_array_allocating_explanation,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),

                        // What is an array question box
                        Positioned(
                          top: -23,
                          left: 16,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                // Gradient colors
                                colors: [Color(0xFFa1f7ff), Color(0xFFDFAEE8)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 8.0,
                            ),
                            child: Text(
                              ArrayStrings.question,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Pseudocode Drop down
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          // Gradient colors
                          colors: [Color(0xFFa1f7ff), Color(0xFFDFAEE8)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Theme(
                        data: Theme.of(context).copyWith(dividerColor: Colors.transparent,),
                        child:
                        ExpansionTile(
                          title: Text(
                            ArrayStrings.functions_title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                          initiallyExpanded: false,
                          tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  // Pseudocode parameters used
                                  Text(
                                    ArrayStrings.pseudo_code_explanation_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    ArrayStrings.pseudo_code_explanation,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),

                                  const SizedBox(height: 30),

                                  // Allocating memory pseudo code title
                                  Text(
                                    ArrayStrings.func_allocating_memory_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Allocating memory pseudo code
                                  Text(
                                    ArrayStrings.func_allocating_memory,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontFamily: 'Courier',
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Center(
                                    child: ArrayAllocationWidget(),
                                  ),

                                  const SizedBox(height: 10),

                                  // Printing pseudo code title
                                  Text(
                                    ArrayStrings.func_printing_array_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Printing pseudo code
                                  Text(
                                    ArrayStrings.func_printing_array,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontFamily: 'Courier',
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Inserting first pseudo code title
                                  Text(
                                    ArrayStrings.func_inserting_element_first_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Inserting first pseudo code
                                  Text(
                                    ArrayStrings.func_inserting_element_first,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontFamily: 'Courier',
                                    ),
                                  ),
                                  Center(
                                    child: ArrayInsertFirstWidget(),
                                  ),

                                  const SizedBox(height: 10),

                                  // Inserting at pseudo code title
                                  Text(
                                    ArrayStrings.func_inserting_element_at_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Inserting at pseudo code
                                  Text(
                                    ArrayStrings.func_inserting_element_at,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontFamily: 'Courier',
                                    ),
                                  ),
                                  Center(
                                    child: ArrayInsertAtWidget(),
                                  ),

                                  const SizedBox(height: 10),

                                  // Inserting last pseudo code title
                                  Text(
                                    ArrayStrings.func_inserting_element_last_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Inserting last pseudo code
                                  Text(
                                    ArrayStrings.func_inserting_element_last,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontFamily: 'Courier',
                                    ),
                                  ),
                                  Center(
                                    child: ArrayInsertLastWidget(),
                                  ),

                                  const SizedBox(height: 10),

                                  // Get item at pseudo code title
                                  Text(
                                    ArrayStrings.func_getitem_at_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Get item at pseudo code
                                  Text(
                                    ArrayStrings.func_getitem_at,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontFamily: 'Courier',
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Empty pseudo code title
                                  Text(
                                    ArrayStrings.func_empty_array_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Empty pseudo code
                                  Text(
                                    ArrayStrings.func_empty_array,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontFamily: 'Courier',
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Full pseudo code title
                                  Text(
                                    ArrayStrings.func_full_array_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Full pseudo code
                                  Text(
                                    ArrayStrings.func_full_array,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontFamily: 'Courier',
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Search pseudo code title
                                  Text(
                                    ArrayStrings.func_search_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Search pseudo code
                                  Text(
                                    ArrayStrings.func_search,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontFamily: 'Courier',
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Deleting element pseudo code title
                                  Text(
                                    ArrayStrings.func_deleting_element_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Deleting element pseudo code
                                  Text(
                                    ArrayStrings.func_deleting_element,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontFamily: 'Courier',
                                    ),
                                  ),
                                  Center(
                                    child: ArrayDeleteAtWidget(),
                                  ),

                                  const SizedBox(height: 10),

                                  // Deallocating memory pseudo code title
                                  Text(
                                    ArrayStrings.func_deallocating_array_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Deallocating memory pseudo code
                                  Text(
                                    ArrayStrings.func_deallocating_array,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontFamily: 'Courier',
                                    ),
                                  ),

                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /*Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [


                              // Pseudocode parameters used
                              Text(
                                ArrayStrings.pseudo_code_explanation_title,
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                ArrayStrings.pseudo_code_explanation,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),

                              const SizedBox(height: 30),

                              // Allocating memory pseudo code title
                              Text(
                                ArrayStrings.func_allocating_memory_title,
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              // Allocating memory pseudo code
                              Text(
                                ArrayStrings.func_allocating_memory,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontFamily: 'Courier',
                                ),
                              ),
                              const SizedBox(height: 10),
                              Center(
                                child: ArrayAllocationWidget(),
                              ),

                              const SizedBox(height: 10),

                              // Printing pseudo code title
                              Text(
                                ArrayStrings.func_printing_array_title,
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              // Printing pseudo code
                              Text(
                                ArrayStrings.func_printing_array,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontFamily: 'Courier',
                                ),
                              ),

                              const SizedBox(height: 10),

                              // Inserting first pseudo code title
                              Text(
                                ArrayStrings.func_inserting_element_first_title,
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              // Inserting first pseudo code
                              Text(
                                ArrayStrings.func_inserting_element_first,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontFamily: 'Courier',
                                ),
                              ),
                              Center(
                                child: ArrayInsertFirstWidget(),
                              ),

                              const SizedBox(height: 10),

                              // Inserting at pseudo code title
                              Text(
                                ArrayStrings.func_inserting_element_at_title,
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              // Inserting at pseudo code
                              Text(
                                ArrayStrings.func_inserting_element_at,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontFamily: 'Courier',
                                ),
                              ),
                              Center(
                                child: ArrayInsertAtWidget(),
                              ),

                              const SizedBox(height: 10),

                              // Inserting last pseudo code title
                              Text(
                                ArrayStrings.func_inserting_element_last_title,
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              // Inserting last pseudo code
                              Text(
                                ArrayStrings.func_inserting_element_last,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontFamily: 'Courier',
                                ),
                              ),
                              Center(
                                child: ArrayInsertLastWidget(),
                              ),

                              const SizedBox(height: 10),

                              // Get item at pseudo code title
                              Text(
                                ArrayStrings.func_getitem_at_title,
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              // Get item at pseudo code
                              Text(
                                ArrayStrings.func_getitem_at,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontFamily: 'Courier',
                                ),
                              ),

                              const SizedBox(height: 10),

                              // Empty pseudo code title
                              Text(
                                ArrayStrings.func_empty_array_title,
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              // Empty pseudo code
                              Text(
                                ArrayStrings.func_empty_array,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontFamily: 'Courier',
                                ),
                              ),

                              const SizedBox(height: 10),

                              // Full pseudo code title
                              Text(
                                ArrayStrings.func_full_array_title,
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              // Full pseudo code
                              Text(
                                ArrayStrings.func_full_array,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontFamily: 'Courier',
                                ),
                              ),

                              const SizedBox(height: 10),

                              // Search pseudo code title
                              Text(
                                ArrayStrings.func_search_title,
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              // Search pseudo code
                              Text(
                                ArrayStrings.func_search,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontFamily: 'Courier',
                                ),
                              ),

                              const SizedBox(height: 10),

                              // Deleting element pseudo code title
                              Text(
                                ArrayStrings.func_deleting_element_title,
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              // Deleting element pseudo code
                              Text(
                                ArrayStrings.func_deleting_element,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontFamily: 'Courier',
                                ),
                              ),
                              Center(
                                child: ArrayDeleteAtWidget(),
                              ),

                              const SizedBox(height: 10),

                              // Deallocating memory pseudo code title
                              Text(
                                ArrayStrings.func_deallocating_array_title,
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              // Deallocating memory pseudo code
                              Text(
                                ArrayStrings.func_deallocating_array,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontFamily: 'Courier',
                                ),
                              ),

                              const SizedBox(height: 10),
                            ],
                          ),
                        ),

                        // Pseudocode box
                        Positioned(
                          top: -23,
                          left: 16,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                // Gradient colors
                                colors: [Color(0xFFa1f7ff), Color(0xFFDFAEE8)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 8.0,
                            ),
                            child: Text(
                              ArrayStrings.functions_title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),*/

                    const SizedBox(height: 20),

                    // Code Drop down
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          // Gradient colors
                          colors: [Color(0xFFa1f7ff), Color(0xFFDFAEE8)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          dividerColor: Colors.transparent,
                        ),
                        child:
                        ExpansionTile(
                          title: Text(
                            ArrayStrings.code_functions_title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                          initiallyExpanded: false,
                          tilePadding: const EdgeInsets.symmetric(
                              horizontal: 16.0),
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

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
                                            color: Color(0xFFDFAEE8),
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
                                              fontFamily: 'monospace',
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
                                            color: Color(0xFFDFAEE8),
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
                                              fontFamily: 'monospace',
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
                                            color: Color(0xFFDFAEE8),
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
                                              fontFamily: 'monospace',
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
                                            color: Color(0xFFDFAEE8),
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
                                              fontFamily: 'monospace',
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
                                            color: Color(0xFFDFAEE8),
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
                                              fontFamily: 'monospace',
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
                                            color: Color(0xFFDFAEE8),
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
                                              fontFamily: 'monospace',
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
                                            color: Color(0xFFDFAEE8),
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
                                              fontFamily: 'monospace',
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
                                            color: Color(0xFFDFAEE8),
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
                                              fontFamily: 'monospace',
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
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
/*
        // How could we use this is life?
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              // Examples
                              Text(
                                ArrayStrings.where_to_use,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // When to use it question box
                        Positioned(
                          top: -23,
                          left: 16,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                // Gradient colors
                                colors: [Color(0xFFa1f7ff), Color(0xFFDFAEE8)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 8.0,
                            ),
                            child: Text(
                              ArrayStrings.in_life_example,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

        // How could we use this is life?
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              // Examples
                              Text(
                                ArrayStrings.when_not_to,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // When to use it question box
                        Positioned(
                          top: -23,
                          left: 16,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                // Gradient colors
                                colors: [Color(0xFFa1f7ff), Color(0xFFDFAEE8)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 8.0,
                            ),
                            child: Text(
                              ArrayStrings.not_to_use,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

 */
                  ],
                ),
              ),
            ),

          ],
        )
    );
  }
}


