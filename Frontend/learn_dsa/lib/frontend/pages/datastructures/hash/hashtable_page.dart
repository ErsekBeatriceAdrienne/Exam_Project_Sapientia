import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_dsa/frontend/pages/datastructures/hash/pseudocode_page.dart';
import '../../../helpers/essentials.dart';
import '../../../strings/datastructure_strings/hashtable_strings.dart';
import '../../customClasses/custom_closing_button_copyCode.dart';
import '../../test/testpages/hash_testpage.dart';
import '../datastructures_page.dart';
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

                              Center(
                                child: Stack(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Essentials().buildHighlightedCodeLines(
                                        HashTableStrings.hash_empty_initialization,
                                      ),
                                    ),

                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: IconButton(
                                        icon: Icon(Icons.copy, color: Colors.black),
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
                                      text: AppLocalizations.of(context)!.static_hash_basics_11,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: ' ${AppLocalizations.of(context)!.static_hash_basics_12}',
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
                                      text: AppLocalizations.of(context)!.static_hash_basics_21,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: ' ${AppLocalizations.of(context)!.static_hash_basics_22}',
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
                                      text: AppLocalizations.of(context)!.static_hash_basics_31,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: ' ${AppLocalizations.of(context)!.static_hash_basics_32}',
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
                                      text: AppLocalizations.of(context)!.static_hash_basics_41,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: ' ${AppLocalizations.of(context)!.static_hash_basics_42}',
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
                                      text: AppLocalizations.of(context)!.static_hash_basics_51,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: ' ${AppLocalizations.of(context)!.static_hash_basics_52}',
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
                                      text: AppLocalizations.of(context)!.static_hash_basics_61,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: ' ${AppLocalizations.of(context)!.static_hash_basics_62}',
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
                                      text: AppLocalizations.of(context)!.static_hash_basics_71,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: ' ${AppLocalizations.of(context)!.static_hash_basics_72}',
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
                                      text: AppLocalizations.of(context)!.static_hash_basics_81,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: ' ${AppLocalizations.of(context)!.static_hash_basics_82}',
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
                        CollapsibleCodeBlock(title: AppLocalizations.of(context)!.header_file_title, codeContent: HashTableStrings.header_file_content),

                        const SizedBox(height: 20),

                        // Complete .c file
                        CollapsibleCodeBlock(title: AppLocalizations.of(context)!.source_file_title, codeContent: HashTableStrings.source_file_content),

                        const SizedBox(height: 20),

                        // What is a dynamic Hash table?
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
                              Text(AppLocalizations.of(context)!.dynamic_hash_question,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10),

                              // Array description, what is an array
                              Text(AppLocalizations.of(context)!.dynamic_hash_description,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey,
                                ),
                              ),

                              const SizedBox(height: 10),

                              Center(
                                child: ChainedDynamicHashTableAnimation(),
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
                                      text: AppLocalizations.of(context)!.static_hash_struct_explanation_71,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: ' ${AppLocalizations.of(context)!.static_hash_struct_explanation_72}',
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.start,
                                softWrap: true,
                              ),

                              Center(
                                child: Stack(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Essentials().buildHighlightedCodeLines(
                                        HashTableStrings.hash_empty_initialization2,
                                      ),
                                    ),

                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: IconButton(
                                        icon: Icon(Icons.copy, color: Colors.black),
                                        onPressed: () {
                                          Clipboard.setData(
                                            ClipboardData(text: HashTableStrings.hash_empty_initialization2),
                                          );
                                          HapticFeedback.mediumImpact();
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(AppLocalizations.of(context)!.code_copied_text),
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
                                      text: AppLocalizations.of(context)!.static_hash_basics_11,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: ' ${AppLocalizations.of(context)!.static_hash_basics_12}',
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
                                      text: AppLocalizations.of(context)!.static_hash_basics_21,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: ' ${AppLocalizations.of(context)!.static_hash_basics_22}',
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
                                      text: AppLocalizations.of(context)!.static_hash_basics_31,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: ' ${AppLocalizations.of(context)!.static_hash_basics_32}',
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
                                      text: AppLocalizations.of(context)!.static_hash_basics_41,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: ' ${AppLocalizations.of(context)!.static_hash_basics_42}',
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
                                      text: AppLocalizations.of(context)!.static_hash_basics_51,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: ' ${AppLocalizations.of(context)!.static_hash_basics_52}',
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
                                      text: AppLocalizations.of(context)!.static_hash_basics_61,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: ' ${AppLocalizations.of(context)!.static_hash_basics_62}',
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
                                      text: AppLocalizations.of(context)!.static_hash_basics_71,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: ' ${AppLocalizations.of(context)!.static_hash_basics_72}',
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
                                      text: AppLocalizations.of(context)!.static_hash_basics_81,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: ' ${AppLocalizations.of(context)!.static_hash_basics_82}',
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
                        CollapsibleCodeBlock(title: AppLocalizations.of(context)!.header_file_title, codeContent: HashTableStrings.header_file_content1),

                        const SizedBox(height: 20),

                        // Complete .c file
                        CollapsibleCodeBlock(title: AppLocalizations.of(context)!.source_file_title, codeContent: HashTableStrings.source_file_content1),

                        const SizedBox(height: 20),

                        Text(AppLocalizations.of(context)!
                            .when_to_use_title,
                          style: TextStyle(
                            color: Color(0xFF1f7d53),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                                            .hash_table_when_to_use_1,
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
                                            .hash_table_when_to_use_2,
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
                                            .hash_table_when_to_use_3,
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
                                            .hash_table_when_not_to_use_1,
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
                                            .hash_table_when_not_to_use_2,
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
                                            .hash_table_when_not_to_use_3,
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