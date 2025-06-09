import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:learn_dsa/frontend/strings/firestore/firestore_docs.dart';
import '../../../backend/database/firestore_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// EXERCISES

class RingChartExercisesWidget extends StatefulWidget {
  final String? userId;

  const RingChartExercisesWidget({Key? key, required this.userId}) : super(key: key);

  @override
  _RingChartExercisesWidgetState createState() => _RingChartExercisesWidgetState();
}

class _RingChartExercisesWidgetState extends State<RingChartExercisesWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  List<Map<String, dynamic>> ringData = [];

  Future<void> _loadChartData() async {
    final result_bt = await FirestoreService().getAnsweredAndTotalCount(
      userId: widget.userId!,
      answerCollectionName: FirestoreDocs.user_answers,
      questionCollectionName: FirestoreDocs.bt_tests_doc,
    );

    int answered_bt = result_bt[0] ?? 0;
    int total_bt = result_bt[1] ?? 1;

    double bstValue = answered_bt / total_bt;
    double value = 0;

    setState(() {
      ringData = [
        {"label": AppLocalizations.of(context)!.array_page_title, "color": const Color(0xFF2e7d32), "value": value},
        {"label": AppLocalizations.of(context)!.stack_page_title, "color": const Color(0xFF00aead), "value": value},
        {"label": AppLocalizations.of(context)!.queue_page_title, "color": const Color(0xFF81c784), "value": value},
        {"label": AppLocalizations.of(context)!.list_page_title, "color": const Color(0xFFdeb71d), "value": value},
        {"label": AppLocalizations.of(context)!.bt_page_title, "color": const Color(0xFFfc8811), "value": bstValue},
        {"label": AppLocalizations.of(context)!.hash_page_title, "color": const Color(0xFFf03869), "value": value},
      ];
    });

    _controller.forward();
  }

  @override
  void initState() {
    super.initState();
    final duration = Platform.isWindows
        ? const Duration(seconds: 5)
        : const Duration(seconds: 80);

    _controller = AnimationController(vsync: this, duration: duration);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _controller.forward();
    _loadChartData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        return Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Chart
              CustomPaint(
                size: const Size(160, 160),
                painter: _RingChartExercisesPainter(ringData, _animation.value),
              ),
              const SizedBox(width: 32),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: ringData.map((item) {
                  return _LegendItemBTExercises(
                    item["label"] as String,
                    item["color"] as Color,
                    item["value"] as double,
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RingChartExercisesPainter extends CustomPainter {
  final List<Map<String, dynamic>> ringData;
  final double progress; // 0.0 - 1.0

  _RingChartExercisesPainter(this.ringData, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const spacing = 4.0;
    double currentRadius = 0;

    for (final ring in ringData) {
      final thickness = 12.0;
      final value = ring["value"] as double;
      final color = ring["color"] as Color;

      final bgPaint = Paint()
        ..color = Colors.grey.withOpacity(0.1)
        ..style = PaintingStyle.stroke
        ..strokeWidth = thickness;

      final fgPaint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = thickness;

      final radius = currentRadius + thickness / 2;
      final rect = Rect.fromCircle(center: center, radius: radius);

      canvas.drawCircle(center, radius, bgPaint);
      canvas.drawArc(rect, -1.57, 6.28 * (value * progress), false, fgPaint);

      currentRadius += thickness + spacing;
    }
  }

  @override
  bool shouldRepaint(covariant _RingChartExercisesPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _LegendItemBTExercises extends StatelessWidget {
  final String label;
  final Color color;
  final double percent;

  const _LegendItemBTExercises(this.label, this.color, this.percent);

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

/// TEST

class RingChartTestsWidget extends StatefulWidget {
  final String? userId;

  const RingChartTestsWidget({super.key, required this.userId});

  @override
  _RingChartTestsWidgetState createState() => _RingChartTestsWidgetState();
}

class _RingChartTestsWidgetState extends State<RingChartTestsWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  List<Map<String, dynamic>> ringData = [];

  /// Make the tests
  Future<void> _loadChartData() async
  {
    final result_bt = await FirestoreService().getAnsweredAndTotalCount(
      userId: widget.userId!,
      answerCollectionName: FirestoreDocs.user_answers,
      questionCollectionName: FirestoreDocs.bt_tests_doc,
    );

    final result_list = await FirestoreService().getAnsweredAndTotalCount(
      userId: widget.userId!,
      answerCollectionName: FirestoreDocs.user_answers,
      questionCollectionName: FirestoreDocs.list_tests_doc,
    );

    final result_array = await FirestoreService().getAnsweredAndTotalCount(
      userId: widget.userId!,
      answerCollectionName: FirestoreDocs.user_answers,
      questionCollectionName: FirestoreDocs.array_tests_doc,
    );


    int answered_bt = result_bt[0] ?? 0;
    int total_bt = result_bt[1] ?? 1;
    int answered_list = result_list[0] ?? 0;
    int total_list = result_list[1] ?? 1;
    int answered_array = result_array[0] ?? 0;
    int total_array = result_array[1] ?? 1;

    double bstValue = answered_bt / total_bt;
    double listValue = answered_list / total_list;
    double arrayValue = answered_array / total_array;
    double value = 0;

    int index1 = 0, index2 = 1, index3 = 2, index4 = 3, index5 = 4, index6 = 5 ;
    setState(() {
      ringData = [
        {"label": AppLocalizations.of(context)!.array_page_title, "color": Colors.green.shade100, "value": arrayValue},
        {"label": AppLocalizations.of(context)!.stack_page_title, "color": Colors.green.shade200, "value": value},
        {"label": AppLocalizations.of(context)!.queue_page_title, "color": Colors.green.shade400, "value": value},
        {"label": AppLocalizations.of(context)!.list_page_title, "color": Colors.green.shade600, "value": listValue},
        {"label": AppLocalizations.of(context)!.bt_page_title, "color": Colors.green.shade800, "value": bstValue},
        {"label": AppLocalizations.of(context)!.hash_page_title, "color": Colors.green.shade900, "value": value},
      ];
    });

    _controller.forward();
  }

  @override
  void initState() {
    super.initState();
    final duration = Platform.isWindows
        ? const Duration(seconds: 5)
        : const Duration(seconds: 80);

    _controller = AnimationController(vsync: this, duration: duration);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _controller.forward();
    _loadChartData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        return Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Chart
              CustomPaint(
                size: const Size(160, 160),
                painter: _RingChartTestsPainter(ringData, _animation.value),
              ),
              const SizedBox(width: 32),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: ringData.map((item) {
                  return _LegendItemBSTExercises(
                    item["label"] as String,
                    item["color"] as Color,
                    item["value"] as double,
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RingChartTestsPainter extends CustomPainter {
  final List<Map<String, dynamic>> ringData;
  final double progress; // 0.0 - 1.0

  _RingChartTestsPainter(this.ringData, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const spacing = 4.0;
    double currentRadius = 0;

    for (final ring in ringData) {
      final thickness = 12.0;
      final value = ring["value"] as double;
      final color = ring["color"] as Color;

      final bgPaint = Paint()
        ..color = Colors.grey.withOpacity(0.1)
        ..style = PaintingStyle.stroke
        ..strokeWidth = thickness;

      final fgPaint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = thickness;

      final radius = currentRadius + thickness / 2;
      final rect = Rect.fromCircle(center: center, radius: radius);

      canvas.drawCircle(center, radius, bgPaint);
      canvas.drawArc(rect, -1.57, 6.28 * (value * progress), false, fgPaint);

      currentRadius += thickness + spacing;
    }
  }

  @override
  bool shouldRepaint(covariant _RingChartTestsPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _LegendItemBSTExercises extends StatelessWidget {
  final String label;
  final Color color;
  final double percent;

  const _LegendItemBSTExercises(this.label, this.color, this.percent);

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


/// SINGLE DATA STRUCTURE TEST ALL QUESTIONS ANSWERED

class RingChartTestsForSingleDataStructureWidget extends StatefulWidget {
  final String? userId;
  final String firestoreDoc;

  const RingChartTestsForSingleDataStructureWidget({
    Key? key,
    required this.userId,
    required this.firestoreDoc,
  }) : super(key: key);

  @override
  _RingChartTestsForSingleDataStructureWidgetState createState() => _RingChartTestsForSingleDataStructureWidgetState();
}

class _RingChartTestsForSingleDataStructureWidgetState extends State<RingChartTestsForSingleDataStructureWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Map<String, dynamic>? ringItem;

  Future<void> _loadChartData() async {
    final result = await FirestoreService().getAnsweredAndTotalCount(
      userId: widget.userId!,
      answerCollectionName: FirestoreDocs.user_answers,
      questionCollectionName: widget.firestoreDoc,
    );

    int answered = result[0] ?? 0;
    int total = result[1] ?? 1;
    double value = answered / total;

    String label;
    Color color;
    int index1 = 0, index2 = 1, index3 = 2, index4 = 3, index5 = 4, index6 = 5 ;
    switch (widget.firestoreDoc) {
      case FirestoreDocs.array_tests_doc:
        label = AppLocalizations.of(context)!.array_page_title;
        color = Colors.primaries[index1 % Colors.primaries.length];
        break;
      case FirestoreDocs.list_tests_doc:
        label = AppLocalizations.of(context)!.list_page_title;
        color = Colors.primaries[index2 % Colors.primaries.length];
        break;
      case FirestoreDocs.bt_tests_doc:
        label = AppLocalizations.of(context)!.bt_page_title;
        color = Colors.primaries[index3 % Colors.primaries.length];
        break;
      case FirestoreDocs.stack_tests_doc:
        label = AppLocalizations.of(context)!.stack_page_title;
        color = Colors.primaries[index4 % Colors.primaries.length];
        break;
      case FirestoreDocs.queue_tests_doc:
        label = AppLocalizations.of(context)!.queue_page_title;
        color = Colors.primaries[index5 % Colors.primaries.length];
        break;
      case FirestoreDocs.hash_tests_doc:
        label = AppLocalizations.of(context)!.hash_page_title;
        color = Colors.primaries[index6 % Colors.primaries.length];
        break;
      default:
        label = 'Unknown';
        color = Colors.grey;
    }

    setState(() {
      ringItem = {
        "color": color,
        "value": value,
      };
    });

    _controller.forward();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _loadChartData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        if (ringItem == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomPaint(
                size: const Size(160, 160),
                painter: _RingChartSingleDataStructurePainter([ringItem!], _animation.value),
              ),
              const SizedBox(height: 16),
              Center(
                child: _LegendItemForSingleDataStructure(
                  ringItem!["color"],
                  ringItem!["value"],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RingChartSingleDataStructurePainter extends CustomPainter {
  final List<Map<String, dynamic>> ringData;
  final double progress; // 0.0 - 1.0

  _RingChartSingleDataStructurePainter(this.ringData, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    if (ringData.isEmpty) return;

    final center = Offset(size.width / 2, size.height / 2);
    const thickness = 20.0;

    final ring = ringData.first;
    final value = ring["value"] as double;
    final color = ring["color"] as Color;

    final radius = (size.shortestSide - thickness) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final bgPaint = Paint()
      ..color = Colors.grey.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness;

    final fgPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = thickness;

    canvas.drawCircle(center, radius, bgPaint);
    canvas.drawArc(rect, -pi / 2, 2 * pi * value * progress, false, fgPaint);
  }

  @override
  bool shouldRepaint(covariant _RingChartSingleDataStructurePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.ringData != ringData;
  }
}

class _LegendItemForSingleDataStructure extends StatelessWidget {
  final Color color;
  final double percent;

  const _LegendItemForSingleDataStructure(this.color, this.percent);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(width: 12, height: 12, color: color),
          const SizedBox(width: 8),
          Text(
            "${(percent * 100).toStringAsFixed(0)}%",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

/// CORRECT AND WRONG ANSWERS OF USER FOR A DATA STRUCTURE TEST

class RingChartCorrectIncorrectWidget extends StatefulWidget {
  final String userId;
  final String questionCollection;

  const RingChartCorrectIncorrectWidget({
    Key? key,
    required this.userId,
    required this.questionCollection,
  }) : super(key: key);

  @override
  State<RingChartCorrectIncorrectWidget> createState() => _RingChartCorrectIncorrectWidgetState();
}

class _RingChartCorrectIncorrectWidgetState extends State<RingChartCorrectIncorrectWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  double correctPercent = 0;
  double incorrectPercent = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _loadData();
  }

  Future<void> _loadData() async {
    final result = await FirestoreService().getCorrectAndIncorrectAnswerCount(
      userId: widget.userId,
      questionCollection: widget.questionCollection,
    );

    int correct = result['correct']!;
    int incorrect = result['incorrect']!;
    int total = correct + incorrect;

    setState(() {
      correctPercent = total > 0 ? correct / total : 0;
      incorrectPercent = total > 0 ? incorrect / total : 0;
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _RingChartItem(
              color: Colors.green,
              percent: correctPercent,
              label: AppLocalizations.of(context)!.correct_answer_test_exercises_text,
              progress: _animation.value,
            ),
            const SizedBox(width: 32),
            _RingChartItem(
              color: Colors.red,
              percent: incorrectPercent,
              label: AppLocalizations.of(context)!.incorrect_answer_test_text,
              progress: _animation.value,
            ),
          ],
        );
      },
    );
  }
}

class _RingChartItem extends StatelessWidget {
  final Color color;
  final double percent;
  final String label;
  final double progress;

  const _RingChartItem({
    required this.color,
    required this.percent,
    required this.label,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomPaint(
          size: const Size(120, 120),
          painter: _RingPainter(
            color: color,
            percent: percent,
            progress: progress,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '$label ${(percent * 100).toStringAsFixed(0)}%',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _RingPainter extends CustomPainter {
  final Color color;
  final double percent;
  final double progress;

  _RingPainter({
    required this.color,
    required this.percent,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const thickness = 14.0;
    final radius = (size.shortestSide - thickness) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final bgPaint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness;

    final fgPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = thickness;

    canvas.drawCircle(center, radius, bgPaint);
    canvas.drawArc(rect, -pi / 2, 2 * pi * percent * progress, false, fgPaint);
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.percent != percent || oldDelegate.progress != progress;
  }
}