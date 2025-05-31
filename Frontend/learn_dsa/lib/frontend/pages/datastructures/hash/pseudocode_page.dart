import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:learn_dsa/frontend/helpers/essentials.dart';
import 'package:learn_dsa/frontend/pages/datastructures/queue/queue_page.dart';
import '../../../strings/datastructure_strings/hashtable_strings.dart';
import 'animations/hash_createTable.dart';
import 'animations/hash_delete.dart';
import 'animations/hash_hashcode.dart';
import 'animations/hash_insert.dart';
import 'animations/hash_search.dart';

class PseudocodeHashTablePage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final String? userId;

  const PseudocodeHashTablePage({super.key, required this.toggleTheme, required this.userId});

  @override
  State<PseudocodeHashTablePage> createState() => _PseudocodeHashTablePageState();
}

class _PseudocodeHashTablePageState extends State<PseudocodeHashTablePage> with SingleTickerProviderStateMixin {
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
                        AppLocalizations.of(context)!.static_hashtable_title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),

                      // Create Hash Table pseudo code title
                      Text(
                        HashTableStrings.func_create_hash_title,
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Create Hash Table pseudo code
                      Text(
                        HashTableStrings.func_create_hash,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontFamily: 'Courier'
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: CreateEmptyChainedHashTable(),
                      ),

                      // Hash code pseudo code title
                      Text(
                        HashTableStrings.func_hash_code_title,
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Hash code pseudo code
                      Text(
                        HashTableStrings.func_hash_code,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      Center(
                        child: HashCodeAnimation(),
                      ),

                      const SizedBox(height: 10),

                      // Insert pseudo code title
                      Text(
                        HashTableStrings.func_insert_title,
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Insert pseudo code
                      Text(
                        HashTableStrings.func_insert,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: HashTableInsertAnimation(),
                      ),

                      const SizedBox(height: 10),

                      // Delete pseudo code title
                      Text(
                        HashTableStrings.func_delete_title,
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Delete pseudo code
                      Text(
                        HashTableStrings.func_delete,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: HashTableDeleteAnimation(),
                      ),

                      const SizedBox(height: 10),

                      // Search pseudo code title
                      Text(
                        HashTableStrings.func_search_title,
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Search pseudo code
                      Text(
                        HashTableStrings.func_search,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ChainedHashTableSearchAnimation(),
                      ),

                      const SizedBox(height: 10),

                      // Display pseudo code title
                      Text(
                        HashTableStrings.func_display_title,
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Display pseudo code
                      Text(
                        HashTableStrings.func_display,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Size pseudo code title
                      Text(
                        HashTableStrings.func_size_title,
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Size pseudo code
                      Text(
                        HashTableStrings.func_size,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Courier',
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Delete Hash pseudo code title
                      Text(
                        HashTableStrings.func_delete_hash_title,
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Delete Hash pseudo code
                      Text(
                        HashTableStrings.func_delete_hash,
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

                      Text(
                        AppLocalizations.of(context)!.dynamic_hashtable_title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
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