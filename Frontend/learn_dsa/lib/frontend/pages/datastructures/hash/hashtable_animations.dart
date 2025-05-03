import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class ChainedHashTableAnimation extends StatefulWidget {
  @override
  _ChainedHashTableAnimationState createState() => _ChainedHashTableAnimationState();
}

class _ChainedHashTableAnimationState extends State<ChainedHashTableAnimation> with TickerProviderStateMixin {
  final List<List<int>> hashTable = [
    [11],
    [2, 5, 22,9],
    [],
    [1],
    [4, 23],
  ];

  late List<int> visibleLengths;

  @override
  void initState() {
    super.initState();
    visibleLengths = List.filled(hashTable.length, 0);
    _startAnimation();
  }

  Future<void> _startAnimation() async {
    for (int i = 0; i < hashTable.length; i++) {
      for (int j = 0; j < hashTable[i].length; j++) {
        await Future.delayed(Duration(milliseconds: 600));
        setState(() {
          visibleLengths[i]++;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            height: 250,
            padding: const EdgeInsets.all(10),
            child: CustomPaint(
              painter: ChainedHashTablePainter(hashTable, visibleLengths),
              child: Container(),
            ),
          ),
        ),
      ],
    );
  }
}

class ChainedHashTablePainter extends CustomPainter {
  final List<List<int>> table;
  final List<int> visibleLengths;
  final double cellWidth = 50;
  final double cellHeight = 40;

  ChainedHashTablePainter(this.table, this.visibleLengths);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint borderPaint = Paint()
      ..color = Colors.grey.shade500
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final Paint borderPaint1 = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final Paint fillPaint = Paint()
      ..color = Colors.purple.shade500
      ..style = PaintingStyle.fill;

    final textStyle1 = TextStyle(color: Colors.black, fontSize: 16);
    final textPainter = TextPainter(textAlign: TextAlign.center, textDirection: TextDirection.ltr);

    // Index label
    textPainter.text = TextSpan(text: 'Indexes', style: textStyle1);
    textPainter.layout();
    final labelOffset = Offset(0, -30);
    canvas.drawRect(Rect.fromLTWH(labelOffset.dx, labelOffset.dy, 80, 25), Paint()..color = Colors.transparent);
    textPainter.paint(canvas, labelOffset + Offset(5, 5));

    // Values label
    textPainter.text = TextSpan(text: 'Values', style: textStyle1);
    textPainter.layout();
    final valuesX = (1) * (cellWidth + 10);
    canvas.drawRect(Rect.fromLTWH(valuesX, -30, 80, 25), Paint()..color = Colors.transparent);
    textPainter.paint(canvas, Offset(valuesX + 5, -25));

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

      List<int> chain = table[i];
      int visible = visibleLengths[i];
      double chainStartX = (1) * (cellWidth + 10);

      for (int j = 0; j < visible && j < chain.length; j++) {
        final chainY = baseOffset.dy;
        final chainX = (j == 0) ? chainStartX : chainStartX + j * cellWidth;

        final isFirst = j == 0;
        final isLast = j == visible - 1 || j == chain.length - 1;

        RRect chainRect;

        if (isFirst && isLast) {
          chainRect = RRect.fromRectAndCorners(
            Rect.fromLTWH(chainX, chainY, cellWidth, cellHeight),
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          );
        } else if (isFirst) {
          chainRect = RRect.fromRectAndCorners(
            Rect.fromLTWH(chainX, chainY, cellWidth, cellHeight),
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          );
        } else if (isLast) {
          chainRect = RRect.fromRectAndCorners(
            Rect.fromLTWH(chainX, chainY, cellWidth, cellHeight),
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          );
        } else {
          chainRect = RRect.fromRectAndRadius(
            Rect.fromLTWH(chainX, chainY, cellWidth, cellHeight),
            Radius.circular(0),
          );
        }


        final fillChainPaint = Paint()
          ..color = Colors.purple.shade200
          ..style = PaintingStyle.fill;

        canvas.drawRRect(chainRect, fillChainPaint);
        canvas.drawRRect(chainRect, borderPaint);

        textPainter.text = TextSpan(text: '${chain[j]}', style: textStyle);
        textPainter.layout();
        final textOffset = Offset(
          chainX + (cellWidth - textPainter.width) / 2,
          chainY + (cellHeight - textPainter.height) / 2,
        );
        textPainter.paint(canvas, textOffset);

        if (j == 0) {
          final arrowStart = Offset(baseOffset.dx + cellWidth, baseOffset.dy + cellHeight / 2);
          final arrowEnd = Offset(chainX, chainY + cellHeight / 2);
          _drawArrow(canvas, arrowStart, arrowEnd);
        }
      }
    }
  }

  void _drawArrow(Canvas canvas, Offset start, Offset end) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.5;

    canvas.drawLine(start, end, paint);

    const size = 6.0;
    final angle = pi / 6;
    final dx = start.dx - end.dx;
    final dy = start.dy - end.dy;
    final theta = atan2(dy, dx);
    final arrowX1 = end.dx + size * cos(theta + angle);
    final arrowY1 = end.dy + size * sin(theta + angle);
    final arrowX2 = end.dx + size * cos(theta - angle);
    final arrowY2 = end.dy + size * sin(theta - angle);

    canvas.drawLine(end, Offset(arrowX1, arrowY1), paint);
    canvas.drawLine(end, Offset(arrowX2, arrowY2), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ----------------------------------------------------------------------------------------------------------------------------------------------------------------------


class ChainedDynamicHashTableAnimation extends StatefulWidget {
  @override
  _ChainedDynamicHashTableAnimationState createState() => _ChainedDynamicHashTableAnimationState();
}

class _ChainedDynamicHashTableAnimationState extends State<ChainedDynamicHashTableAnimation> with TickerProviderStateMixin {
  final List<List<int>> hashTable = [
    [11],
    [2, 5, 22,9],
    [],
    [1],
    [4, 23],
  ];

  late List<int> visibleLengths;

  @override
  void initState() {
    super.initState();
    visibleLengths = List.filled(hashTable.length, 0);
    _startAnimation();
  }

  Future<void> _startAnimation() async {
    for (int i = 0; i < hashTable.length; i++) {
      for (int j = 0; j < hashTable[i].length; j++) {
        await Future.delayed(Duration(milliseconds: 600));
        setState(() {
          visibleLengths[i]++;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            height: 250,
            padding: const EdgeInsets.all(10),
            child: CustomPaint(
              painter: ChainedDynamicHashTablePainter(hashTable, visibleLengths),
              child: Container(),
            ),
          ),
        ),
      ],
    );
  }
}

class ChainedDynamicHashTablePainter extends CustomPainter {
  final List<List<int>> table;
  final List<int> visibleLengths;
  final double cellWidth = 50;
  final double cellHeight = 40;

  ChainedDynamicHashTablePainter(this.table, this.visibleLengths);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint borderPaint = Paint()
      ..color = Colors.grey.shade500
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final Paint borderPaint1 = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final Paint fillPaint = Paint()
      ..color = Colors.purple.shade500
      ..style = PaintingStyle.fill;

    final textStyle1 = TextStyle(color: Colors.black, fontSize: 16);
    final textPainter = TextPainter(textAlign: TextAlign.center, textDirection: TextDirection.ltr);

    // Index label
    textPainter.text = TextSpan(text: 'Indexes', style: textStyle1);
    textPainter.layout();
    final labelOffset = Offset(0, -30);
    canvas.drawRect(Rect.fromLTWH(labelOffset.dx, labelOffset.dy, 80, 25), Paint()..color = Colors.transparent);
    textPainter.paint(canvas, labelOffset + Offset(5, 5));

    // Values label
    textPainter.text = TextSpan(text: 'Values', style: textStyle1);
    textPainter.layout();
    final valuesX = (1) * (cellWidth + 10);
    canvas.drawRect(Rect.fromLTWH(valuesX, -30, 80, 25), Paint()..color = Colors.transparent);
    textPainter.paint(canvas, Offset(valuesX + 5, -25));

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

      canvas.drawRRect(bucketRRect, fillPaint);
      canvas.drawRRect(bucketRRect, borderPaint1);

      // Index text
      textPainter.text = TextSpan(text: '${i}', style: textStyle);
      textPainter.layout();
      textPainter.paint(canvas, baseOffset + Offset(5, 10));

      List<int> chain = table[i];
      int visible = visibleLengths[i];

      for (int j = 0; j < visible && j < chain.length; j++) {
        final chainX = (j + 1) * (cellWidth + 10);
        final chainY = baseOffset.dy;

        final chainRect = RRect.fromRectAndRadius(
          Rect.fromLTWH(chainX, chainY, cellWidth, cellHeight),
          Radius.circular(10),
        );

        final fillChainPaint = Paint()
          ..color = Colors.purple.shade200
          ..style = PaintingStyle.fill;

        canvas.drawRRect(chainRect, fillChainPaint);
        canvas.drawRRect(chainRect, borderPaint);

        textPainter.text = TextSpan(text: '${chain[j]}', style: textStyle);
        textPainter.layout();
        textPainter.paint(canvas, Offset(chainX + 20, chainY + 10));

        // Draw arrows
        Offset arrowStart, arrowEnd;
        if (j == 0) {
          arrowStart = Offset(baseOffset.dx + cellWidth, baseOffset.dy + cellHeight / 2);
        } else {
          final prevX = j * (cellWidth + 10);
          arrowStart = Offset(prevX + cellWidth, chainY + cellHeight / 2);
        }
        arrowEnd = Offset(chainX, chainY + cellHeight / 2);
        _drawArrow(canvas, arrowStart, arrowEnd);
      }
    }
  }

  void _drawArrow(Canvas canvas, Offset start, Offset end) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.5;

    canvas.drawLine(start, end, paint);

    const size = 6.0;
    final angle = pi / 6;
    final dx = start.dx - end.dx;
    final dy = start.dy - end.dy;
    final theta = atan2(dy, dx);
    final arrowX1 = end.dx + size * cos(theta + angle);
    final arrowY1 = end.dy + size * sin(theta + angle);
    final arrowX2 = end.dx + size * cos(theta - angle);
    final arrowY2 = end.dy + size * sin(theta - angle);

    canvas.drawLine(end, Offset(arrowX1, arrowY1), paint);
    canvas.drawLine(end, Offset(arrowX2, arrowY2), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
