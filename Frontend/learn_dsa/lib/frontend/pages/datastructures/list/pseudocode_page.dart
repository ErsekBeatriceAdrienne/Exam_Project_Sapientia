import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:learn_dsa/frontend/helpers/essentials.dart';
import 'package:learn_dsa/frontend/pages/datastructures/queue/animations/queue_dequeue.dart';
import 'package:learn_dsa/frontend/pages/datastructures/queue/animations/queue_enqueue.dart';
import 'package:learn_dsa/frontend/pages/datastructures/queue/queue_page.dart';
import '../../../strings/datastructure_strings/list_strings.dart';
import '../../../strings/datastructure_strings/queue_strings.dart';
import '../hash/animations/hash_Node.dart';
import 'animations/dlist_backwardTraversal.dart';
import 'animations/dlist_forwardTraversal.dart';
import 'animations/list_deleteFromBeginning.dart';
import 'animations/list_deleteFromEnd.dart';
import 'animations/list_deleteNode.dart';
import 'animations/list_insertAfter.dart';
import 'animations/list_insertAtBeginning.dart';
import 'animations/list_insertEnd.dart';
import 'animations/list_insertSorted.dart';
import 'animations/list_newNode.dart';
import 'animations/list_search.dart';
import 'animations/list_sort.dart';

class PseudocodeListPage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final String? userId;

  const PseudocodeListPage({super.key, required this.toggleTheme, required this.userId});

  @override
  State<PseudocodeListPage> createState() => _PseudocodeListPageState();
}

class _PseudocodeListPageState extends State<PseudocodeListPage> with SingleTickerProviderStateMixin {
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
                      Text(
                        AppLocalizations.of(context)!.singly_linked_list_title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),

                      // New node pseudo code title
                      Text(
                        AppLocalizations.of(context)!.list_newnode_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // New node pseudo code
                      Text(
                        ListStrings.func_new_node_comment,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      Center(
                        child: LinkedListNewNodeAnimation(),
                      ),

                      const SizedBox(height: 10),

                      // Empty pseudo code title
                      Text(
                        AppLocalizations.of(context)!.list_isempty_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Empty pseudo code
                      Text(
                        ListStrings.func_empty_list_comment,
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
                        AppLocalizations.of(context)!.list_search_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Search node pseudo code
                      Text(
                        ListStrings.func_search_list_comment,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          height: 200,
                          child: LinkedListSearchAnimation(),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Insert node at beginning pseudo code title
                      Text(
                        AppLocalizations.of(context)!.list_insertbeginning_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Insert node at beginning pseudo code
                      Text(
                        ListStrings
                            .func_insert_node_at_beginning_comment,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      Center(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            double dynamicHeight = constraints
                                .maxHeight * 0.2;
                            return SizedBox(
                              height: dynamicHeight.clamp(
                                  150.0, 200.0),
                              child: LinkedListInsertAtBeginning(),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Insert node after pseudo code title
                      Text(
                        AppLocalizations.of(context)!.list_insertat_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Insert node after pseudo code
                      Text(
                        ListStrings
                            .func_insert_node_after_comment,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      Center(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            double dynamicHeight = constraints
                                .maxHeight * 0.2;
                            return SizedBox(
                              height: dynamicHeight.clamp(
                                  150.0, 200.0),
                              child: LinkedListInsertAfterNode(),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Insert node at end pseudo code title
                      Text(
                        AppLocalizations.of(context)!.list_insertafter_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Insert node at end pseudo code
                      Text(
                        ListStrings
                            .func_insert_node_at_end_comment,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          height: 200,
                          child: LinkedListInsertAtEndNode(),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Deleting element from beginning pseudo code title
                      Text(
                        AppLocalizations.of(context)!.list_deletebeginning_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Deleting element from beginning pseudo code
                      Text(
                        ListStrings
                            .func_delete_from_beginning_comment,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          height: 200,
                          child: LinkedListDeleteFromBeginningNode(),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Deleting element pseudo code title
                      Text(
                        AppLocalizations.of(context)!.list_deletespecific_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Deleting element pseudo code
                      Text(
                        ListStrings.func_delete_node_comment,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          height: 200,
                          child: LinkedListDeleteNode(),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Deleting element from end pseudo code title
                      Text(
                        AppLocalizations.of(context)!.list_deleteend_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Deleting element from end pseudo code
                      Text(
                        ListStrings.func_delete_from_end_comment,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          height: 200,
                          child: LinkedListDeleteFromEndNode(),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Print list pseudo code title
                      Text(
                        AppLocalizations.of(context)!.list_print_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Print list pseudo code
                      Text(
                        ListStrings.func_print_comment,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Free list pseudo code title
                      Text(
                        AppLocalizations.of(context)!.list_deletelist_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Free list pseudo code
                      Text(
                        ListStrings
                            .func_free_list_comment,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),

                      const SizedBox(height: 10),

                      Divider(),

                      const SizedBox(height: 10),

                      /// Doubly linked list
                      Text(
                        AppLocalizations.of(context)!.doubly_linked_list_title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // New node pseudo code title
                      Text(
                        AppLocalizations.of(context)!.list_newnode_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // New node pseudo code
                      Text(
                        ListStrings.func_new_node_comment1,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          child: DoublyLinkedListNewNodeAnimation(),
                        ),
                      ),

                      // Empty pseudo code title
                      Text(
                        AppLocalizations.of(context)!.list_isempty_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Empty pseudo code
                      Text(
                        ListStrings.func_empty_list_comment1,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Insert node at beginning pseudo code title
                      Text(
                        AppLocalizations.of(context)!.list_insertbeginning_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Insert node at beginning pseudo code
                      Text(
                        ListStrings.func_insert_node_at_beginning_comment1,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          height: 200,
                          child: DoublyLinkedListInsertAtBeginning(),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Insert node after pseudo code title
                      Text(
                        AppLocalizations.of(context)!.list_insertat_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Insert node after pseudo code
                      Text(
                        ListStrings.func_insert_node_after_comment1,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          height: 200,
                          child: DoublyLinkedListInsertAfterNode(),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Insert node at end pseudo code title
                      Text(
                        AppLocalizations.of(context)!.list_insertafter_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Insert node at end pseudo code
                      Text(
                        ListStrings.func_insert_node_at_end_comment1,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          height: 200,
                          child: DoublyLinkedListInsertAtEnd(),
                        ),
                      ),

                      const SizedBox(height: 10),

                      /*// Deleting element from beginning pseudo code title
                      Text(
                        AppLocalizations.of(context)!.list_deletebeginning_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Deleting element from beginning pseudo code
                      Text(
                        ListStrings.func_delete_from_beginning_comment1,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          height: 200,
                          child: DoublyLinkedListDeleteFromBeginning(),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Deleting element pseudo code title
                      Text(
                        ListStrings.func_delete_node_list_title1,
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Deleting element pseudo code
                      Text(
                        ListStrings.func_delete_node_comment1,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          height: 200,
                          child: DoublyLinkedListDeleteNode(),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Deleting element from end pseudo code title
                      Text(
                        ListStrings.func_delete_from_end_list_title1,
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Deleting element from end pseudo code
                      Text(
                        ListStrings.func_delete_from_end_comment1,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          height: 200,
                          child: DoublyLinkedListDeleteFromEndNode(),
                        ),
                      ),*/

                      const SizedBox(height: 10),

                      // Print from beginning pseudo code title
                      Text(
                        AppLocalizations.of(context)!.dlist_print_from_beginning_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Print from beginning pseudo code
                      Text(
                        ListStrings.func_print_list_beginning_comment1,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          height: 200,
                          child: DoublyLinkedListForwardTraversalAnimation(),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Print from end pseudo code title
                      Text(
                        AppLocalizations.of(context)!.dlist_print_from_end_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Print from end pseudo code
                      Text(
                        ListStrings.func_print_list_end_comment1,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          height: 200,
                          child: DoublyLinkedListBackwardTraversalAnimation(),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Divider(),

                      const SizedBox(height: 10),

                      Text(
                        AppLocalizations.of(context)!.circular_list_title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),

                      // New node pseudo code title
                      Text(
                        AppLocalizations.of(context)!.list_newnode_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // New node pseudo code
                      Text(
                        ListStrings.func_new_node_comment,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      Center(
                        child: LinkedListNewNodeAnimation(),
                      ),

                      const SizedBox(height: 10),

                      // Size of the circ list
                      Text(
                        AppLocalizations.of(context)!.circ_size_func_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Size of the circ list
                      Text(
                        ListStrings.circ_func_size,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Empty pseudo code title
                      Text(
                        AppLocalizations.of(context)!.list_isempty_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Empty pseudo code
                      Text(
                        ListStrings.func_empty_list_comment,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Insert at end pseudo code title
                      Text(
                        AppLocalizations.of(context)!.circ_insert_end_func_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Insert at end pseudo code
                      Text(
                        ListStrings.circ_func_insertatend,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      SizedBox(
                        height: 300,
                        child: CircularLinkedListInsertAtEndNode(),
                      ),


                      const SizedBox(height: 10),

                      // Delete node pseudo code title
                      Text(
                        AppLocalizations.of(context)!.bst_delete_node_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Delete node pseudo code
                      Text(
                        ListStrings.circ_func_deletenode,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Print list pseudo code title
                      Text(
                        AppLocalizations.of(context)!.print_function_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Print list pseudo code
                      Text(
                        ListStrings.circ_func_print,
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

                    _buildExplanationRow(AppLocalizations.of(context)!.list_naming_conv_1),
                    _buildExplanationRow(AppLocalizations.of(context)!.list_naming_conv_2),
                    _buildExplanationRow(AppLocalizations.of(context)!.list_naming_conv_3),
                    _buildExplanationRow(AppLocalizations.of(context)!.list_naming_conv_4),
                    _buildExplanationRow(AppLocalizations.of(context)!.list_naming_conv_5),
                    _buildExplanationRow(AppLocalizations.of(context)!.list_naming_conv_6),
                    _buildExplanationRow(AppLocalizations.of(context)!.list_naming_conv_7),
                    _buildExplanationRow(AppLocalizations.of(context)!.list_naming_conv_8),
                    _buildExplanationRow(AppLocalizations.of(context)!.list_naming_conv_9),
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