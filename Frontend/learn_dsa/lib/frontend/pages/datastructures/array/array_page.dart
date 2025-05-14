import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_dsa/frontend/helpers/essentials.dart';
import 'package:learn_dsa/frontend/pages/datastructures/array/pseudocode_page.dart';
import 'package:learn_dsa/frontend/pages/test/testpages/array_testpage.dart';
import '../../../strings/datastructure_strings/array_strings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../test/exercises/array_exercises.dart';
import '../datastructures_page.dart';
import '../../customClasses/custom_closing_button_copyCode.dart';

class ArrayPage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final String? userId;

  const ArrayPage({Key? key, required this.toggleTheme, required this.userId}) : super(key: key);

  @override
  State<ArrayPage> createState() => _ArrayPageState();
}

class _ArrayPageState extends State<ArrayPage> with SingleTickerProviderStateMixin {
  bool showOverlay = false;
  bool showLockedDialog = false;
  bool _isDropdownVisible = false;
  bool showArrayInfo = false;

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
                  AppLocalizations.of(context)!.array_page_title,
                  style: const TextStyle(
                    fontSize: 25,
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

              // Main Content
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      // What is an array?
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
                            Text(AppLocalizations.of(context)!.array_question,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            // Array description, what is an array
                            Text(AppLocalizations.of(context)!.array_definition,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 10),

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

                      const SizedBox(height: 10),

                      // Struct typedef
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

                            // Struct array explanation
                            Text(AppLocalizations.of(context)!
                                .array_struct_explanation_1,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                              softWrap: true,
                            ),
                            Text(AppLocalizations.of(context)!
                                .array_struct_explanation_2,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                              softWrap: true,
                            ),
                            Text(AppLocalizations.of(context)!
                                .array_struct_explanation_3,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
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
                                  ArrayStrings
                                      .struct_array_empty_initialization),

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
                                            text: ArrayStrings
                                                .struct_array_empty_initialization));
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

                      /*Text(AppLocalizations.of(context)!.animation_title,
                        style: TextStyle(
                          color: Color(0xFF1f7d53),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Animation
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            // Struct array explanation
                            Text(AppLocalizations.of(context)!
                                .array_animation_title,
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
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),*/

                      Text(AppLocalizations.of(context)!
                          .when_to_use_title,
                        style: TextStyle(
                          color: Color(0xFF1f7d53),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // When to use it?
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
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

                            // When to use it
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // YES
                                Text(AppLocalizations.of(context)!.yes_text,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),

                                const SizedBox(height: 10),
                                // Reason 1
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.check_circle_outline_rounded,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(AppLocalizations.of(context)!
                                          .array_when_to_use_1,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                        softWrap: true,
                                      ),
                                    ),
                                  ],
                                ),
                                // Reason 2
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.check_circle_outline_rounded,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(AppLocalizations.of(context)!
                                          .array_when_to_use_2,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                        softWrap: true,
                                      ),
                                    ),
                                  ],
                                ),
                                // Reason 3
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.check_circle_outline_rounded,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(AppLocalizations.of(context)!
                                          .array_when_to_use_3,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                        softWrap: true,
                                      ),
                                    ),
                                  ],
                                ),
                                // Reason 4
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.check_circle_outline_rounded,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(AppLocalizations.of(context)!
                                          .array_when_to_use_4,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                        softWrap: true,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                // NO
                                Text(AppLocalizations.of(context)!.dont_text,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 10),

                                // Reason 1
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.dangerous_outlined,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                    SizedBox(width: 8),
                                    // When to use it
                                    Expanded(
                                      child: Text(AppLocalizations.of(context)!
                                          .array_when_not_to_use_1,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // Reason 2
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.dangerous_outlined,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                    SizedBox(width: 8),
                                    // When to use it
                                    Expanded(
                                      child: Text(AppLocalizations.of(context)!
                                          .array_when_not_to_use_2,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // Reason 3
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.dangerous_outlined,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                    SizedBox(width: 8),
                                    // When to use it
                                    Expanded(
                                      child: Text(AppLocalizations.of(context)!
                                          .array_when_not_to_use_3,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // Reason 4
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.dangerous_outlined,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                    SizedBox(width: 8),
                                    // When to use it
                                    Expanded(
                                      child: Text(AppLocalizations.of(context)!
                                          .array_when_not_to_use_4,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Complete .h file
                      CollapsibleCodeBlock(title: AppLocalizations.of(context)!.header_file_title, codeContent: ArrayStrings.header_file_content),

                      const SizedBox(height: 20),

                      // Complete .c file
                      CollapsibleCodeBlock(title: AppLocalizations.of(context)!.source_file_title, codeContent: ArrayStrings.source_file_content),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
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
                    /*_buildMenuItem(Icons.code,
                        AppLocalizations.of(context)!.code_snippets_text, () {
                          Navigator.push(
                            context,
                            Essentials().createSlideRoute(
                              ImplementationArrayPage(
                                toggleTheme: widget.toggleTheme,
                                userId: widget.userId,
                              ),
                            ),
                          );
                          HapticFeedback.mediumImpact();
                        }),*/
                    _buildMenuItem(Icons.text_snippet,
                        AppLocalizations.of(context)!.pseudocode_text, () {
                          Navigator.push(
                            context,
                            Essentials().createSlideRoute(
                              PseudocodeArrayPage(
                                toggleTheme: widget.toggleTheme,
                                userId: widget.userId,
                              ),
                            ),
                          );
                          HapticFeedback.mediumImpact();
                        }),
                    _buildMenuItem(Icons.pending_actions_rounded,
                        AppLocalizations.of(context)!
                            .test_page_exercises_title, () {
                          Navigator.push(
                            context,
                            Essentials().createSlideRoute(
                              ArrayExercisesPage(
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
                              ArrayTestPage(
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

/*Stack(
                        clipBehavior: Clip.none,
                        children: [
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
                                // Code colored
                                Essentials().buildHighlightedCodeLines(
                                    ArrayStrings.header_file_content),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              icon: Icon(
                                Icons.copy,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                Clipboard.setData(ClipboardData(
                                    text: ArrayStrings.header_file_content));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(AppLocalizations.of(context)!
                                        .code_copied_text),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    margin: EdgeInsets.all(16),
                                    elevation: 6,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),*/

/*Stack(
                        clipBehavior: Clip.none,
                        children: [
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
                                // Code colored
                                Essentials().buildHighlightedCodeLines(
                                    ArrayStrings.source_file_content),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              icon: Icon(
                                Icons.copy,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                Clipboard.setData(ClipboardData(
                                    text: ArrayStrings.source_file_content));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(AppLocalizations.of(context)!
                                        .code_copied_text),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    margin: EdgeInsets.all(16),
                                    elevation: 6,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),*/