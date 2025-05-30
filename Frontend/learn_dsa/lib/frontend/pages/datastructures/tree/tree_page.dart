import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_dsa/frontend/pages/datastructures/tree/pseudocode_page.dart';
import 'package:learn_dsa/frontend/pages/datastructures/tree/tree_animations.dart';
import '../../../helpers/essentials.dart';
import '../../../strings/datastructure_strings/tree_strings.dart';
import '../../customClasses/custom_closing_button_copyCode.dart';
import '../../test/testpages/bst_testpage.dart';
import '../datastructures_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BSTPage extends StatefulWidget
{
  final VoidCallback toggleTheme;
  final String? userId;

  const BSTPage({super.key, required this.toggleTheme, required this.userId});

  @override
  _BSTPageState createState() => _BSTPageState();
}

class _BSTPageState extends State<BSTPage> {
  bool showOverlay = false;
  bool showLockedDialog = false;
  bool _isDropdownVisible = false;
  bool showArrayInfo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // AppBar
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
                      Essentials().createSlideRoute(DataStructuresPage(
                        toggleTheme: widget.toggleTheme,
                        userId: widget.userId,
                      ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 20,
                  ),
                  // Button back
                  label: Text(
                    AppLocalizations.of(context)!.back_button_text,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 17,
                    ),
                  ),
                ),
                centerTitle: true,
                title: Text(
                  AppLocalizations.of(context)!.bst_page_title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF255f38),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isDropdownVisible = !_isDropdownVisible;
                        });
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          //color: Color(0xFF255f38),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(
                          _isDropdownVisible ? Icons.pending_rounded : Icons
                              .pending_outlined,
                          color: const Color(0xFF255f38),
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
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

              // Main Content as a SliverList
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      // What is a BT?
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme
                              .of(context)
                              .scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context)!.bt_question,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            // Array description, what is an array
                            Text(AppLocalizations.of(context)!.bt_description,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                              ),
                            ),

                            BTAnimation(),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(AppLocalizations.of(context)!.struct_title,
                        style: TextStyle(
                          color: Color(0xFF1f7d53),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // Struct typedef
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme
                              .of(context)
                              .scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.bt_struct_explanation_11,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: ' ${AppLocalizations.of(context)!.bt_struct_explanation_12}',
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.start,
                              softWrap: true,
                            ),

                            const SizedBox(height: 5),

                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.bt_struct_explanation_21,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: ' ${AppLocalizations.of(context)!.bt_struct_explanation_22}',
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.start,
                              softWrap: true,
                            ),

                            const SizedBox(height: 5),

                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.bt_struct_explanation_31,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: ' ${AppLocalizations.of(context)!.bt_struct_explanation_32}',
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.start,
                              softWrap: true,
                            ),

                            const SizedBox(height: 10),

                            Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Struct array code snippet with copy button
                                  Essentials()
                                      .buildHighlightedCodeLines(
                                      BSTStrings.bst_empty_initialization2),

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
                                        Clipboard.setData(
                                            ClipboardData(
                                                text: BSTStrings.bst_empty_initialization2));
                                        HapticFeedback.mediumImpact();
                                        ScaffoldMessenger
                                            .of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                AppLocalizations.of(
                                                    context)!
                                                    .code_copied_text),
                                            behavior: SnackBarBehavior
                                                .floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius
                                                  .circular(12),
                                            ),
                                            margin: EdgeInsets.all(16),
                                            elevation: 6,
                                          ),
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

                      const SizedBox(height: 20),

                      // Basic terms
                      Text(AppLocalizations.of(context)!.basic_terms_title,
                        style: TextStyle(
                          color: Color(0xFF1f7d53),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.bt_basics_11,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: ' ${AppLocalizations.of(context)!.bt_basics_12}',
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.start,
                              softWrap: true,
                            ),

                            const SizedBox(height: 5),

                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.bt_basics_21,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: ' ${AppLocalizations.of(context)!.bt_basics_22}',
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.start,
                              softWrap: true,
                            ),

                            const SizedBox(height: 5),

                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.bt_basics_31,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: ' ${AppLocalizations.of(context)!.bt_basics_32}',
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.start,
                              softWrap: true,
                            ),

                            const SizedBox(height: 5),

                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.bt_basics_41,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: ' ${AppLocalizations.of(context)!.bt_basics_42}',
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.start,
                              softWrap: true,
                            ),

                            const SizedBox(height: 5),

                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.bt_basics_51,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: ' ${AppLocalizations.of(context)!.bt_basics_52}',
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.start,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Complete .h file
                      CollapsibleCodeBlock(title: AppLocalizations.of(context)!.header_file_title, codeContent: BSTStrings.header_file_content),

                      const SizedBox(height: 20),

                      // Complete .c file
                      CollapsibleCodeBlock(title: AppLocalizations.of(context)!.source_file_title, codeContent: BSTStrings.source_file_content),

                      const SizedBox(height: 20),

                      // What is a BST?
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme
                              .of(context)
                              .scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context)!.bst_question,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(AppLocalizations.of(context)!.bst_description,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                              ),
                            ),

                            BSTAnimation(),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(AppLocalizations.of(context)!.struct_title,
                        style: TextStyle(
                          color: Color(0xFF1f7d53),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // Struct typedef
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme
                              .of(context)
                              .scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.bt_struct_explanation_11,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: ' ${AppLocalizations.of(context)!.bt_struct_explanation_12}',
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.start,
                              softWrap: true,
                            ),

                            const SizedBox(height: 5),

                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.bt_struct_explanation_21,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: ' ${AppLocalizations.of(context)!.bt_struct_explanation_22}',
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.start,
                              softWrap: true,
                            ),

                            const SizedBox(height: 5),

                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.bt_struct_explanation_31,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: ' ${AppLocalizations.of(context)!.bt_struct_explanation_32}',
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.start,
                              softWrap: true,
                            ),

                            const SizedBox(height: 10),

                            Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Struct array code snippet with copy button
                                  Essentials()
                                      .buildHighlightedCodeLines(
                                      BSTStrings.bst_empty_initialization),

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
                                        Clipboard.setData(
                                            ClipboardData(
                                                text: BSTStrings.bst_empty_initialization));
                                        HapticFeedback.mediumImpact();
                                        ScaffoldMessenger
                                            .of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                AppLocalizations.of(
                                                    context)!
                                                    .code_copied_text),
                                            behavior: SnackBarBehavior
                                                .floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius
                                                  .circular(12),
                                            ),
                                            margin: EdgeInsets.all(16),
                                            elevation: 6,
                                          ),
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

                      const SizedBox(height: 20),

                      // Basic terms
                      Text(AppLocalizations.of(context)!.basic_terms_title,
                        style: TextStyle(
                          color: Color(0xFF1f7d53),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.bt_basics_11,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: ' ${AppLocalizations.of(context)!.bt_basics_12}',
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.start,
                              softWrap: true,
                            ),

                            const SizedBox(height: 5),

                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.bt_basics_21,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: ' ${AppLocalizations.of(context)!.bt_basics_22}',
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.start,
                              softWrap: true,
                            ),

                            const SizedBox(height: 5),

                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.bt_basics_31,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: ' ${AppLocalizations.of(context)!.bt_basics_32}',
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.start,
                              softWrap: true,
                            ),

                            const SizedBox(height: 5),

                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.bt_basics_41,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: ' ${AppLocalizations.of(context)!.bt_basics_42}',
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.start,
                              softWrap: true,
                            ),

                            const SizedBox(height: 5),

                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.bt_basics_51,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: ' ${AppLocalizations.of(context)!.bt_basics_52}',
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.start,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Complete .h file
                      CollapsibleCodeBlock(title: AppLocalizations.of(context)!.header_file_title, codeContent: BSTStrings.header_bst_file_content),

                      const SizedBox(height: 20),

                      // Complete .c file
                      CollapsibleCodeBlock(title: AppLocalizations.of(context)!.source_file_title, codeContent: BSTStrings.source_bst_file_content),


                      const SizedBox(height: 40),

                    ],
                  ),
                ),
              ),

            ],
          ),

          if (_isDropdownVisible)
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  setState(() {
                    _isDropdownVisible = false;
                  });
                },
              ),
            ),
          if (_isDropdownVisible)
            Positioned(
              top: MediaQuery
                  .of(context)
                  .padding
                  .top + 60,
              right: 12,
              child: Container(
                width: 220,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildMenuItem(Icons.text_snippet,
                        AppLocalizations.of(context)!.pseudocode_text, () {
                          Navigator.push(
                            context,
                            Essentials().createSlideRoute(
                              PseudocodeBSTPage(
                                toggleTheme: widget.toggleTheme,
                                userId: widget.userId,
                              ),
                            ),
                          );
                          HapticFeedback.mediumImpact();
                        }),
                    _buildMenuItem(Icons.quiz,
                        AppLocalizations.of(context)!.test_page_title, () {
                          Navigator.push(
                            context,
                            Essentials().createSlideRoute(
                              BSTTestPage(
                                toggleTheme: widget.toggleTheme,
                                userId: widget.userId,
                              ),
                            ),
                          );
                          HapticFeedback.mediumImpact();
                        }),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: Colors.black, size: 20),
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
