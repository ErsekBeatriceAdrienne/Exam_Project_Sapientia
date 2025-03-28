import 'dart:ui';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_dsa/frontend/pages/datastructures/tree/tree_animations.dart';
import '../../../strings/datastructure_strings/tree_strings.dart';

class BSTPage extends StatefulWidget
{
  const BSTPage({Key? key}) : super(key: key);

  @override
  _BSTPageState createState() => _BSTPageState();
}

class _BSTPageState extends State<BSTPage> {
  bool _isFlipped = false;

  void _toggleFlip() {
    setState(() {
      _isFlipped = !_isFlipped; // Átváltás a forgatás állapotán
    });
  }

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
                        BSTStrings.title,
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

                    // What is a BST?
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme
                                .of(context)
                                .scaffoldBackgroundColor,
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

                              // BST description, what is a BST
                              Text(
                                BSTStrings.bst_definition,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),

                              const SizedBox(height: 10),

                              // BST code example
                              Align(
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    // BST code snippet with copy button
                                    Center(
                                      child: Stack(
                                        children: [
                                          // BST code snippet
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFDFAEE8),
                                              borderRadius: BorderRadius
                                                  .circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.15),
                                                  offset: const Offset(2, 2),
                                                  blurRadius: 6,
                                                  spreadRadius: 2,
                                                ),
                                              ],
                                            ),

                                            child: SelectableText(
                                              BSTStrings
                                                  .bst_empty_initialization,
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
                                                Clipboard.setData(ClipboardData(
                                                  text: BSTStrings
                                                      .bst_empty_initialization,));
                                                ScaffoldMessenger
                                                    .of(context)
                                                    .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Code copied!')),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    // BST explanation
                                    Text(
                                      BSTStrings.bst_animation_title,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    // Animation of the BST
                                    BSTAnimation(),

                                    const SizedBox(height: 10),

                                    // BST explanation
                                    Text(
                                      BSTStrings.bst_new_node_explanation,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),


                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),

                        // What is a BST question box
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
                              BSTStrings.question,
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

                    // Functions Drop down
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
                          dividerColor: Colors.transparent,),
                        child:
                        ExpansionTile(
                          title: Text(
                            BSTStrings.functions_title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme
                                  .of(context)
                                  .scaffoldBackgroundColor,
                            ),
                          ),
                          initiallyExpanded: false,
                          tilePadding: const EdgeInsets.symmetric(
                              horizontal: 16.0),
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Theme
                                    .of(context)
                                    .scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    BSTStrings.naming_meanings,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontFamily: 'Courier',
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  Center(
                                    child: GestureDetector(
                                      onTap: _toggleFlip,
                                      child: AnimatedSwitcher(
                                        duration: Duration(seconds: 1),
                                        child: _isFlipped
                                            ? Container(
                                          key: ValueKey(1),
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
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
                                              BSTNewNodeAnimation(),
                                            ],
                                          ),
                                        )
                                            : Container(
                                          key: ValueKey(2),
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
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
                                              Text(
                                                BSTStrings.func_new_node_title,
                                                style: TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                BSTStrings.func_new_node,
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
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  // New node pseudo code title
                                  Text(
                                    BSTStrings.func_new_node_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // New node function header
                                  /*Center(
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
                                            BSTStrings.func_new_node_code,
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
                                              Clipboard.setData(ClipboardData(text: BSTStrings.func_new_node_code));
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),*/
                                  // New node pseudo code
                                  Text(
                                    BSTStrings.func_new_node,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontFamily: 'Courier',
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Insert pseudo code title
                                  Text(
                                    BSTStrings.func_inserting_element_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Insert function header
                                  /*Center(
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
                                            BSTStrings.func_new_node_code,
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
                                              Clipboard.setData(ClipboardData(text: BSTStrings.func_new_node_code));
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),*/
                                  // Insert pseudo code
                                  Text(
                                    BSTStrings.func_inserting_element,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontFamily: 'Courier',
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Inorder traversal pseudo code title
                                  Text(
                                    BSTStrings.func_inorder_traversal_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Inorder traversal pseudo code
                                  Text(
                                    BSTStrings.func_inorder_traversal,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontFamily: 'Courier',
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Min value node pseudo code title
                                  Text(
                                    BSTStrings.func_min_node_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Min value node pseudo code
                                  Text(
                                    BSTStrings.func_min_node,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontFamily: 'Courier',
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Max value node pseudo code title
                                  Text(
                                    BSTStrings.func_max_node_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Max value node pseudo code
                                  Text(
                                    BSTStrings.func_max_node,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontFamily: 'Courier',
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Delete pseudo code title
                                  Text(
                                    BSTStrings.func_delete_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Delete pseudo code
                                  Text(
                                    BSTStrings.func_delete,
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

                    const SizedBox(height: 10),
/*
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
                            BSTStrings.code_functions_title,
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

                                  // New node pseudo code title
                                  Text(
                                    BSTStrings.func_new_node_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // New node pseudo code comment
                                  Text(
                                    BSTStrings.func_new_node_comment,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // New node code with copy button
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
                                            BSTStrings.func_new_node_code,
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
                                              Clipboard.setData(ClipboardData(text: BSTStrings.func_new_node_code));
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Insert title
                                  Text(
                                    BSTStrings.func_inserting_element_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Insert comment
                                  Text(
                                    BSTStrings.func_inserting_element_comment,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Insert and copy button
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
                                            BSTStrings.func_inserting_element_code,
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
                                              Clipboard.setData(ClipboardData(text: BSTStrings.func_inserting_element_code,));
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Inorder traversal code title
                                  Text(
                                    BSTStrings.func_inorder_traversal_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Inorder traversal code comment
                                  Text(
                                    BSTStrings.func_inorder_traversal_comment,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Inorder traversal code and copy button
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
                                            BSTStrings.func_inorder_traversal_code,
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
                                              Clipboard.setData(ClipboardData(text: BSTStrings.func_inorder_traversal_code,));
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Min value node code title
                                  Text(
                                    BSTStrings.func_min_node_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Min value node code comment
                                  Text(
                                    BSTStrings.func_min_node_comment,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Min value node code and copy button
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
                                            BSTStrings.func_min_node_code,
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
                                              Clipboard.setData(ClipboardData(text: BSTStrings.func_min_node_code,));
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Max value node code title
                                  Text(
                                    BSTStrings.func_max_node_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Max value node code comment
                                  Text(
                                    BSTStrings.func_max_node_comment,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Max value node code and copy button
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
                                            BSTStrings.func_max_node_code,
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
                                              Clipboard.setData(ClipboardData(text: BSTStrings.func_max_node_code,));
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Delete title
                                  Text(
                                    BSTStrings.func_delete_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Delete comment
                                  Text(
                                    BSTStrings.func_delete_comment,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Delete and copy button
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
                                            BSTStrings.func_delete_code,
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
                                              Clipboard.setData(ClipboardData(text: BSTStrings.func_delete_code,));
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
*/
                    const SizedBox(height: 40),

                  ],
                ),
              ),
            ),

          ],
        )
    );
  }
}
