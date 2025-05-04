import 'dart:math';
import 'package:flutter/material.dart';

class CreateEmptyChainedHashTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hashTable = List.generate(5, (_) => <int>[]);
    final visibleLengths = List.filled(5, 0);

    return Center(
      child: Container(
        height: 250,
        padding: const EdgeInsets.all(10),
        child: CustomPaint(
          painter: ChainedHashTablePainter(hashTable, visibleLengths),
          child: Container(),
        ),
      ),
    );
  }
}

class ChainedHashTablePainter extends CustomPainter {
  final List<List<int>> table;
  final List<int> visibleLengths;
  final double cellWidth = 60;
  final double cellHeight = 40;

  ChainedHashTablePainter(this.table, this.visibleLengths);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint borderPaint1 = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final Paint fillPaint = Paint()
      ..color = Colors.purple.shade500
      ..style = PaintingStyle.fill;

    final Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4.0);

    final textStyle1 = TextStyle(color: Colors.black, fontSize: 16);
    final textPainter = TextPainter(textAlign: TextAlign.center, textDirection: TextDirection.ltr);

    // Index label
    textPainter.text = TextSpan(text: 'Indexes', style: textStyle1);
    textPainter.layout();
    final labelOffset = Offset(0, -30);
    canvas.drawRect(Rect.fromLTWH(labelOffset.dx, labelOffset.dy, 80, 25), Paint()..color = Colors.transparent);
    textPainter.paint(canvas, labelOffset + Offset(5, 5));

    final textStyle = TextStyle(color: Colors.white, fontSize: 16);

    for (int i = 0; i < table.length; i++) {
      final baseOffset = Offset(0, i * cellHeight);
      final bucketRect = Rect.fromLTWH(baseOffset.dx, baseOffset.dy, cellWidth, cellHeight);

      RRect bucketRRect;

      if (i == 0) {
        bucketRRect = RRect.fromRectAndCorners(
          bucketRect,
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        );
      } else if (i == table.length - 1) {
        bucketRRect = RRect.fromRectAndCorners(
          bucketRect,
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        );
      } else {
        bucketRRect = RRect.fromRectAndRadius(bucketRect, Radius.circular(0));
      }

      // Shadows for the bucket cells
      canvas.drawRRect(
        bucketRRect.shift(Offset(5, 4)),
        shadowPaint, // Draw the shadow
      );

      canvas.drawRRect(bucketRRect, fillPaint);
      canvas.drawRRect(bucketRRect, borderPaint1);

      // Index text
      textPainter.text = TextSpan(text: '${i}', style: textStyle);
      textPainter.layout();
      textPainter.paint(canvas, baseOffset + Offset(5, 10));

      // Index text
      textPainter.text = TextSpan(text: '${i}', style: textStyle);
      textPainter.layout();
      textPainter.paint(canvas, baseOffset + Offset(5, 10));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
