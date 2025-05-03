import 'dart:math';

import 'package:flutter/material.dart';

class HashTableDeleteAnimation extends StatefulWidget {
  @override
  _HashTableDeleteAnimationState createState() => _HashTableDeleteAnimationState();
}

class _HashTableDeleteAnimationState extends State<HashTableDeleteAnimation> {
  final List<List<MapEntry<int, int>>> hashTable = [[], [], [], [], []];
  late List<int> visibleLengths;
  bool hasInserted = false;

  @override
  void initState() {
    super.initState();
    visibleLengths = List.filled(hashTable.length, 0);

    hashTable[0].add(MapEntry(0, 23));
    visibleLengths[0] = 1;
    hasInserted = true;
  }

  void _removeValue() {
    setState(() {
      if (hashTable[0].isNotEmpty && visibleLengths[0] > 0) {
        hashTable[0].removeLast();
        visibleLengths[0]--;
        hasInserted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 250,
          padding: const EdgeInsets.all(10),
          child: CustomPaint(
            painter: ChainedHashTablePainter(hashTable, visibleLengths),
            child: Container(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: hasInserted ? _removeValue : null,
              child: Text("delete(table, 0)"),
            ),
          ],
        ),
      ],
    );
  }
}

class ChainedHashTablePainter extends CustomPainter {
  final List<List<MapEntry<int, int>>> table;
  final List<int> visibleLengths;
  final double cellWidth = 60;
  final double cellHeight = 40;

  ChainedHashTablePainter(this.table, this.visibleLengths);

  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..color = Colors.grey.shade500
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final blackBorder = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = Colors.purple.shade500
      ..style = PaintingStyle.fill;

    final textStyleHeader = TextStyle(color: Colors.black, fontSize: 16);
    final textStyleCell = TextStyle(color: Colors.white, fontSize: 16);

    final textPainter =
    TextPainter(textAlign: TextAlign.center, textDirection: TextDirection.ltr);

    // Headers
    textPainter.text = TextSpan(text: 'Indexes', style: textStyleHeader);
    textPainter.layout();
    canvas.drawRect(Rect.fromLTWH(0, -30, 80, 25), Paint()..color = Colors.transparent);
    textPainter.paint(canvas, Offset(5, -25));

    textPainter.text = TextSpan(text: 'Values', style: textStyleHeader);
    textPainter.layout();
    final valuesX = cellWidth + 10;
    canvas.drawRect(Rect.fromLTWH(valuesX, -30, 80, 25), Paint()..color = Colors.transparent);
    textPainter.paint(canvas, Offset(valuesX + 5, -25));

    for (int i = 0; i < table.length; i++) {
      final baseOffset = Offset(0, i * cellHeight);
      final bucketRect = Rect.fromLTWH(baseOffset.dx, baseOffset.dy, cellWidth, cellHeight);

      final bucketRRect = RRect.fromRectAndCorners(
        bucketRect,
        topLeft: i == 0 ? Radius.circular(10) : Radius.zero,
        topRight: i == 0 ? Radius.circular(10) : Radius.zero,
        bottomLeft: i == table.length - 1 ? Radius.circular(10) : Radius.zero,
        bottomRight: i == table.length - 1 ? Radius.circular(10) : Radius.zero,
      );

      canvas.drawRRect(bucketRRect, fillPaint);
      canvas.drawRRect(bucketRRect, blackBorder);

      textPainter.text = TextSpan(text: '$i', style: textStyleCell);
      textPainter.layout();
      textPainter.paint(canvas, baseOffset + Offset(5, 10));

      List<MapEntry<int, int>> chain = table[i];
      int visible = visibleLengths[i];
      double chainStartX = cellWidth + 10;

      for (int j = 0; j < visible && j < chain.length; j++) {
        final chainY = baseOffset.dy;
        final chainX = chainStartX + j * cellWidth;

        final key = chain[j].key;
        final value = chain[j].value;

        final keyWidth = cellWidth * 0.4;
        final valueWidth = cellWidth * 0.6;

        final keyRect = RRect.fromRectAndCorners(
          Rect.fromLTWH(chainX, chainY, keyWidth, cellHeight),
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        );
        canvas.drawRRect(keyRect, Paint()..color = Colors.purple.shade500);
        canvas.drawRRect(keyRect, borderPaint);

        textPainter.text = TextSpan(text: '$key', style: textStyleCell);
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(
            chainX + (keyWidth - textPainter.width) / 2,
            chainY + (cellHeight - textPainter.height) / 2,
          ),
        );

        final valueRect = RRect.fromRectAndCorners(
          Rect.fromLTWH(chainX + keyWidth, chainY, valueWidth, cellHeight),
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        );
        canvas.drawRRect(valueRect, Paint()..color = Colors.purple.shade200);
        canvas.drawRRect(valueRect, borderPaint);

        textPainter.text = TextSpan(text: '$value', style: textStyleCell);
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(
            chainX + keyWidth + (valueWidth - textPainter.width) / 2,
            chainY + (cellHeight - textPainter.height) / 2,
          ),
        );

        if (j == 0) {
          _drawArrow(canvas,
              Offset(cellWidth, baseOffset.dy + cellHeight / 2),
              Offset(chainX, chainY + cellHeight / 2));
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