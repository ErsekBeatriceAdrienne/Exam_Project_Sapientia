import 'dart:io';
import 'package:flutter/material.dart';
import 'package:learn_dsa/frontend/strings/firestore/firestore_docs.dart';
import '../../../backend/database/firestore_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RingChartBTExercisesWidget extends StatefulWidget {
  final String? userId;

  const RingChartBTExercisesWidget({Key? key, required this.userId}) : super(key: key);

  @override
  _RingChartBTExercisesWidgetState createState() => _RingChartBTExercisesWidgetState();
}

class _RingChartBTExercisesWidgetState extends State<RingChartBTExercisesWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  List<Map<String, dynamic>> ringData = [];

  Future<void> _loadChartData() async {
    final result_bt = await FirestoreService().getAnsweredAndTotalCount(
      userId: widget.userId!,
      answerCollectionName: FirestoreDocs.user_answers,
      questionCollectionName: FirestoreDocs.bt_exercises_easy_doc,
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
                painter: _RingChartBTExercisesPainter(ringData, _animation.value),
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

class _RingChartBTExercisesPainter extends CustomPainter {
  final List<Map<String, dynamic>> ringData;
  final double progress; // 0.0 - 1.0

  _RingChartBTExercisesPainter(this.ringData, this.progress);

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
  bool shouldRepaint(covariant _RingChartBTExercisesPainter oldDelegate) {
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


// Binary Search Tree

class RingChartBSTExercisesWidget extends StatefulWidget {
  final String? userId;

  const RingChartBSTExercisesWidget({Key? key, required this.userId}) : super(key: key);

  @override
  _RingChartBSTExercisesWidgetState createState() => _RingChartBSTExercisesWidgetState();
}

class _RingChartBSTExercisesWidgetState extends State<RingChartBSTExercisesWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  List<Map<String, dynamic>> ringData = [];

  /// Make the tests
  Future<void> _loadChartData() async {
    final result_bt = await FirestoreService().getAnsweredAndTotalCount(
      userId: widget.userId!,
      answerCollectionName: FirestoreDocs.user_answers,
      questionCollectionName: FirestoreDocs.bt_exercises_easy_doc,
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
        {"label": AppLocalizations.of(context)!.bt_page_title, "color": const Color(0xFFfc8811), "value": value},
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
                painter: _RingChartBSTExercisesPainter(ringData, _animation.value),
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

class _RingChartBSTExercisesPainter extends CustomPainter {
  final List<Map<String, dynamic>> ringData;
  final double progress; // 0.0 - 1.0

  _RingChartBSTExercisesPainter(this.ringData, this.progress);

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
  bool shouldRepaint(covariant _RingChartBSTExercisesPainter oldDelegate) {
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
