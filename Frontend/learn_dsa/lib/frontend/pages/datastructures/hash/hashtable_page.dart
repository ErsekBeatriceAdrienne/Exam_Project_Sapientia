import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_dsa/frontend/pages/datastructures/hash/pseudocode_page.dart';
import '../../../helpers/essentials.dart';
import '../../../strings/datastructure_strings/hashtable_strings.dart';
import '../../test/exercises/hashtable_exercises.dart';
import '../../test/testpages/hash_testpage.dart';
import '../datastructures_page.dart';
import 'animations/hash_createItem.dart';
import 'animations/hash_createTable.dart';
import 'animations/hash_delete.dart';
import 'animations/hash_hashcode.dart';
import 'animations/hash_insert.dart';
import 'animations/hash_Node.dart';
import 'animations/hash_search.dart';
import 'hashtable_animations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HashTablePage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final String? userId;

  const HashTablePage({super.key, required this.toggleTheme, required this.userId});

  @override
  State<HashTablePage> createState() => _HashTablePageState();
}

class _HashTablePageState extends State<HashTablePage> with SingleTickerProviderStateMixin {
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
                    AppLocalizations.of(context)!.hash_page_title,
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
                        // What is a Hash table?
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
                              Text(AppLocalizations.of(context)!.static_hash_question,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10),

                              // Array description, what is an array
                              Text(AppLocalizations.of(context)!.static_hash_description,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey,
                                ),
                              ),

                              const SizedBox(height: 10),

                              Center(
                                child: ChainedHashTableAnimation(),
                              ),
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
                                      text: AppLocalizations.of(context)!.static_hash_struct_explanation_11,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: ' ${AppLocalizations.of(context)!.static_hash_struct_explanation_12}',
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
                                      text: AppLocalizations.of(context)!.static_hash_struct_explanation_21,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: ' ${AppLocalizations.of(context)!.static_hash_struct_explanation_22}',
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
                                      text: AppLocalizations.of(context)!.static_hash_struct_explanation_31,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: ' ${AppLocalizations.of(context)!.static_hash_struct_explanation_32}',
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
                                      text: AppLocalizations.of(context)!.static_hash_struct_explanation_41,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: ' ${AppLocalizations.of(context)!.static_hash_struct_explanation_42}',
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
                                      text: AppLocalizations.of(context)!.static_hash_struct_explanation_51,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: ' ${AppLocalizations.of(context)!.static_hash_struct_explanation_52}',
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
                                      text: AppLocalizations.of(context)!.static_hash_struct_explanation_61,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: ' ${AppLocalizations.of(context)!.static_hash_struct_explanation_62}',
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
                                    Essentials().buildHighlightedCodeLines(
                                      HashTableStrings.hash_empty_initialization,
                                    ),
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.copy,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          Clipboard.setData(
                                            ClipboardData(text: HashTableStrings.hash_empty_initialization),
                                          );
                                          HapticFeedback.mediumImpact();
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(AppLocalizations.of(context)!.code_copied_text),
                                              behavior: SnackBarBehavior.floating,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              margin: const EdgeInsets.all(16),
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

                        /// Dynamic hash table

                        // What is a dynamic hash table?
                        /*Stack(
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

                                  // Hash Table description, what is?
                                  Text(
                                    HashTableStrings.hash_definition1,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Hash Table code example
                                  Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [

                                        // hash item
                                        Center(
                                          child: Stack(
                                            children: [
                                              // Hash Table code snippet
                                              Container(
                                                padding: const EdgeInsets.all(
                                                    8),
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
                                                      offset: const Offset(
                                                          2, 2),
                                                      blurRadius: 6,
                                                      spreadRadius: 2,
                                                    ),
                                                  ],
                                                ),

                                                child: SelectableText(
                                                  HashTableStrings
                                                      .hash_empty_initialization2,
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
                                                    Clipboard.setData(
                                                        ClipboardData(
                                                            text: HashTableStrings
                                                                .hash_empty_initialization2));
                                                    ScaffoldMessenger.of(
                                                        context).showSnackBar(
                                                      SnackBar(content: Text(
                                                          'Code copied!')),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          HashTableStrings.hash_definition2,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black,
                                          ),
                                        ),

                                        const SizedBox(height: 10),

                                        // Hash item node
                                        Center(
                                          child: Stack(
                                            children: [
                                              // Hash Table code snippet
                                              Container(
                                                padding: const EdgeInsets.all(
                                                    8),
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
                                                      offset: const Offset(
                                                          2, 2),
                                                      blurRadius: 6,
                                                      spreadRadius: 2,
                                                    ),
                                                  ],
                                                ),

                                                child: SelectableText(
                                                  HashTableStrings
                                                      .hash_empty_initialization4,
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
                                                    Clipboard.setData(
                                                        ClipboardData(
                                                            text: HashTableStrings
                                                                .hash_empty_initialization4));
                                                    ScaffoldMessenger.of(
                                                        context).showSnackBar(
                                                      SnackBar(content: Text(
                                                          'Code copied!')),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          HashTableStrings.hash_definition3,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black,
                                          ),
                                        ),

                                        const SizedBox(height: 10),

                                        // Capacity
                                        Center(
                                          child: Stack(
                                            children: [
                                              // Hash Table code snippet
                                              Container(
                                                padding: const EdgeInsets.all(
                                                    8),
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
                                                      offset: const Offset(
                                                          2, 2),
                                                      blurRadius: 6,
                                                      spreadRadius: 2,
                                                    ),
                                                  ],
                                                ),

                                                child: SelectableText(
                                                  HashTableStrings
                                                      .hash_empty_initialization12,
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
                                                    Clipboard.setData(
                                                        ClipboardData(
                                                            text: HashTableStrings
                                                                .hash_empty_initialization12));
                                                    ScaffoldMessenger.of(
                                                        context).showSnackBar(
                                                      SnackBar(content: Text(
                                                          'Code copied!')),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          HashTableStrings.hash_cap_definition1,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 10),

                                        // Hash Table code snippet with copy button
                                        Center(
                                          child: Stack(
                                            children: [
                                              // Hash Table code snippet
                                              Container(
                                                padding: const EdgeInsets.all(
                                                    8),
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
                                                      offset: const Offset(
                                                          2, 2),
                                                      blurRadius: 6,
                                                      spreadRadius: 2,
                                                    ),
                                                  ],
                                                ),

                                                child: SelectableText(
                                                  HashTableStrings
                                                      .hash_empty_initialization5,
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
                                                    Clipboard.setData(
                                                        ClipboardData(
                                                            text: HashTableStrings
                                                                .hash_empty_initialization5));
                                                    ScaffoldMessenger.of(
                                                        context).showSnackBar(
                                                      SnackBar(content: Text(
                                                          'Code copied!')),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        const SizedBox(height: 10),
                                        Text(
                                          HashTableStrings.hash_definition4,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 10),

                                        // Hash Table explanation
                                        Text(
                                          HashTableStrings
                                              .hash_animation_title1,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 20),

                                        // Animation of the Hash Table
                                        Center(
                                          child: ChainedDynamicHashTableAnimation(),
                                        ),

                                        const SizedBox(height: 10),

                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),

                            // What is a Hash Table question box
                            Positioned(
                              top: -23,
                              left: 16,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    // Gradient colors
                                    colors: [
                                      Color(0xFFa1f7ff),
                                      Color(0xFFDFAEE8)
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
                                child: Text(
                                  HashTableStrings.question1,
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
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              dividerColor: Colors.transparent,),
                            child:
                            ExpansionTile(
                              title: Text(
                                HashTableStrings.func_title_item,
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
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [

                                      // Create hash item animation
                                      Center(
                                        child: SingleHashItemAnimation(),
                                      ),

                                      const SizedBox(height: 10),

                                      // Create Node pseudo code title
                                      Text(
                                        HashTableStrings.create_Node_title,
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      // Create Node pseudo code
                                      Text(
                                        HashTableStrings.create_Node,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          fontFamily: 'Courier',
                                        ),
                                      ),
                                      Center(
                                        child: HashNewNodeAnimation(),
                                      ),

                                      const SizedBox(height: 10),
                                      // Create Node pseudo code title
                                      Text(
                                        HashTableStrings.create_table_title,
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      // Create Node pseudo code
                                      Text(
                                        HashTableStrings.create_table,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          fontFamily: 'Courier',
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Center(
                                        child: CreateEmptyChainedHashTable(),
                                      ),

                                      // isEmpty pseudo code title
                                      Text(
                                        HashTableStrings.isEmpty_title,
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      // isEmpty pseudo code
                                      Text(
                                        HashTableStrings.isEmpty,
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
                                        HashTableStrings.search_title,
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Search node pseudo code title
                                      Text(
                                        HashTableStrings.search_node_title,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      // Search node pseudo code
                                      Text(
                                        HashTableStrings.search_node,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          fontFamily: 'Courier',
                                        ),
                                      ),

                                      // Search item pseudo code title
                                      Text(
                                        HashTableStrings.search_item_title,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      // Search item pseudo code
                                      Text(
                                        HashTableStrings.search_item,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          fontFamily: 'Courier',
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Center(
                                        child: ChainedDynamicHashTableSearchAnimation(),
                                      ),

                                      // Print list pseudo code title
                                      Text(
                                        HashTableStrings.print_list_title,
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      // Print list pseudo code
                                      Text(
                                        HashTableStrings.print_list,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          fontFamily: 'Courier',
                                        ),
                                      ),
                                      const SizedBox(height: 10),

                                      // Print hash table pseudo code title
                                      Text(
                                        HashTableStrings.print_table_title,
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Print hash table pseudo code
                                      Text(
                                        HashTableStrings.print_table,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          fontFamily: 'Courier',
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      // Hash code pseudo code title
                                      Text(
                                        HashTableStrings.hashcode_title,
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      // Hash code pseudo code
                                      Text(
                                        HashTableStrings.hashcode,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          fontFamily: 'Courier',
                                        ),
                                      ),
                                      Center(
                                        child: HashCode2Animation(),
                                      ),

                                      // Insert into table title
                                      Text(
                                        HashTableStrings.insert_title,
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Insert into table
                                      Text(
                                        HashTableStrings.insert_node_title,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      // Insert into table
                                      Text(
                                        HashTableStrings.insert_node,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          fontFamily: 'Courier',
                                        ),
                                      ),
                                      // Insert into table
                                      Text(
                                        HashTableStrings.insert_item_title,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      // Insert into table
                                      Text(
                                        HashTableStrings.insert_item,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          fontFamily: 'Courier',
                                        ),
                                      ),
                                      Center(
                                        child: ChainedDynamicHashTableInsertAnimation(),
                                      ),

                                      // Delete node pseudo code title
                                      Text(
                                        HashTableStrings.delete_title,
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        HashTableStrings.delete_node_title,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      // Delete node pseudo code
                                      Text(
                                        HashTableStrings.delete_node,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          fontFamily: 'Courier',
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        HashTableStrings.delete_node_title1,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      // Delete item pseudo code
                                      Text(
                                        HashTableStrings.delete_node1,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          fontFamily: 'Courier',
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        HashTableStrings.delete_item_title,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      // Delete item pseudo code
                                      Text(
                                        HashTableStrings.delete_item,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          fontFamily: 'Courier',
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Center(
                                        child: ChainedDynamicHashTableDeleteAnimation(),
                                      ),

                                      const SizedBox(height: 10),
                                      // Delete list pseudo code title
                                      Text(
                                        HashTableStrings.delete_list_title,
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Delete list pseudo code
                                      Text(
                                        HashTableStrings.delete_list,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          fontFamily: 'Courier',
                                        ),
                                      ),

                                      const SizedBox(height: 10),
                                      // Delete hash table pseudo code title
                                      Text(
                                        HashTableStrings.delete_table_title,
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Delete hash table pseudo code
                                      Text(
                                        HashTableStrings.delete_table,
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
                                PseudocodeHashTablePage(
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
                                HashTableTestPage(
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
                            HashTableStrings.code_functions_title,
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

                                  // Create item pseudo code title
                                  Text(
                                    HashTableStrings.func_create_item_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Create item pseudo code comment
                                  Text(
                                    HashTableStrings.func_create_item_comment,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Create item code with copy button
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
                                            HashTableStrings.func_create_item_code,
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
                                              Clipboard.setData(ClipboardData(text: HashTableStrings.func_create_item_code));
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Create hash table title
                                  Text(
                                    HashTableStrings.func_create_hash_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Create hash table comment
                                  Text(
                                    HashTableStrings.func_create_hash_comment,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Create hash table and copy button
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
                                            HashTableStrings.func_create_hash_code,
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
                                              Clipboard.setData(ClipboardData(text: HashTableStrings.func_create_hash_code,));
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Hash code title
                                  Text(
                                    HashTableStrings.func_hash_code_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Hash code comment
                                  Text(
                                    HashTableStrings.func_hash_code_comment,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Hash code and copy button
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
                                            HashTableStrings.func_hash_code,
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
                                              Clipboard.setData(ClipboardData(text: HashTableStrings.func_hash_code));
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
                                    HashTableStrings.func_insert_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Insert comment
                                  Text(
                                    HashTableStrings.func_insert_comment,
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
                                            HashTableStrings.func_insert_code,
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
                                              Clipboard.setData(ClipboardData(text: HashTableStrings.func_insert_code,));
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
                                    HashTableStrings.func_delete_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Delete comment
                                  Text(
                                    HashTableStrings.func_delete_comment,
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
                                            HashTableStrings.func_delete_code,
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
                                              Clipboard.setData(ClipboardData(text: HashTableStrings.func_delete_code,));
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Search title
                                  Text(
                                    HashTableStrings.func_search_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Search comment
                                  Text(
                                    HashTableStrings.func_search_comment,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Search and copy button
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
                                            HashTableStrings.func_search_code,
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
                                              Clipboard.setData(ClipboardData(text: HashTableStrings.func_search_code,));
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Display title
                                  Text(
                                    HashTableStrings.func_display_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Display comment
                                  Text(
                                    HashTableStrings.func_display_comment,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Display and copy button
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
                                            HashTableStrings.func_display_code,
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
                                              Clipboard.setData(ClipboardData(text: HashTableStrings.func_display_code));
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Size title
                                  Text(
                                    HashTableStrings.func_size_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Size comment
                                  Text(
                                    HashTableStrings.func_size_comment,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Size and copy button
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
                                            HashTableStrings.func_size_code,
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
                                              Clipboard.setData(ClipboardData(text: HashTableStrings.func_size_code));
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Delete hash title
                                  Text(
                                    HashTableStrings.func_delete_hash_title,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Delete hash comment
                                  Text(
                                    HashTableStrings.func_delete_hash_comment,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Delete hash and copy button
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
                                            HashTableStrings.func_delete_hash_code,
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
                                              Clipboard.setData(ClipboardData(text: HashTableStrings.func_delete_hash_code));
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