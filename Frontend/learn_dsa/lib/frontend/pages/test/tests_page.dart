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
import 'package:pie_chart/pie_chart.dart' as pie;
import '../../../backend/compiler/c_compiler.dart';
import '../../pages/exercises/array_exercises.dart';
import '../../pages/exercises/binarytree_exercises.dart';
import '../../pages/exercises/hashtable_exercises.dart';
import '../../pages/exercises/list_exercises.dart';
import '../../pages/exercises/queue_exercises.dart';
import '../../pages/exercises/stack_exercises.dart';
import '../../strings/test/test_strings.dart';
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
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

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
                    title: Text(
                      TestStrings.title,
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
                  const SizedBox(height: 20),

                  // Exercises
                  Stack(
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
                              TestStrings.exercises_description,
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
                                    "Array",
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
                                    "Stack",
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
                                    "Queue",
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
                                    "List",
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
                                    "Tree",
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
                                    "Table",
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

                            Text(
                              TestStrings.chart_exercises_title,
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
                          child: Text(
                            TestStrings.exercise_title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Tests
                  Stack(
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
                              TestStrings.test_description,
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
                                    "Array",
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
                                    "Stack",
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
                                    "Queue",
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
                                    "List",
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
                                    "Tree",
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
                                    "Table",
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

                            Text(
                              TestStrings.chart_test_title,
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
                          child: Text(
                            TestStrings.test_title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
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

 /*// Version 1
 Widget _buildCardItem(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 4,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Color(0xFF27391c)),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF27391c)),
            ),
            Spacer(),
            Icon(Icons.chevron_right, color: Color(0xFF27391c)),
          ],
        ),
      ),
    );
  }*/

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
            Icon(icon, color: Theme.of(context).scaffoldBackgroundColor),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            const Spacer(),
            Icon(Icons.chevron_right, color: Theme.of(context).scaffoldBackgroundColor),
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

  Widget buildRingChart() {
    final legendData = [
      {"label": "Array", "color": Color(0xFF2e7d32), "percent": 0.6},
      {"label": "Stack", "color": Color(0xFF00aead), "percent": 0.75},
      {"label": "Queue", "color": Color(0xFF81c784), "percent": 0.9},
      {"label": "List", "color": Color(0xFFdeb71d), "percent": 0.95},
      {"label": "Tree", "color": Color(0xFFfc8811), "percent": 0.80},
      {"label": "Table", "color": Color(0xFFf03869), "percent": 0.70},
    ];

    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chart
          CustomPaint(
            size: const Size(160, 160),
            painter: _RingChartPainter(),
          ),

          const SizedBox(width: 32),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: legendData.map((item) {
              return _LegendItem(
                item["label"] as String,
                item["color"] as Color,
                (item["percent"] as double),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _RingChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const spacing = 4.0;

    final ringData = [
      {"value": 0.6, "color": Color(0xFF2e7d32), "thickness": 12.0},
      {"value": 0.75, "color": Color(0xFF00aead), "thickness": 12.0},
      {"value": 0.9, "color": Color(0xFF81c784), "thickness": 12.0},
      {"value": 0.95, "color": Color(0xFFdeb71d), "thickness": 12.0},
      {"value": 0.80, "color": Color(0xFFfc8811), "thickness": 12.0},
      {"value": 0.70, "color": Color(0xFFf03869), "thickness": 12.0},
    ];

    double currentRadius = 0;

    for (final ring in ringData) {
      final thickness = ring["thickness"] as double;

      final bgPaint = Paint()
        ..color = Colors.grey.withOpacity(0.1)
        ..style = PaintingStyle.stroke
        ..strokeWidth = thickness;

      final fgPaint = Paint()
        ..color = ring["color"] as Color
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = thickness;

      final radius = currentRadius + thickness / 2;
      final rect = Rect.fromCircle(center: center, radius: radius);

      canvas.drawCircle(center, radius, bgPaint);
      canvas.drawArc(rect, -1.57, 6.28 * (ring["value"] as double), false, fgPaint);

      currentRadius += thickness + spacing;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _LegendItem extends StatelessWidget {
  final String label;
  final Color color;
  final double percent;

  const _LegendItem(this.label, this.color, this.percent);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(width: 12, height: 12, color: color),
          const SizedBox(width: 8),
          Text(
            "$label ${(percent * 100).toStringAsFixed(0)}%",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
