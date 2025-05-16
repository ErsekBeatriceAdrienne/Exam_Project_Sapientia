import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_dsa/frontend/helpers/essentials.dart';
import 'package:learn_dsa/frontend/pages/datastructures/queue/queue_page.dart';
import 'package:learn_dsa/frontend/pages/datastructures/stack/stack_page.dart';
import 'package:learn_dsa/frontend/pages/datastructures/tree/tree_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../backend/database/firestore_service.dart';
import '../../strings/firestore/firestore_docs.dart';
import '../splashscreen/splashscreen.dart';
import 'array/array_page.dart';
import 'hash/hashtable_page.dart';
import 'list/list_page.dart';

class DataStructuresPage extends StatefulWidget  {
  final VoidCallback toggleTheme;
  final String? userId;

  const DataStructuresPage({
    Key? key,
    required this.toggleTheme,
    required this.userId,
  }) : super(key: key);

  @override
  _DataStructuresPageState createState() => _DataStructuresPageState();
}

class _DataStructuresPageState extends State<DataStructuresPage> {
  final FirestoreService _firestoreService = FirestoreService();
  late Future<Map<String, dynamic>> _dataFuture;
  bool _showBlurOverlay = false;

  @override
  void initState() {
    super.initState();
    // Load Firestore data using the service
    _dataFuture = _firestoreService.fetchData(
      collection: FirestoreDocs.page_doc,
      documentId: FirestoreDocs.dataStructurePage,
      cacheKey: FirestoreDocs.dataStructurePage,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme
        .of(context)
        .brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Page title
              SliverAppBar(
                backgroundColor: Colors.transparent,
                pinned: true,
                floating: false,
                expandedHeight: 70,
                flexibleSpace: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      color: Theme
                          .of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(0.2),
                      child: FlexibleSpaceBar(
                        titlePadding: EdgeInsets.only(left: 16, bottom: 16),
                        title: Text(AppLocalizations.of(context)!.data_structure_page_title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF255f38), //Color(0xFFDFAEE8),
                          ),
                        ),
                      ),
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
                      // Title and Description in a rounded rectangle with shadow
                      Container(
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
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context)!.data_structure_question,
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              AppLocalizations.of(context)!.data_structure_description,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Linear Data Structure Section
                      Text(AppLocalizations.of(context)!.linear_dsa_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1f7d53),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Container(
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
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [


                            Text(AppLocalizations.of(context)!.linear_dsa_description,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),

                            // Linear Data Structure Buttons
                            GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 2.2,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                _buildCategoryButton(context, AppLocalizations.of(context)!.array_button_text, isDarkTheme),
                                _buildCategoryButton(context, AppLocalizations.of(context)!.stack_button_text, isDarkTheme),
                                _buildCategoryButton(context, AppLocalizations.of(context)!.queue_button_text, isDarkTheme),
                                _buildCategoryButton(context, AppLocalizations.of(context)!.list_button_text, isDarkTheme),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Non-Linear Data Structure Section
                      Text(AppLocalizations.of(context)!.nonlinear_dsa_title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1f7d53),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Container(
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
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context)!.nonlinear_dsa_description,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),

                            // Non-Linear Data Structure Buttons
                            GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 2.2,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                _buildCategoryButton(context, AppLocalizations.of(context)!.bst_button_text,
                                    isDarkTheme),
                                _buildCategoryButton(context, AppLocalizations.of(context)!.hash_button_text,
                                    isDarkTheme),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Complexity Table Section
                      Container(
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
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context)!.data_structure_complexity_table_title,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),

                      const SizedBox(height: 65),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );


  }

  Widget _buildCategoryButton(BuildContext context, String title, bool isDarkTheme) {
    // Define the gradient colors
    final gradient = LinearGradient(
      // Gradient colors
      colors: [Color(0xFF255f38), Color(0xFF27391c)], //[Color(0xFFa1f7ff), Color(0xFFDFAEE8)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    // Define a map for title-to-page navigation
    final pageMap = {
      AppLocalizations.of(context)!.array_button_text: () => ArrayPage(
        toggleTheme: widget.toggleTheme,
        userId: widget.userId,
      ),
      AppLocalizations.of(context)!.stack_button_text: () => StackPage(
        toggleTheme: widget.toggleTheme,
        userId: widget.userId,
      ),
      AppLocalizations.of(context)!.queue_button_text: () => QueuePage(toggleTheme: widget.toggleTheme, userId: widget.userId),
      AppLocalizations.of(context)!.list_button_text: () => ListPage(toggleTheme: widget.toggleTheme, userId: widget.userId),
      AppLocalizations.of(context)!.hash_button_text: () => HashTablePage(),
      AppLocalizations.of(context)!.bst_button_text: () => BSTPage()
    };

    return ElevatedButton(
      onPressed: () {
        HapticFeedback.heavyImpact();

        // Navigate to the appropriate page using the map
        final pageBuilder = pageMap[title];
        if (pageBuilder != null) {
          Navigator.push(
            context,
            Essentials().createSlideRoute(pageBuilder()),
          );
          HapticFeedback.mediumImpact();
        }

      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
      ),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: gradient,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const Positioned(
                top: 8,
                right: 8,
                child: Icon(
                  Icons.arrow_circle_right_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
