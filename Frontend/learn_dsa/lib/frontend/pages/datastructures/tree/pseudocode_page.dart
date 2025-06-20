import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_dsa/frontend/pages/datastructures/stack/stack_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../strings/datastructure_strings/tree_strings.dart';
import 'animations/tree_delete_node.dart';
import 'animations/tree_inorder.dart';
import 'animations/tree_insert.dart';
import 'animations/tree_insert_left.dart';
import 'animations/tree_insert_right.dart';
import 'animations/tree_max_value.dart';
import 'animations/tree_min_value.dart';
import 'animations/tree_new_node.dart';
import 'animations/tree_postorder.dart';
import 'animations/tree_preorder.dart';

class PseudocodeBSTPage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final String? userId;

  const PseudocodeBSTPage({super.key, required this.toggleTheme, required this.userId});

  @override
  State<PseudocodeBSTPage> createState() => _PseudocodeBSTPageState();
}

class _PseudocodeBSTPageState extends State<PseudocodeBSTPage> with SingleTickerProviderStateMixin {
  bool _showExplanation = false;
  bool isAnimating = false;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                pinned: true,
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
                      CupertinoPageRoute(
                        builder: (_) => StackPage(
                          toggleTheme: widget.toggleTheme,
                          userId: widget.userId,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                  label: Text(AppLocalizations.of(context)!.back_button_text,
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 17),
                  ),
                ),
                centerTitle: true,
                title: Text(
                  AppLocalizations.of(context)!.pseudocode_text,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF255f38),
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      _showExplanation ? Icons.help_outline : Icons.help,
                      color: const Color(0xFF255f38),
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        _showExplanation = !_showExplanation;
                      });
                    },
                  ),
                ],
                flexibleSpace: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
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
                      Text(
                        AppLocalizations.of(context)!.bt_page_title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),

                      // New node pseudo code title
                      Text(
                        AppLocalizations.of(context)!.bt_create_new_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
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
                      const SizedBox(height: 20),
                      Center(
                        child: BSTNewNodeAnimation(),
                      ),

                      const SizedBox(height: 20),

                      // Insert left pseudo code title
                      Text(
                        AppLocalizations.of(context)!.bt_insert_left_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Insert left pseudo code
                      Text(
                        BSTStrings.func_inserting_element_left,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: BinaryTreeInsertLeftAnimation(),
                      ),

                      const SizedBox(height: 20),

                      // Insert right pseudo code title
                      Text(
                        AppLocalizations.of(context)!.bt_insert_right_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Insert right pseudo code
                      Text(
                        BSTStrings.func_inserting_element_right,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: BinaryTreeInsertAnimation(),
                      ),
                      const SizedBox(height: 20),

                      // Preorder traversal pseudo code title
                      Text(
                        AppLocalizations.of(context)!.bt_preorder_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Preorder traversal pseudo code
                      Text(
                        BSTStrings.func_preorder_traversal,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Animation of the BT
                      Center(
                        child: BinaryTreePreorderAnimation(),
                      ),

                      const SizedBox(height: 20),

                      // Inorder traversal pseudo code title
                      Text(
                        AppLocalizations.of(context)!.bt_inorder_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Inorder traversal pseudo code
                      Text(
                        BSTStrings.func_inorder_traversal2,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Animation of the BT
                      Center(
                        child: BinaryTreeInorderTraversalAnimation(),
                      ),

                      const SizedBox(height: 20),

                      // Postorder traversal pseudo code title
                      Text(
                        AppLocalizations.of(context)!.bt_postorder_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Postorder traversal pseudo code
                      Text(
                        BSTStrings.func_postorder_traversal2,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Animation of the BT
                      Center(
                        child: BinaryTreePreorderTraversalAnimation(),
                      ),

                      const SizedBox(height: 20),

                      // Delete binary tree pseudo code title
                      Text(
                        AppLocalizations.of(context)!.bt_destroy_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Delete binary tree pseudo code
                      Text(
                        BSTStrings.func_destroy1,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      const SizedBox(height: 20),

/// Binary Search Tree
                      Divider(),

                      const SizedBox(height: 20),

                      // New node pseudo code title
                      Text(
                        AppLocalizations.of(context)!.bt_create_new_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
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
                      Center(
                        child: BSTNewNodeAnimation(),
                      ),

                      const SizedBox(height: 20),

                      // Insert pseudo code title
                      Text(
                        AppLocalizations.of(context)!.bst_insert_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
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
                      Center(
                        child: BSTInsertAnimation(),
                      ),

                      const SizedBox(height: 20),

                      // Inorder traversal pseudo code title
                      Text(
                        AppLocalizations.of(context)!.bt_inorder_function_title,
                        style: TextStyle(
                          fontSize: 21,
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
                      // Animation of the BST
                      Center(
                        child:
                        BSTInorderAnimation(),
                      ),

                      const SizedBox(height: 20),

                      // Min value node pseudo code title
                      Text(
                        AppLocalizations.of(context)!.bst_min_function_title,
                        style: TextStyle(
                          fontSize: 21,
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
                      Center(
                        child:
                        BSTMinNodeAnimation(),
                      ),

                      const SizedBox(height: 20),

                      // Max value node pseudo code title
                      Text(
                        AppLocalizations.of(context)!.bst_max_function_title,
                        style: TextStyle(
                          fontSize: 21,
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
                      Center(
                        child:
                        BSTMaxNodeAnimation(),
                      ),

                      const SizedBox(height: 20),

                      // Delete pseudo code title
                      Text(
                        AppLocalizations.of(context)!.bst_delete_node_function_title,
                        style: TextStyle(
                          fontSize: 21,
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
                      Center(
                        child:
                        BSTDeleteNodeAnimation(),
                      ),

                      const SizedBox(height: 20),

                    ],
                  ),
                ),
              ),
            ],
          ),

          if (_showExplanation)
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  setState(() {
                    _showExplanation = false;
                  });
                },
              ),
            ),
          if (_showExplanation)
            Positioned(
              top: MediaQuery.of(context).padding.top + 60,
              right: 12,
              child: Container(
                width: 280,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.naming_conventions_title,
                      style: const TextStyle(
                        color: Color(0xFF255f38),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    _buildExplanationRow(AppLocalizations.of(context)!.bt_naming_conv_1),
                    _buildExplanationRow(AppLocalizations.of(context)!.bt_naming_conv_2),
                    _buildExplanationRow(AppLocalizations.of(context)!.bt_naming_conv_3),
                    _buildExplanationRow(AppLocalizations.of(context)!.bt_naming_conv_4),
                    _buildExplanationRow(AppLocalizations.of(context)!.bt_naming_conv_5),
                    _buildExplanationRow(AppLocalizations.of(context)!.bt_naming_conv_6),
                    _buildExplanationRow(AppLocalizations.of(context)!.bt_naming_conv_7),
                    _buildExplanationRow(AppLocalizations.of(context)!.bt_naming_conv_8),
                    _buildExplanationRow(AppLocalizations.of(context)!.bt_naming_conv_9),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildExplanationRow(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.arrow_right_rounded,
            color: Color(0xFF1f7d53),
            size: 20,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

}