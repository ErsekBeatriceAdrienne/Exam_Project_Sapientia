import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_dsa/frontend/pages/algorithms/searching/searching_algorithms_page.dart';
import 'package:learn_dsa/frontend/pages/algorithms/sorting/sorting_algorithms_page.dart';
import '../../../backend/database/firestore_service.dart';
import '../../helpers/essentials.dart';
import '../../strings/firestore/firestore_docs.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'complex/backtracking/backtracking_algorithm.dart';
import 'complex/divide_at_impera_alg/divide_at_impera.dart';
import 'complex/greedy_algorithm/greedy_algorithms.dart';

class AlgorithmsPage extends StatefulWidget  {
  final VoidCallback toggleTheme;
  final String? userId;

  const AlgorithmsPage({
    super.key,
    required this.toggleTheme,
    required this.userId,
  });

  @override
  _AlgorithmsPageState createState() => _AlgorithmsPageState();
}

class _AlgorithmsPageState extends State<AlgorithmsPage> {
  final FirestoreService _firestoreService = FirestoreService();
  late Future<Map<String, dynamic>> _dataFuture;

  @override
  void initState() {
    super.initState();
    // Load Firestore data using the service
    _dataFuture = _firestoreService.fetchData(
      collection: FirestoreDocs.page_doc,
      documentId: FirestoreDocs.algorithmsPage,
      cacheKey: FirestoreDocs.algorithmsPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

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
                  color: Theme
                      .of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.2),
                  child: FlexibleSpaceBar(
                    titlePadding: EdgeInsets.only(left: 16, bottom: 16),
                    title: Text(AppLocalizations.of(context)!.algorithms_menu,
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
                        Text(AppLocalizations.of(context)!.algorithms_page_question,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          AppLocalizations.of(context)!.algorithms_page_description,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    AppLocalizations.of(context)!.simple_algorithms,
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1f7d53),
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.simple_algorithms_description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),

                  // Button
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2.2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildCategoryButton(context, AppLocalizations.of(context)!.sorting_algorithms_button_title, isDarkTheme),
                      _buildCategoryButton(context, AppLocalizations.of(context)!.searching_algorithms_button_title, isDarkTheme),
                      ],
                  ),

                  const SizedBox(height: 20),

                  Text(
                    AppLocalizations.of(context)!.complex_algorithms,
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1f7d53),
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.complex_algorithms_description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),

                  // Button
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2.2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildCategoryButton(context, AppLocalizations.of(context)!.greedy_algorithm_button_title, isDarkTheme),
                      _buildCategoryButton(context, AppLocalizations.of(context)!.divide_at_impera_button_title, isDarkTheme),
                      _buildCategoryButton(context, AppLocalizations.of(context)!.backtracking_button_title, isDarkTheme),
                      //_buildCategoryButton(context, AppLocalizations.of(context)!.dynamic_prog_button_text, isDarkTheme),
                    ],
                  ),

                  const SizedBox(height: 24),

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
                        Text(AppLocalizations.of(context)!.algorithms_complexity_table,
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
  }

  Widget _buildCategoryButton(BuildContext context, String title, bool isDarkTheme) {
    final gradient = LinearGradient(
      colors: [Color(0xFF255f38), Color(0xFF27391c)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final pageMap = {
      AppLocalizations.of(context)!.sorting_algorithms_button_title: () => SortingAlgorithmsPage(toggleTheme: widget.toggleTheme, userId: widget.userId),
      AppLocalizations.of(context)!.searching_algorithms_button_title: () => SearchingAlgorithmsPage(toggleTheme: widget.toggleTheme, userId: widget.userId),
      AppLocalizations.of(context)!.greedy_algorithm_button_title: () => GreedyAlgorithmsPage(toggleTheme: widget.toggleTheme, userId: widget.userId),
      AppLocalizations.of(context)!.divide_at_impera_button_title: () => DivideAtImperaAlgorithmsPage(toggleTheme: widget.toggleTheme, userId: widget.userId),
      AppLocalizations.of(context)!.backtracking_button_title: () => BacktrackingAlgorithmsPage(toggleTheme: widget.toggleTheme, userId: widget.userId),
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