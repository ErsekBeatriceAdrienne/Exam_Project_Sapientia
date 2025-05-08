
import 'dart:io';
import 'package:flutter/material.dart';

class RingChartWidget extends StatefulWidget {
  const RingChartWidget({Key? key}) : super(key: key);

  @override
  _RingChartWidgetState createState() => _RingChartWidgetState();
}

class _RingChartWidgetState extends State<RingChartWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final ringData = [
    {"label": "Array", "color": Color(0xFF2e7d32), "value": 0.6},
    {"label": "Stack", "color": Color(0xFF00aead), "value": 0.75},
    {"label": "Queue", "color": Color(0xFF81c784), "value": 0.9},
    {"label": "List", "color": Color(0xFFdeb71d), "value": 0.95},
    {"label": "BST", "color": Color(0xFFfc8811), "value": 0.80},
    {"label": "Hash", "color": Color(0xFFf03869), "value": 0.70},
  ];

  @override
  void initState() {
    super.initState();
    final duration = Platform.isWindows
        ? const Duration(seconds: 5)
        : const Duration(seconds: 80);

    _controller = AnimationController(vsync: this, duration: duration);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
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
        return Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Chart
              CustomPaint(
                size: const Size(160, 160),
                painter: _RingChartPainter(ringData, _animation.value),
              ),
              const SizedBox(width: 32),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: ringData.map((item) {
                  return _LegendItem(
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

class _RingChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> ringData;
  final double progress; // 0.0 - 1.0

  _RingChartPainter(this.ringData, this.progress);

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
  bool shouldRepaint(covariant _RingChartPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
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