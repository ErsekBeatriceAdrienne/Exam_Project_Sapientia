import 'dart:io';
import 'dart:ui';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_dsa/frontend/helpers/essentials.dart';
import 'package:learn_dsa/frontend/pages/test/testpages/array_testpage.dart';
import 'package:learn_dsa/frontend/pages/test/testpages/bst_testpage.dart';
import 'package:learn_dsa/frontend/pages/test/testpages/hash_testpage.dart';
import 'package:learn_dsa/frontend/pages/test/testpages/list_testpage.dart';
import 'package:learn_dsa/frontend/pages/test/testpages/queue_testpage.dart';
import 'package:learn_dsa/frontend/pages/test/testpages/stack_testpage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pie_chart/pie_chart.dart' as pie;
import '../../../backend/compiler/c_compiler.dart';
import '../../pages/exercises/array_exercises.dart';
import '../../pages/exercises/binarytree_exercises.dart';
import '../../pages/exercises/hashtable_exercises.dart';
import '../../pages/exercises/list_exercises.dart';
import '../../pages/exercises/queue_exercises.dart';
import '../../pages/exercises/stack_exercises.dart';
import '../../strings/test/test_strings.dart';
import '../customClasses/custom_ring_chart.dart';
import '../profile/test_results.dart';

class TestsPage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final String? userId;

  const TestsPage({Key? key, required this.toggleTheme, required this.userId}) : super(key: key);

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
                  //const SizedBox(height: 10),

                  // Exercises
                  Container(
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
                                Icons.data_array,
                                    () {
                                  Navigator.push(
                                    context,
                                    Essentials().createSlideRoute(
                                        ArrayExercisesPage()),
                                  );
                                  HapticFeedback.mediumImpact();
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildCardItem(
                                AppLocalizations.of(context)!.stack_button_text,
                                Icons.storage_rounded,
                                    () {
                                  Navigator.push(
                                    context,
                                    Essentials().createSlideRoute(
                                        StackExercisesPage()),
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
                                Icons.queue,
                                    () {
                                  Navigator.push(
                                    context,
                                    Essentials().createSlideRoute(
                                        QueueExercisesPage()),
                                  );
                                  HapticFeedback.mediumImpact();
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildCardItem(
                                AppLocalizations.of(context)!.list_button_text,
                                Icons.list_alt,
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
                                Icons.account_tree_outlined,
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
                                Icons.table_rows_outlined,
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

                        const SizedBox(height: 20),

                        Text(AppLocalizations.of(context)!
                            .test_page_achievements_title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),

                        Center(
                          child: const RingChartWidget(),
                        ),
                      ],
                    ),
                  ),
                  /*Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(12),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),

                            Text(AppLocalizations.of(context)!.test_page_exercises_text,
                              style: TextStyle(
                                color: Colors.black,
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
                                    Icons.data_array,
                                        () {
                                      Navigator.push(
                                        context,
                                        Essentials().createSlideRoute(ArrayExercisesPage()),
                                      );
                                      HapticFeedback.mediumImpact();
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _buildCardItem(
                                    AppLocalizations.of(context)!.stack_button_text,
                                    Icons.storage_rounded,
                                        () {
                                      Navigator.push(
                                        context,
                                        Essentials().createSlideRoute(StackExercisesPage()),
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
                                    Icons.queue,
                                        () {
                                      Navigator.push(
                                        context,
                                        Essentials().createSlideRoute(QueueExercisesPage()),
                                      );
                                      HapticFeedback.mediumImpact();
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _buildCardItem(
                                    AppLocalizations.of(context)!.list_button_text,
                                    Icons.list_alt,
                                        () {
                                      Navigator.push(
                                        context,
                                        Essentials().createSlideRoute(ListExercisesPage(toggleTheme: widget.toggleTheme, userId: widget.userId)),
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
                                    Icons.account_tree_outlined,
                                        () {
                                      Navigator.push(
                                        context,
                                        Essentials().createSlideRoute(BSTExercisesPage(toggleTheme: widget.toggleTheme, userId: widget.userId)),
                                      );
                                      HapticFeedback.mediumImpact();
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _buildCardItem(
                                    AppLocalizations.of(context)!.hash_button_text,
                                    Icons.table_rows_outlined,
                                        () {
                                      Navigator.push(
                                        context,
                                        Essentials().createSlideRoute(HashTableExercisesPage(toggleTheme: widget.toggleTheme, userId: widget.userId)),
                                      );
                                      HapticFeedback.mediumImpact();
                                    },
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            Text(AppLocalizations.of(context)!.test_page_achievements_title,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),

                            Center(
                              child: buildRingChart(),
                            ),
                          ],
                        ),
                      ),

                      Positioned(
                        top: -23,
                        left: 16,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              // Gradient colors
                              colors: [
                                Color(0xFF255f38),
                                Color(0xFF27391c)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 8.0,
                          ),
                          child: Text(AppLocalizations.of(context)!.test_page_exercises_title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),*/

                  const SizedBox(height: 20),

                  // Tests
                  Container(
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
                                Icons.data_array,
                                    () {
                                  Navigator.push(
                                    context,
                                    Essentials().createSlideRoute(
                                        ArrayTestPage()),
                                  );
                                  HapticFeedback.mediumImpact();
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildCardItem(
                                AppLocalizations.of(context)!.stack_button_text,
                                Icons.storage_rounded,
                                    () {
                                  Navigator.push(
                                    context,
                                    Essentials().createSlideRoute(
                                        StackTestPage()),
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
                                Icons.queue,
                                    () {
                                  Navigator.push(
                                    context,
                                    Essentials().createSlideRoute(
                                        QueueTestPage()),
                                  );
                                  HapticFeedback.mediumImpact();
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildCardItem(
                                AppLocalizations.of(context)!.list_button_text,
                                Icons.list_alt,
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
                                Icons.account_tree_outlined,
                                    () {
                                  Navigator.push(
                                    context,
                                    Essentials().createSlideRoute(BstTestPage(
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
                                Icons.table_rows_outlined,
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

                        const SizedBox(height: 20),

                        Text(AppLocalizations.of(context)!
                            .test_page_achievements_title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),

                        Center(
                          child: const RingChartWidget(),
                        ),
                        /*pie.PieChart(
                              dataMap: dataMap,
                              animationDuration: Duration(milliseconds: 800),
                              chartType: pie.ChartType.disc,
                              colorList: colorList,
                              chartRadius: MediaQuery.of(context).size.width / 2.2,
                              chartValuesOptions: pie.ChartValuesOptions(
                                showChartValuesInPercentage: false,
                                showChartValues: false,
                              ),
                              legendOptions: pie.LegendOptions(
                                showLegends: true,
                                legendPosition: pie.LegendPosition.right,
                                legendTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),*/

                      ],
                    ),
                  ),
                  /*Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(12),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),

                            Text(
                              AppLocalizations.of(context)!.test_page_test_text,
                              style: TextStyle(
                                color: Colors.black,
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
                                    Icons.data_array,
                                        () {
                                      Navigator.push(
                                        context,
                                        Essentials().createSlideRoute(ArrayTestPage()),
                                      );
                                      HapticFeedback.mediumImpact();
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _buildCardItem(
                                    AppLocalizations.of(context)!.stack_button_text,
                                    Icons.storage_rounded,
                                        () {
                                      Navigator.push(
                                        context,
                                        Essentials().createSlideRoute(StackTestPage()),
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
                                    Icons.queue,
                                        () {
                                      Navigator.push(
                                        context,
                                        Essentials().createSlideRoute(QueueTestPage()),
                                      );
                                      HapticFeedback.mediumImpact();
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _buildCardItem(
                                    AppLocalizations.of(context)!.list_button_text,
                                    Icons.list_alt,
                                        () {
                                      Navigator.push(
                                        context,
                                        Essentials().createSlideRoute(ListTestPage(toggleTheme: widget.toggleTheme, userId: widget.userId)),
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
                                    Icons.account_tree_outlined,
                                        () {
                                      Navigator.push(
                                        context,
                                        Essentials().createSlideRoute(BstTestPage(toggleTheme: widget.toggleTheme, userId: widget.userId)),
                                      );
                                      HapticFeedback.mediumImpact();
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _buildCardItem(
                                    AppLocalizations.of(context)!.hash_button_text,
                                    Icons.table_rows_outlined,
                                        () {
                                      Navigator.push(
                                        context,
                                        Essentials().createSlideRoute(HashTableTestPage(toggleTheme: widget.toggleTheme, userId: widget.userId)),
                                      );
                                      HapticFeedback.mediumImpact();
                                    },
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            Text(AppLocalizations.of(context)!.test_page_achievements_title,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),

                            Center(
                              child: buildRingChart(),
                            ),
                            /*pie.PieChart(
                              dataMap: dataMap,
                              animationDuration: Duration(milliseconds: 800),
                              chartType: pie.ChartType.disc,
                              colorList: colorList,
                              chartRadius: MediaQuery.of(context).size.width / 2.2,
                              chartValuesOptions: pie.ChartValuesOptions(
                                showChartValuesInPercentage: false,
                                showChartValues: false,
                              ),
                              legendOptions: pie.LegendOptions(
                                showLegends: true,
                                legendPosition: pie.LegendPosition.right,
                                legendTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),*/

                          ],
                        ),
                      ),

                      // What is an array question box
                      Positioned(
                        top: -23,
                        left: 16,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              // Gradient colors
                              colors: [
                                Color(0xFF255f38),
                                Color(0xFF27391c)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 8.0,
                          ),
                          child: Text(AppLocalizations.of(context)!.test_page_test_title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),*/

                  const SizedBox(height: 65),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardItem(String title, IconData icon, VoidCallback onTap) {
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

  Widget _buildCategoryButton(BuildContext context, String title, bool isDarkTheme) {
    final gradient = LinearGradient(
      colors: [Color(0xFFa1f7ff), Color(0xFFDFAEE8)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    // Define a map for title-to-page navigation
    final pageMap = {
      "Code Compiler": () => CodeCompilerPage(),
    };

    return ElevatedButton(
      onPressed: () {
        HapticFeedback.heavyImpact();
        final pageBuilder = pageMap[title];

        if (pageBuilder != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => pageBuilder()),
          );
        } else {
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