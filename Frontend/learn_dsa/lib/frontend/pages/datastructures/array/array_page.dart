import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_dsa/frontend/helpers/essentials.dart';
import 'package:learn_dsa/frontend/pages/datastructures/array/pseudocode_page.dart';
import 'package:learn_dsa/frontend/pages/test/testpages/array_testpage.dart';
import 'package:learn_dsa/frontend/pages/exercises/array_exercises.dart';
import '../../../strings/datastructure_strings/array_strings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../datastructures_page.dart';
import 'animations/array_animations.dart';
import 'implementation_page.dart';

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
                      CupertinoPageRoute(
                        builder: (_) => DataStructuresPage(
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
                          _isDropdownVisible ? Icons.pending_rounded : Icons.pending_outlined,
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
                      color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
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
                      const SizedBox(height: 20),

                      // What is an array?
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
                                  color: Colors.black.withOpacity(0.4),
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
                                Text(AppLocalizations.of(context)!.array_definition,
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
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [

                                      // Struct array code snippet with copy button
                                      Center(
                                        child: Stack(
                                          children: [
                                            // Static array code snippet
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Theme
                                                    .of(context)
                                                    .scaffoldBackgroundColor,
                                                //Color(0xFFDFAEE8),
                                                borderRadius: BorderRadius
                                                    .circular(8),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                    offset: const Offset(4, 4),
                                                    blurRadius: 6,
                                                    spreadRadius: 2,
                                                  ),
                                                ],
                                              ),

                                              child: Essentials().buildHighlightedCodeLines(
                                                  ArrayStrings
                                                      .struct_array_empty_initialization),
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
                                                  Clipboard.setData(
                                                      ClipboardData(
                                                          text: ArrayStrings
                                                              .struct_array_empty_initialization));
                                                  HapticFeedback.mediumImpact();
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

                                      // Struct array explanation
                                      Text(AppLocalizations.of(context)!.array_animation_title,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey,
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      // Animation of the struct array
                                      AnimatedArrayWidget(),

                                      SizedBox(height: 20),
                                      // Struct array explanation
                                      Text(AppLocalizations.of(context)!.array_struct_explanation_title,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),

                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Icon(
                                            Icons.keyboard_arrow_right_rounded,
                                            color: Color(0xFF1f7d53),
                                            size: 20,
                                          ),
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: Text(AppLocalizations.of(context)!.array_struct_explanation_1,
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
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Icon(
                                            Icons.keyboard_arrow_right_rounded,
                                            color: Color(0xFF1f7d53),
                                            size: 20,
                                          ),
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: Text(AppLocalizations.of(context)!.array_struct_explanation_2,
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
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Icon(
                                            Icons.keyboard_arrow_right_rounded,
                                            color: Color(0xFF1f7d53),
                                            size: 20,
                                          ),
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: Text(AppLocalizations.of(context)!.array_struct_explanation_3,
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
                                  colors: [
                                    Color(0xFF255f38),
                                    Color(0xFF27391c)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 8.0,
                              ),
                              child: Text(AppLocalizations.of(context)!.array_question,
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

                      const SizedBox(height: 40),

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
                              borderRadius: BorderRadius.circular(12),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
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
                                      child: Text(AppLocalizations.of(context)!.array_when_to_use_1,
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
                                      child: Text(AppLocalizations.of(context)!.array_when_to_use_2,
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
                                      child: Text(AppLocalizations.of(context)!.array_when_to_use_3,
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
                                      child: Text(AppLocalizations.of(context)!.array_when_to_use_4,
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
                                      child: Text(AppLocalizations.of(context)!.array_when_not_to_use_1,
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
                                      child: Text(AppLocalizations.of(context)!.array_when_not_to_use_2,
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
                                      child: Text(AppLocalizations.of(context)!.array_when_not_to_use_3,
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
                                      child: Text(AppLocalizations.of(context)!.array_when_not_to_use_4,
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

                          // What is an array question box
                          Positioned(
                            top: -23,
                            left: 16,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  // Gradient colors
                                  colors: [
                                    Color(0xFF255f38),
                                    Color(0xFF27391c)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 8.0,
                              ),
                              child: Text(AppLocalizations.of(context)!.array_when_to_use_title,
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

                      const SizedBox(height: 40),

                      // Complete .h file
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
                                  color: Colors.black.withOpacity(0.4),
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
                                  SnackBar(content: Text('Code copied!')),
                                );
                              },
                            ),
                          ),
                          Positioned(
                            top: -23,
                            left: 16,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF255f38),
                                    Color(0xFF27391c)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 8.0),
                              child: Text(AppLocalizations.of(context)!.array_header_file_title,
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

                      const SizedBox(height: 40),

                      // Complete .c file
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
                                  color: Colors.black.withOpacity(0.4),
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
                                  SnackBar(content: Text('Code copied!')),
                                );
                              },
                            ),
                          ),
                          Positioned(
                            top: -23,
                            left: 16,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF255f38),
                                    Color(0xFF27391c)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 8.0),
                              child: Text(AppLocalizations.of(context)!.array_source_file_title,
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

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Overlay
          if (showOverlay)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showOverlay = false;
                  });
                },
                child: Stack(
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),

                    Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 32),
                                SelectableText(
                                  ArrayStrings.header_file_content,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Courier',
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                          Clipboard.setData(ClipboardData(
                              text: ArrayStrings.header_file_content));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Code copied!')),
                          );
                        },
                      ),
                    ),

                    // Pseudocode box
                    Positioned(
                      top: -23,
                      left: 16,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF255f38), Color(0xFF27391c)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: Text(
                          ArrayStrings.header_file,
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
              ),
            ),

          if (showLockedDialog)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.lock_outline, size: 40,
                            color: Colors.grey[700]),
                        const SizedBox(height: 16),
                        Text(
                          "Only available if you unlock it with tests",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge!
                                .color,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              showLockedDialog = false;
                            });
                          },
                          child: Text("Close"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          if (_isDropdownVisible)
            Positioned(
              top: MediaQuery.of(context).padding.top + 60,
              right: 12,
              child: Container(
                width: 220,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(16),
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
                    _buildMenuItem(Icons.code, "Code Snippets", () {
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
                    }),
                    _buildMenuItem(Icons.text_snippet, "Pseudocodes", () {
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
                    _buildMenuItem(Icons.pending_actions_rounded, "Exercises", () {
                      Navigator.push(
                        context,
                        Essentials().createSlideRoute(
                          ArrayExercisesPage(
                            //toggleTheme: widget.toggleTheme,
                            //userId: widget.userId,
                          ),
                        ),
                      );
                      HapticFeedback.mediumImpact();
                    }),
                    _buildMenuItem(Icons.quiz, "Tests", () {
                      Navigator.push(
                        context,
                        Essentials().createSlideRoute(
                          ArrayTestPage(
                            //toggleTheme: widget.toggleTheme,
                            //userId: widget.userId,
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

  Widget _buildCategoryButton(BuildContext context, String title, bool isDarkTheme) {
    final gradient = LinearGradient(
      colors: [Color(0xFF255f38), Color(0xFF27391c)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final pageMap = {
      "Pseudocodes": () => PseudocodeArrayPage(toggleTheme: widget.toggleTheme, userId: widget.userId),
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
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
      ),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: gradient,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 4,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: Container(
          height: 60,
          width: 170,
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Icon(
                Icons.arrow_circle_right_outlined,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Check out
/*Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          /*
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFF1f7d53).withOpacity(0.9),
                                const Color(0xFF255f38).withOpacity(0.9),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                           */
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(12),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Check out',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF255f38), //Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),
                              _buildCardItem(
                                  "Psedocodes", Icons.animation_rounded, () {
                                Navigator.push(
                                  context,
                                  createSlideRoute(PseudocodePage(
                                    toggleTheme: widget.toggleTheme,
                                    userId: widget.userId,)),
                                );
                              }),
                              const SizedBox(height: 8),

                              _buildCardItem("When to use an array?",
                                  Icons.check_circle_outline_rounded, () {
                                  setState(() {
                                    showOverlay = true;
                                  });
                                },
                              ),
                              const SizedBox(height: 8),
                              _buildCardItem("Implementation", Icons.code_rounded, () {
                                setState(() {
                                  showLockedDialog = true;
                                });
                              }),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ],
                    ),*/