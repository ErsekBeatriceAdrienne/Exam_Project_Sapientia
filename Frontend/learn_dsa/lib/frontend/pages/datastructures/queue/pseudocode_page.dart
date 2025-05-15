import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:learn_dsa/frontend/helpers/essentials.dart';
import 'package:learn_dsa/frontend/pages/datastructures/queue/animations/queue_dequeue.dart';
import 'package:learn_dsa/frontend/pages/datastructures/queue/animations/queue_enqueue.dart';
import 'package:learn_dsa/frontend/pages/datastructures/queue/queue_page.dart';
import '../../../strings/datastructure_strings/queue_strings.dart';
import 'animations/queue_create.dart';
import 'animations/queue_display.dart';
import 'animations/queue_empty_full.dart';
import 'animations/queue_peek.dart';

class PseudocodeQueuePage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final String? userId;

  const PseudocodeQueuePage({Key? key, required this.toggleTheme, required this.userId}) : super(key: key);

  @override
  State<PseudocodeQueuePage> createState() => _PseudocodeQueuePageState();
}

class _PseudocodeQueuePageState extends State<PseudocodeQueuePage> with SingleTickerProviderStateMixin {
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
                      Essentials().createSlideRoute(
                        QueuePage(
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
                        QueueStrings.func_allocating_memory,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: AnimatedQueueCreateWidget(),
                      ),

                      const SizedBox(height: 20),

                      // Empty pseudo code title
                      Text(
                        AppLocalizations.of(context)!.queue_isempty_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Empty pseudo code
                      Text(
                        QueueStrings.func_isempty_explanation,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: AnimatedQueueEmptyWidget(),
                      ),

                      const SizedBox(height: 10),

                      // Full pseudo code title
                      Text(
                        AppLocalizations.of(context)!.queue_isfull_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Full pseudo code
                      Text(
                        QueueStrings.func_isfull_explanation,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: AnimatedQueueFullWidget(),
                      ),

                      const SizedBox(height: 10),

                      // Enqueue pseudo code title
                      Text(
                        AppLocalizations.of(context)!.queue_enqueue_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Enqueue pseudo code
                      Text(
                        QueueStrings.func_enqueue_explanation,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      Center(
                        child: AnimatedEnqueueWidget(),
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
                        QueueStrings.func_dequeue_explanation,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      Center(
                        child: AnimatedQueueDequeueWidget(),
                      ),

                      const SizedBox(height: 10),

                      // Display pseudo code title
                      Text(
                        AppLocalizations.of(context)!.queue_print_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Display pseudo code
                      Text(
                        QueueStrings.func_display_explanation,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      Center(
                        child: AnimatedQueueDisplay(),
                      ),

                      const SizedBox(height: 10),

                      // Peek pseudo code title
                      Text(
                        AppLocalizations.of(context)!.queue_peek_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Peek pseudo code
                      Text(
                        QueueStrings.func_peek_explanation,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      Center(
                        child: AnimatedQueuePeek(),
                      ),

                      const SizedBox(height: 10),

                      // Deallocating memory pseudo code title
                      Text(
                        AppLocalizations.of(context)!.queue_destroy_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Deallocating memory pseudo code
                      Text(
                        QueueStrings.func_destroy_explanation,
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