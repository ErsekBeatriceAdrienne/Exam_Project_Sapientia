import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_dsa/frontend/pages/datastructures/queue/queue_page.dart';
import 'package:learn_dsa/frontend/pages/datastructures/stack/stack_page.dart';
import 'package:learn_dsa/frontend/pages/datastructures/tree/tree_page.dart';
import '../../../backend/database/firestore_service.dart';
import '../../strings/firestore/firestore_docs.dart';
import 'array/array_page.dart';
import 'graph/graph_page.dart';
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
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return FutureBuilder<Map<String, dynamic>>(
      future: _dataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (!snapshot.hasData) {
          return Scaffold(
            body: Center(child: Text('No data available')),
          );
        }

        // Extracting data from snapshot
        final data = snapshot.data!;

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                pinned: true,
                floating: false,
                expandedHeight: 70,
                flexibleSpace: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      color: Theme.of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(0.2),
                      child: FlexibleSpaceBar(
                        titlePadding: EdgeInsets.only(left: 16, bottom: 16),
                        title: Text(
                          data[FirestoreDocs.dataStructurePageTitle],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFDFAEE8),
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
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
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
                            Text(
                              data[FirestoreDocs.dataStructurePageDefinitionQuestion],
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              data[FirestoreDocs.dataStructurePageDefinitionText] ,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Linear Data Structure Section
                      Text(
                        data[FirestoreDocs.dataStructurePageLinearDsaTitle],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        data[FirestoreDocs.dataStructurePageLinearDsaDefinition] ,
                        style: TextStyle(
                          fontSize: 14,
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
                          _buildCategoryButton(context, data[FirestoreDocs.dataStructurePageArrayButtonText], isDarkTheme),
                          _buildCategoryButton(context, data[FirestoreDocs.dataStructurePageStackButtonText], isDarkTheme),
                          _buildCategoryButton(context, data[FirestoreDocs.dataStructurePageQueueButtonText], isDarkTheme),
                          _buildCategoryButton(context, data[FirestoreDocs.dataStructurePageListButtonText], isDarkTheme),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Non-Linear Data Structure Section
                      Text(
                        data[FirestoreDocs.dataStructurePageNonlinearDsaTitle],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        data[FirestoreDocs.dataStructurePageNonlinearDsaDefinition] ,
                        style: TextStyle(
                          fontSize: 14,
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
                          _buildCategoryButton(context, data[FirestoreDocs.dataStructurePageGraphButtonText], isDarkTheme),
                          _buildCategoryButton(context, data[FirestoreDocs.dataStructurePageBstButtonText], isDarkTheme),
                          _buildCategoryButton(context, data[FirestoreDocs.dataStructurePageHashButtonText], isDarkTheme),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Complexity Table Section
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
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
                            Text(
                              data[FirestoreDocs.dataStructurePageComplexityTableDsaText],
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
        );
      },
    );
  }

  Widget _buildCategoryButton(BuildContext context, String title, bool isDarkTheme) {
    // Define the gradient colors
    final gradient = LinearGradient(
      // Gradient colors
      colors: [Color(0xFFa1f7ff), Color(0xFFDFAEE8)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    // Define a map for title-to-page navigation
    final pageMap = {
      "Array": () => ArrayPage(
        toggleTheme: widget.toggleTheme,
        userId: widget.userId,
      ),
      "Stack": () => StackPage(),
      "Queue": () => QueuePage(),
      "List": () => ListPage(),
      "HashTable": () => HashTablePage(),
      "Binary Search Tree": () => BSTPage(),
      "Graph": () => GraphPage(),
    };

    return ElevatedButton(
      onPressed: () {
        HapticFeedback.heavyImpact();

        // Navigate to the appropriate page using the map
        final pageBuilder = pageMap[title];
        if (pageBuilder != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => pageBuilder()),
          );
        } else {
          // Handle cases where the title doesn't match any page
          print("Page not found for title: $title");
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
      ),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: gradient,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 2),
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