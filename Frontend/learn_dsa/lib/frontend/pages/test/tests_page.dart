import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_dsa/frontend/helpers/essentials.dart';
import 'package:learn_dsa/frontend/pages/test/testpages/all_data_structure_testpage.dart';
import 'package:learn_dsa/frontend/pages/test/testpages/array_testpage.dart';
import 'package:learn_dsa/frontend/pages/test/testpages/bst_testpage.dart';
import 'package:learn_dsa/frontend/pages/test/testpages/hash_testpage.dart';
import 'package:learn_dsa/frontend/pages/test/testpages/list_tests_preview.dart';
import 'package:learn_dsa/frontend/pages/test/testpages/queue_testpage.dart';
import 'package:learn_dsa/frontend/pages/test/testpages/stack_testpage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../customClasses/custom_bar_chart.dart';

class TestsPage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final String? userId;

  const TestsPage({super.key, required this.toggleTheme, required this.userId});

  @override
  State<TestsPage> createState() => _TestsPageState();
}

class _TestsPageState extends State<TestsPage> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme
        .of(context)
        .brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Appbar title
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
                    title: Text(AppLocalizations.of(context)!.test_page_title,
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
          // Body
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  // Tests
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
                        Text(AppLocalizations.of(context)!.test_page_test_title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          AppLocalizations.of(context)!.test_page_test_text,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Array and Stack buttons
                        Row(
                          children: [
                            Expanded(
                              child: _buildCardItem(
                                AppLocalizations.of(context)!.array_button_text,
                                    () {
                                  Navigator.push(
                                    context,
                                    Essentials().createSlideRoute(
                                        ArrayTestPage(toggleTheme: widget.toggleTheme,
                                            userId: widget.userId)),
                                  );
                                  HapticFeedback.mediumImpact();
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildCardItem(
                                AppLocalizations.of(context)!.stack_button_text,
                                    () {
                                  Navigator.push(
                                    context,
                                    Essentials().createSlideRoute(
                                        StackTestPage(toggleTheme: widget.toggleTheme,
                                            userId: widget.userId)),
                                  );
                                  HapticFeedback.mediumImpact();
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // Queue and List buttons
                        Row(
                          children: [
                            Expanded(
                              child: _buildCardItem(
                                AppLocalizations.of(context)!.queue_button_text,
                                    () {
                                  Navigator.push(
                                    context,
                                    Essentials().createSlideRoute(
                                        QueueTestPage(toggleTheme: widget.toggleTheme,
                                            userId: widget.userId)),
                                  );
                                  HapticFeedback.mediumImpact();
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildCardItem(
                                AppLocalizations.of(context)!.list_button_text,
                                    () {
                                  Navigator.push(
                                    context,
                                    Essentials().createSlideRoute(ListTestPage(
                                        toggleTheme: widget.toggleTheme,
                                        userId: widget.userId)),
                                  );
                                  HapticFeedback.mediumImpact();
                                },
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // Binary Tree and Hash Table buttons
                        Row(
                          children: [
                            Expanded(
                              child: _buildCardItem(
                                AppLocalizations.of(context)!.bst_button_text,
                                    () {
                                  Navigator.push(
                                    context,
                                    Essentials().createSlideRoute(BSTTestPage(
                                        toggleTheme: widget.toggleTheme,
                                        userId: widget.userId)),
                                  );
                                  HapticFeedback.mediumImpact();
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildCardItem(
                                AppLocalizations.of(context)!.hash_button_text,
                                    () {
                                  Navigator.push(
                                    context,
                                    Essentials().createSlideRoute(
                                        HashTableTestPage(
                                            toggleTheme: widget.toggleTheme,
                                            userId: widget.userId)),
                                  );
                                  HapticFeedback.mediumImpact();
                                },
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    AppLocalizations.of(context)!.answered_questions_text_title,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1f7d53)),
                  ),

                  const SizedBox(height: 10),

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
                        SizedBox(
                          height: 200,
                          child: TestResultsChart(results: [10, 15, 8, 12, 20, 18]),
                        ),
                        const SizedBox(height: 10),
                        ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // All kind of test questions
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
                        Text(AppLocalizations.of(context)!.all_kind_of_questions_title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          AppLocalizations.of(context)!.test_page_test_text,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),

                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: _buildCardItem(
                            AppLocalizations.of(context)!.all_kind_of_questions,
                                () {
                              Navigator.push(
                                context,
                                Essentials().createSlideRoute(
                                  AllDataStructureTestPage(
                                    toggleTheme: widget.toggleTheme,
                                    userId: widget.userId,
                                  ),
                                ),
                              );
                              HapticFeedback.mediumImpact();
                            },
                          ),
                        ),

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

  Widget _buildCardItem(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF255f38),
              Color(0xFF27391c),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 6,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Theme
                    .of(context)
                    .scaffoldBackgroundColor,
              ),
            ),
            const Spacer(),
            Icon(Icons.chevron_right, color: Theme
                .of(context)
                .scaffoldBackgroundColor),
          ],
        ),
      ),
    );
  }
}



//const SizedBox(height: 10),

// Exercises
/*Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(12),
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

                        Text(AppLocalizations.of(context)!
                            .test_page_exercises_title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),

                        Text(AppLocalizations.of(context)!
                            .test_page_exercises_text,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Array and Stack buttons
                        Row(
                          children: [
                            Expanded(
                              child: _buildCardItem(
                                AppLocalizations.of(context)!.array_button_text,
                                    () {
                                  Navigator.push(
                                    context,
                                    Essentials().createSlideRoute(
                                        ArrayExercisesPage(toggleTheme: widget.toggleTheme,
                                            userId: widget.userId)),
                                  );
                                  HapticFeedback.mediumImpact();
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildCardItem(
                                AppLocalizations.of(context)!.stack_button_text,
                                    () {
                                  Navigator.push(
                                    context,
                                    Essentials().createSlideRoute(
                                        StackExercisesPage(toggleTheme: widget.toggleTheme,
                                            userId: widget.userId)),
                                  );
                                  HapticFeedback.mediumImpact();
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // Queue and List buttons
                        Row(
                          children: [
                            Expanded(
                              child: _buildCardItem(
                                AppLocalizations.of(context)!.queue_button_text,
                                    () {
                                  Navigator.push(
                                    context,
                                    Essentials().createSlideRoute(
                                        QueueExercisesPage(toggleTheme: widget.toggleTheme,
                                            userId: widget.userId)),
                                  );
                                  HapticFeedback.mediumImpact();
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildCardItem(
                                AppLocalizations.of(context)!.list_button_text,
                                    () {
                                  Navigator.push(
                                    context,
                                    Essentials().createSlideRoute(
                                        ListExercisesPage(
                                            toggleTheme: widget.toggleTheme,
                                            userId: widget.userId)),
                                  );
                                  HapticFeedback.mediumImpact();
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // Binary Tree and Hash Table buttons
                        Row(
                          children: [
                            Expanded(
                              child: _buildCardItem(
                                AppLocalizations.of(context)!.bst_button_text,
                                    () {
                                  Navigator.push(
                                    context,
                                    Essentials().createSlideRoute(
                                        BSTExercisesPage(
                                            toggleTheme: widget.toggleTheme,
                                            userId: widget.userId)),
                                  );
                                  HapticFeedback.mediumImpact();
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildCardItem(
                                AppLocalizations.of(context)!.hash_button_text,
                                    () {
                                  Navigator.push(
                                    context,
                                    Essentials().createSlideRoute(
                                        HashTableExercisesPage(
                                            toggleTheme: widget.toggleTheme,
                                            userId: widget.userId)),
                                  );
                                  HapticFeedback.mediumImpact();
                                },
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                      ],
                    ),
                  ),*/

//const SizedBox(height: 20),
