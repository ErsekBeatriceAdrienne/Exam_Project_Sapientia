import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_dsa/frontend/pages/datastructures/stack/stack_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../strings/datastructure_strings/stack_strings.dart';
import 'animations/stack_create.dart';
import 'animations/stack_empty_full.dart';
import 'animations/stack_peek.dart';
import 'animations/stack_pop.dart';
import 'animations/stack_push.dart';
import 'animations/stack_size.dart';

class PseudocodeStackPage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final String? userId;

  const PseudocodeStackPage({Key? key, required this.toggleTheme, required this.userId}) : super(key: key);

  @override
  State<PseudocodeStackPage> createState() => _PseudocodeStackPageState();
}

class _PseudocodeStackPageState extends State<PseudocodeStackPage> with SingleTickerProviderStateMixin {
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

                      // Allocating memory pseudo code title
                      Text(
                        AppLocalizations.of(context)!.allocate_memory_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Allocating memory pseudo code
                      Text(
                        StackStrings.func_allocating_memory,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontFamily: 'Courier'
                        ),
                      ),
                      Center(
                        child: AnimatedStackCreateWidget(),
                      ),

                      const SizedBox(height: 10),

                      // isFull pseudo code title
                      Text(
                        AppLocalizations.of(context)!.stack_isfull_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // isFull pseudo code
                      Text(
                        StackStrings.func_isfull_explanation,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontFamily: 'Courier'
                        ),
                      ),

                      Center(
                        child: AnimatedStackIsFullWidget(),
                      ),

                      const SizedBox(height: 10),

                      // isEmpty pseudo code title
                      Text(
                        AppLocalizations.of(context)!.stack_isempty_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // isEmpty pseudo code
                      Text(
                        StackStrings.func_isempty_explanation,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontFamily: 'Courier'
                        ),
                      ),

                      Center(
                        child: AnimatedStackIsEmptyWidget(),
                      ),

                      const SizedBox(height: 10),

                      // Push pseudo code title
                      Text(
                        AppLocalizations.of(context)!.stack_push_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Push pseudo code
                      Text(
                        StackStrings.func_push_explanation,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontFamily: 'Courier'
                        ),
                      ),

                      Center(
                        child: AnimatedStackPushWidget(),
                      ),

                      const SizedBox(height: 10),

                      // Pop pseudo code title
                      Text(
                        AppLocalizations.of(context)!.stack_pop_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Pop pseudo code
                      Text(
                        StackStrings.func_pop_explanation,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontFamily: 'Courier'
                        ),
                      ),

                      Center(
                        child: AnimatedStackPopWidget(),
                      ),

                      const SizedBox(height: 10),

                      // Peek pseudo code title
                      Text(
                        AppLocalizations.of(context)!.stack_peek_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Peek pseudo code
                      Text(
                        StackStrings.func_top_explanation,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),

                      Center(
                        child: AnimatedStackPeekWidget(),
                      ),

                      const SizedBox(height: 10),

                      // Size pseudo code title
                      Text(
                        AppLocalizations.of(context)!.stack_size_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Size pseudo code
                      Text(
                        StackStrings.func_size_explanation,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),

                      Center(
                        child: AnimatedStackSizeWidget(),
                      ),

                      const SizedBox(height: 10),

                      // Destroy pseudo code title
                      Text(
                        AppLocalizations.of(context)!.stack_clear_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Destroy pseudo code
                      Text(
                        StackStrings.func_destroy_explanation,
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

          /*if (_showExplanation)
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
                      ArrayStrings.pseudo_code_explanation_title,
                      style: const TextStyle(
                        color: Color(0xFF255f38),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    _buildExplanationRow(ArrayStrings.pseudo_code_explanation),
                    _buildExplanationRow(ArrayStrings.pseudo_code_explanation1),
                    _buildExplanationRow(ArrayStrings.pseudo_code_explanation2),
                    _buildExplanationRow(ArrayStrings.pseudo_code_explanation3),
                    _buildExplanationRow(ArrayStrings.pseudo_code_explanation4),
                    _buildExplanationRow(ArrayStrings.pseudo_code_explanation5),
                    _buildExplanationRow(ArrayStrings.pseudo_code_explanation6),
                    _buildExplanationRow(ArrayStrings.pseudo_code_explanation9),
                    _buildExplanationRow(ArrayStrings.pseudo_code_explanation10),
                    _buildExplanationRow(ArrayStrings.pseudo_code_explanation7),
                    _buildExplanationRow(ArrayStrings.pseudo_code_explanation8),
                  ],
                ),
              ),
            ),
*/
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