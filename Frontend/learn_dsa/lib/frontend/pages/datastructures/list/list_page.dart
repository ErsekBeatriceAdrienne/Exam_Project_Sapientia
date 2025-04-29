import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../strings/datastructure_strings/list_strings.dart';
import 'animations/dlist_backwardTraversal.dart';
import 'animations/dlist_forwardTraversal.dart';
import 'animations/list_deleteFromBeginning.dart';
import 'animations/list_deleteFromEnd.dart';
import 'animations/list_deleteNode.dart';
import 'animations/list_insertAfter.dart';
import 'animations/list_insertAtBeginning.dart';
import 'animations/list_insertEnd.dart';
import 'animations/list_insertSorted.dart';
import 'animations/list_newNode.dart';
import 'animations/list_sort.dart';
import 'list_animations.dart';

class ListPage extends StatelessWidget
{
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      ListStrings.title,
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

                  // What is a singly linked list?
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

                            // List description
                            Text(
                              ListStrings.list_definition,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),

                            const SizedBox(height: 10),

                            // List code example
                            Align(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  // List code snippet with copy button
                                  Center(
                                    child: Stack(
                                      children: [
                                        // List code snippet
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
                                            ListStrings.list_empty_initialization,
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
                                              Clipboard.setData(ClipboardData(text: ListStrings.list_empty_initialization,));
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // List explanation
                                  Text(
                                    ListStrings.list_explanation,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Animation of the list
                                  LinkedListAnimation(),

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
                            ListStrings.question,
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
                          ListStrings.functions_title,
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

                                // New node pseudo code title
                                Text(
                                  ListStrings.func_new_node_title,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                // New node pseudo code
                                Text(
                                  ListStrings.func_new_node_comment,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontFamily: 'Courier',
                                  ),
                                ),
                                Center(
                                  child: LinkedListNewNodeAnimation(),
                                ),

                                const SizedBox(height: 10),

                                // Empty pseudo code title
                                Text(
                                  ListStrings.func_empty_list_title,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                // Empty pseudo code
                                Text(
                                  ListStrings.func_empty_list_comment,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontFamily: 'Courier',
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // Search node pseudo code title
                                Text(
                                  ListStrings.func_search_list_title,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                // Search node pseudo code
                                Text(
                                  ListStrings.func_search_list_comment,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontFamily: 'Courier',
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // Insert node at beginning pseudo code title
                                Text(
                                  ListStrings.func_insert_node_at_beginning_title,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                // Insert node at beginning pseudo code
                                Text(
                                  ListStrings.func_insert_node_at_beginning_comment,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontFamily: 'Courier',
                                  ),
                                ),
                                Center(
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      double dynamicHeight = constraints.maxHeight * 0.2;
                                      return SizedBox(
                                        height: dynamicHeight.clamp(150.0, 200.0),
                                        child: LinkedListInsertAtBeginning(),
                                      );
                                    },
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // Insert node after pseudo code title
                                Text(
                                  ListStrings.func_insert_node_after_title,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                // Insert node after pseudo code
                                Text(
                                  ListStrings.func_insert_node_after_comment,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontFamily: 'Courier',
                                  ),
                                ),
                                Center(
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      double dynamicHeight = constraints.maxHeight * 0.2;
                                      return SizedBox(
                                        height: dynamicHeight.clamp(150.0, 200.0),
                                        child: LinkedListInsertAfterNode(),
                                      );
                                    },
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // Insert node at end pseudo code title
                                Text(
                                  ListStrings.func_insert_node_at_end_title,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                // Insert node at end pseudo code
                                Text(
                                  ListStrings.func_insert_node_at_end_comment,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontFamily: 'Courier',
                                  ),
                                ),
                                Center(
                                  child: SizedBox(
                                    height: 200,
                                    child: LinkedListInsertAtEndNode(),
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // Deleting element from beginning pseudo code title
                                Text(
                                  ListStrings.func_delete_from_beginning_list_title,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                // Deleting element from beginning pseudo code
                                Text(
                                  ListStrings.func_delete_from_beginning_comment,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontFamily: 'Courier',
                                  ),
                                ),
                                Center(
                                  child: SizedBox(
                                    height: 200,
                                    child: LinkedListDeleteFromBeginningNode(),
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // Deleting element pseudo code title
                                Text(
                                  ListStrings.func_delete_node_list_title,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                // Deleting element pseudo code
                                Text(
                                  ListStrings.func_delete_node_comment,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontFamily: 'Courier',
                                  ),
                                ),
                                Center(
                                  child: SizedBox(
                                    height: 200,
                                    child: LinkedListDeleteNode(),
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // Deleting element from end pseudo code title
                                Text(
                                  ListStrings.func_delete_from_end_list_title,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                // Deleting element from end pseudo code
                                Text(
                                  ListStrings.func_delete_from_end_comment,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontFamily: 'Courier',
                                  ),
                                ),
                                Center(
                                  child: SizedBox(
                                    height: 200,
                                    child: LinkedListDeleteFromEndNode(),
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // Print list pseudo code title
                                Text(
                                  ListStrings.func_print_list_title,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                // Print list pseudo code
                                Text(
                                  ListStrings.func_print_comment,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontFamily: 'Courier',
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // Sort list pseudo code title
                                Text(
                                  ListStrings.func_sort_list_title,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                // Sort list pseudo code
                                Text(
                                  ListStrings.func_sort_comment,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontFamily: 'Courier',
                                  ),
                                ),
                                Center(
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      double dynamicHeight = constraints.maxHeight * 0.2;
                                      return SizedBox(
                                        height: dynamicHeight.clamp(100.0, 200.0),
                                        child: LinkedListSortAnimation(),
                                      );
                                    },
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // Insert into sorted list pseudo code title
                                Text(
                                  ListStrings.func_insert_into_sorted_list_title,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                // Insert into sorted list pseudo code
                                Text(
                                  ListStrings.func_insert_into_sorted_comment,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontFamily: 'Courier',
                                  ),
                                ),
                                Center(
                                  child: SizedBox(
                                    height: 200,
                                    child: LinkedListInsertSortedNode(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // What is a doubly linked list?
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

                            // List description
                            Text(
                              ListStrings.list_definition1,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),

                            const SizedBox(height: 10),

                            // List code example
                            Align(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  // List code snippet with copy button
                                  Center(
                                    child: Stack(
                                      children: [
                                        // List code snippet
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
                                            ListStrings.list_empty_initialization1,
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
                                              Clipboard.setData(ClipboardData(text: ListStrings.list_empty_initialization1));
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // List explanation
                                  Text(
                                    ListStrings.list_explanation1,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Animation of the list
                                  DoublyLinkedListAnimation(),

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
                            ListStrings.question1,
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

                  // Pseudocode doubly Drop down
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
                          ListStrings.functions_title,
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

                                // New node pseudo code title
                                Text(
                                  ListStrings.func_new_node_title1,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                // New node pseudo code
                                Text(
                                  ListStrings.func_new_node_comment1,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontFamily: 'Courier',
                                  ),
                                ),
                                Center(
                                  child: SizedBox(
                                    child: DoublyLinkedListNewNodeAnimation(),
                                  ),
                                ),

                                // Empty pseudo code title
                                Text(
                                  ListStrings.func_empty_list_title1,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                // Empty pseudo code
                                Text(
                                  ListStrings.func_empty_list_comment1,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontFamily: 'Courier',
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // Insert node at beginning pseudo code title
                                Text(
                                  ListStrings.func_insert_node_at_beginning_title1,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                // Insert node at beginning pseudo code
                                Text(
                                  ListStrings.func_insert_node_at_beginning_comment1,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontFamily: 'Courier',
                                  ),
                                ),
                                /*Center(
                                  child: SizedBox(
                                    height: 200,
                                    child: LinkedListInsertAtBeginning(),
                                  ),
                                ),*/

                                const SizedBox(height: 10),

                                // Insert node after pseudo code title
                                Text(
                                  ListStrings.func_insert_node_after_title1,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                // Insert node after pseudo code
                                Text(
                                  ListStrings.func_insert_node_after_comment1,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontFamily: 'Courier',
                                  ),
                                ),
                                /*Center(
                                  child: SizedBox(
                                    height: 200,
                                    child: LinkedListInsertAfterNode(),
                                  ),
                                ),*/

                                const SizedBox(height: 10),

                                // Insert node at end pseudo code title
                                Text(
                                  ListStrings.func_insert_node_at_end_title1,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                // Insert node at end pseudo code
                                Text(
                                  ListStrings.func_insert_node_at_end_comment1,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontFamily: 'Courier',
                                  ),
                                ),
                                /*Center(
                                  child: SizedBox(
                                    height: 200,
                                    child: LinkedListInsertAtEndNode(),
                                  ),
                                ),*/

                                const SizedBox(height: 10),

                                // Deleting element from beginning pseudo code title
                                Text(
                                  ListStrings.func_delete_from_beginning_list_title1,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                // Deleting element from beginning pseudo code
                                Text(
                                  ListStrings.func_delete_from_beginning_comment1,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontFamily: 'Courier',
                                  ),
                                ),
                                /*Center(
                                  child: SizedBox(
                                    height: 200,
                                    child: LinkedListDeleteFromBeginningNode(),
                                  ),
                                ),*/

                                const SizedBox(height: 10),

                                // Deleting element pseudo code title
                                Text(
                                  ListStrings.func_delete_node_list_title1,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                // Deleting element pseudo code
                                Text(
                                  ListStrings.func_delete_node_comment1,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontFamily: 'Courier',
                                  ),
                                ),
                                /*Center(
                                  child: SizedBox(
                                    height: 200,
                                    child: LinkedListDeleteNode(),
                                  ),
                                ),*/

                                const SizedBox(height: 10),

                                // Deleting element from end pseudo code title
                                Text(
                                  ListStrings.func_delete_from_end_list_title1,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                // Deleting element from end pseudo code
                                Text(
                                  ListStrings.func_delete_from_end_comment1,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontFamily: 'Courier',
                                  ),
                                ),
                                /*Center(
                                  child: SizedBox(
                                    height: 200,
                                    child: LinkedListDeleteFromEndNode(),
                                  ),
                                ),*/

                                const SizedBox(height: 10),

                                // Forward traversal pseudo code title
                                Text(
                                  ListStrings.func_forward_traversal_list_title1,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                // Forward traversal pseudo code
                                Text(
                                  ListStrings.func_forward_traversal_list_comment1,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontFamily: 'Courier',
                                  ),
                                ),
                                /*Center(
                                  child: SizedBox(
                                    height: 200,
                                    child: DoublyLinkedListForwardTraversalAnimation(),
                                  ),
                                ),*/

                                const SizedBox(height: 10),

                                // Backward traversal pseudo code title
                                Text(
                                  ListStrings.func_backward_traversal_list_title1,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                // Backward traversal pseudo code
                                Text(
                                  ListStrings.func_backward_traversal_list_comment1,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontFamily: 'Courier',
                                  ),
                                ),
                                /*Center(
                                  child: SizedBox(
                                    height: 200,
                                    child: DoublyLinkedListBackwardTraversalAnimation(),
                                  ),
                                ),*/

                                const SizedBox(height: 10),

                                // Search node pseudo code title
                                Text(
                                  ListStrings.func_search_list_title1,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                // Search node pseudo code
                                Text(
                                  ListStrings.func_search_list_comment1,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontFamily: 'Courier',
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Code Drop down
                  /*Container(
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
                          ListStrings.code_functions_title,
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

                                // New Node pseudo code title
                                Text(
                                  ListStrings.func_new_node_title,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                                // New Node pseudo code comment
                                Text(
                                  ListStrings.func_new_node_explanation,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                                // New Node code with copy button
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
                                          ListStrings.func_new_node,
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
                                            Clipboard.setData(ClipboardData(text: ListStrings.func_new_node,));
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
                                  ListStrings.func_empty_list_title,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                                // Empty code comment
                                Text(
                                  ListStrings.func_empty_list_explanation,
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
                                          ListStrings.func_empty_list,
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
                                            Clipboard.setData(ClipboardData(text: ListStrings.func_empty_list,));
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // Search Node code title
                                Text(
                                  ListStrings.func_search_list_title,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                                // Search Node code comment
                                Text(
                                  ListStrings.func_search_list_explanation,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                                // Search Node code and copy button
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
                                          ListStrings.func_search_list,
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
                                            Clipboard.setData(ClipboardData(text: ListStrings.func_search_list,));
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // Insert At Beginning code title
                                Text(
                                  ListStrings.func_insert_node_at_beginning_title,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                                // Insert At Beginning code comment
                                Text(
                                  ListStrings.func_insert_node_at_beginning_explanation,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                                // Insert At Beginning code and copy button
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
                                          ListStrings.func_insert_node_at_beginning,
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
                                            Clipboard.setData(ClipboardData(text: ListStrings.func_insert_node_at_beginning,));
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // Insert After code title
                                Text(
                                  ListStrings.func_insert_node_after_title,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                                // Insert After code comment
                                Text(
                                  ListStrings.func_insert_node_after_explanation,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                                // Insert After code and copy button
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
                                          ListStrings.func_insert_node_after,
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
                                            Clipboard.setData(ClipboardData(text: ListStrings.func_insert_node_after,));
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // Insert At End code title
                                Text(
                                  ListStrings.func_insert_node_at_end_title,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                                // Insert At End code comment
                                Text(
                                  ListStrings.func_insert_node_at_end_explanation,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                                // Insert At End code and copy button
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
                                          ListStrings.func_insert_node_at_end,
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
                                            Clipboard.setData(ClipboardData(text: ListStrings.func_insert_node_at_end,));
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // Delete From Beginning code title
                                Text(
                                  ListStrings.func_delete_from_beginning_list_title,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                                // Delete From Beginning code comment
                                Text(
                                  ListStrings.func_delete_from_beginning_list_explanation,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                                // Delete From Beginning code and copy button
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
                                          ListStrings.func_delete_from_beginning_list,
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
                                            Clipboard.setData(ClipboardData(text: ListStrings.func_delete_from_beginning_list,));
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // Delete Node code title
                                Text(
                                  ListStrings.func_delete_node_list_title,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                                // Delete Node code comment
                                Text(
                                  ListStrings.func_delete_node_list_explanation,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                                // Delete Node code and copy button
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
                                          ListStrings.func_delete_node_list,
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
                                            Clipboard.setData(ClipboardData(text: ListStrings.func_delete_node_list,));
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // Delete From End code title
                                Text(
                                  ListStrings.func_delete_from_end_list_title,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                                // Delete From End code comment
                                Text(
                                  ListStrings.func_delete_from_end_list_explanation,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                                // Delete From End code and copy button
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
                                          ListStrings.func_delete_from_end_list,
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
                                            Clipboard.setData(ClipboardData(text: ListStrings.func_delete_from_end_list,));
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // Print code title
                                Text(
                                  ListStrings.func_print_list_title,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                                // Print code comment
                                Text(
                                  ListStrings.func_print_list_explanation,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                                // Print code and copy button
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
                                          ListStrings.func_print_list,
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
                                            Clipboard.setData(ClipboardData(text: ListStrings.func_print_list,));
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // Sort list code title
                                Text(
                                  ListStrings.func_sort_list_title,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                                // Sort list code comment
                                Text(
                                  ListStrings.func_sort_list_explanation,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                                // Sort list code and copy button
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
                                          ListStrings.func_sort_list,
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
                                            Clipboard.setData(ClipboardData(text: ListStrings.func_sort_list,));
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // Insert into sorted list code title
                                Text(
                                  ListStrings.func_insert_into_sorted_list_title,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                                // Insert into sorted list code comment
                                Text(
                                  ListStrings.func_insert_into_sorted_list_explanation,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                                // Insert into sorted list and copy button
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
                                          ListStrings.func_insert_into_sorted_list,
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
                                            Clipboard.setData(ClipboardData(text: ListStrings.func_insert_into_sorted_list,));
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
                  ),*/

                  const SizedBox(height: 40),

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}

