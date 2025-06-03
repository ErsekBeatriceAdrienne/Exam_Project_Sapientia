import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_dsa/frontend/pages/datastructures/array/array_page.dart';
import '../../../strings/datastructure_strings/array_strings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'animations/array_allocating.dart';
import 'animations/array_deleteAt.dart';
import 'animations/array_empty_full.dart';
import 'animations/array_getItem.dart';
import 'animations/array_insertAt.dart';
import 'animations/array_insertFirst.dart';
import 'animations/array_insertLast.dart';
import 'animations/array_print.dart';
import 'animations/array_search.dart';
import 'animations/array_update.dart';

class PseudocodeArrayPage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final String? userId;

  const PseudocodeArrayPage({super.key, required this.toggleTheme, required this.userId});

  @override
  State<PseudocodeArrayPage> createState() => _PseudocodeArrayPageState();
}

class _PseudocodeArrayPageState extends State<PseudocodeArrayPage> with SingleTickerProviderStateMixin {
  bool _showExplanation = false;

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
                        builder: (_) => ArrayPage(
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
                      // Allocating memory pseudo code title
                      Text(
                        AppLocalizations.of(context)!.allocate_memory_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),

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

                      const SizedBox(height: 20),

                      // Printing pseudo code title
                      Text(
                        AppLocalizations.of(context)!.print_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(height: 10),

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
                      Center(
                        child: AnimatedArrayPrintWidget(),
                      ),

                      const SizedBox(height: 20),

                      // Empty pseudo code title
                      Text(
                        AppLocalizations.of(context)!.array_isempty_function_title,
                        style: TextStyle(
                          fontSize: 21,
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
                      Center(
                        child: ArrayAllocationEmptyWidget(),
                      ),

                      const SizedBox(height: 10),

                      // Full pseudo code title
                      Text(
                        AppLocalizations.of(context)!.array_isfull_function_title,
                        style: TextStyle(
                          fontSize: 21,
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
                      Center(
                        child: AnimatedArrayFullWidget(),
                      ),

                      const SizedBox(height: 10),

                      // Get item at pseudo code title
                      Text(
                        AppLocalizations.of(context)!.array_getitem_function_title,
                        style: TextStyle(
                          fontSize: 21,
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
                      Center(
                        child: AnimatedArrayGetItemWidget(),
                      ),

                      const SizedBox(height: 10),

                      // Inserting first pseudo code title
                      Text(
                        AppLocalizations.of(context)!.array_insertfirst_function_title,
                        style: TextStyle(
                          fontSize: 21,
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
                        AppLocalizations.of(context)!.array_insertat_function_title,
                        style: TextStyle(
                          fontSize: 21,
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
                        AppLocalizations.of(context)!.array_insertlast_function_title,
                        style: TextStyle(
                          fontSize: 21,
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

                      // Deleting element pseudo code title
                      Text(
                        AppLocalizations.of(context)!.array_deleteitem_function_title,
                        style: TextStyle(
                          fontSize: 21,
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

                      // Search pseudo code title
                      Text(
                        AppLocalizations.of(context)!.array_search_function_title,
                        style: TextStyle(
                          fontSize: 21,
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
                      Center(
                        child: AnimatedArraySearchWidget(),
                      ),

                      const SizedBox(height: 10),

                      // Update pseudo code title
                      Text(
                        AppLocalizations.of(context)!.array_update_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Update pseudo code
                      Text(
                        ArrayStrings.func_update,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      Center(
                        child: AnimatedArrayUpdateWidget(),
                      ),

                      const SizedBox(height: 10),

                      // Deallocating memory pseudo code title
                      Text(
                        AppLocalizations.of(context)!.array_deallocate_function_title,
                        style: TextStyle(
                          fontSize: 21,
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

                    _buildExplanationRow(AppLocalizations.of(context)!.array_naming_conv_1),
                    _buildExplanationRow(AppLocalizations.of(context)!.array_naming_conv_2),
                    _buildExplanationRow(AppLocalizations.of(context)!.array_naming_conv_3),
                    _buildExplanationRow(AppLocalizations.of(context)!.array_naming_conv_4),
                    _buildExplanationRow(AppLocalizations.of(context)!.array_naming_conv_5),
                    _buildExplanationRow(AppLocalizations.of(context)!.array_naming_conv_6),
                    _buildExplanationRow(AppLocalizations.of(context)!.array_naming_conv_7),
                    _buildExplanationRow(AppLocalizations.of(context)!.array_naming_conv_8),
                    _buildExplanationRow(AppLocalizations.of(context)!.array_naming_conv_9),
                    _buildExplanationRow(AppLocalizations.of(context)!.array_naming_conv_10),
                    _buildExplanationRow(AppLocalizations.of(context)!.array_naming_conv_11),
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