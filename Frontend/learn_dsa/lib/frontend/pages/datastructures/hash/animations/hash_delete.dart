import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      ..color = Colors.transparent //Colors.grey.shade500
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final blackBorder = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = Colors.purple.shade500
      ..style = PaintingStyle.fill;

    final Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4.0);

    final textStyleCell = TextStyle(color: Colors.white, fontSize: 16);
    final textPainter = TextPainter(textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    final textStyle = TextStyle(color: Colors.white, fontSize: 14);

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

      // Shadows for the bucket cells
      canvas.drawRRect(
        bucketRRect.shift(Offset(5, 4)),
        shadowPaint, // Draw the shadow
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
        final entry = chain[j];
        final key = entry.key;
        final value = entry.value;

        final chainY = baseOffset.dy;
        final chainX = chainStartX + j * (cellWidth);

        final keyWidth = cellWidth * 0.4;
        final valueWidth = cellWidth * 0.6;

        final isFirst = j == 0;
        final isLast = j == visible - 1 || j == chain.length - 1;

        final totalRect = RRect.fromRectAndCorners(
          Rect.fromLTWH(chainX, chainY, keyWidth + valueWidth, cellHeight),
          topLeft: isFirst ? Radius.circular(10) : Radius.zero,
          bottomLeft: isFirst ? Radius.circular(10) : Radius.zero,
          topRight: isLast ? Radius.circular(10) : Radius.zero,
          bottomRight: isLast ? Radius.circular(10) : Radius.zero,
        );
        // Shadow
        canvas.drawRRect(
          totalRect.shift(Offset(4, 4)),
          shadowPaint,
        );

        // Drawing the key-value cells with the rounded corners
        if (isFirst && isLast) {
          // Apply rounded corners for both the first and last cell
          canvas.drawRRect(
            RRect.fromRectAndCorners(
              Rect.fromLTWH(chainX, chainY, keyWidth, cellHeight),
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            Paint()..color = Colors.purple.shade200,
          );
          canvas.drawRRect(
            RRect.fromRectAndCorners(
              Rect.fromLTWH(chainX + keyWidth, chainY, valueWidth, cellHeight),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            Paint()..color = Colors.purple.shade200,
          );
        }

        // Small white line
        canvas.drawLine(
          Offset(chainX + keyWidth, chainY + 5),
          Offset(chainX + keyWidth, chainY + cellHeight - 5),
          Paint()
            ..color = Colors.white
            ..strokeWidth = 1.5,
        );

        // Texts
        textPainter.text = TextSpan(text: '$key', style: textStyle);
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(
            chainX + (keyWidth - textPainter.width) / 2,
            chainY + (cellHeight - textPainter.height) / 2,
          ),
        );

        textPainter.text = TextSpan(text: '$value', style: textStyle);
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(
            chainX + keyWidth + (valueWidth - textPainter.width) / 2,
            chainY + (cellHeight - textPainter.height) / 2,
          ),
        );

        canvas.drawRRect(
          totalRect,
          Paint()
            ..color = Colors.transparent
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5
            ..color = Colors.white,
        );

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

// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------

class ChainedDynamicHashTableDeleteAnimation extends StatefulWidget {
  @override
  _ChainedDynamicHashTableDeleteAnimationState createState() =>
      _ChainedDynamicHashTableDeleteAnimationState();
}

class _ChainedDynamicHashTableDeleteAnimationState extends State<ChainedDynamicHashTableDeleteAnimation> with TickerProviderStateMixin {
  final List<List<MapEntry<int, int>>> hashTable = [
    [MapEntry(0, 11)],
    [MapEntry(1, 2), MapEntry(6, 5), MapEntry(11, 22)],
    [],
    [MapEntry(8, 1)],
    [MapEntry(4, 4), MapEntry(9, 23)],
  ];

  late List<int> visibleLengths;
  int? highlightedIndexI;
  int? highlightedIndexJ;

  @override
  void initState() {
    super.initState();
    visibleLengths = List.generate(hashTable.length, (i) => hashTable[i].length);
  }

  Future<void> _deleteKey(int key) async {
    setState(() {
      highlightedIndexI = null;
      highlightedIndexJ = null;
    });

    int bucket = key % hashTable.length;
    for (int j = 0; j < hashTable[bucket].length; j++) {
      await Future.delayed(Duration(milliseconds: 600));
      HapticFeedback.heavyImpact();
      setState(() {
        highlightedIndexI = bucket;
        highlightedIndexJ = j;
      });

      if (hashTable[bucket][j].key == key) {
        await Future.delayed(Duration(milliseconds: 500));
        HapticFeedback.heavyImpact();

        setState(() {
          hashTable[bucket].removeAt(j);
          visibleLengths[bucket] = hashTable[bucket].length;
          highlightedIndexI = null;
          highlightedIndexJ = null;
        });
        break;
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
              painter: ChainedDynamicHashTableDeletePainter(
                hashTable,
                visibleLengths,
                highlightedIndexI,
                highlightedIndexJ,
              ),
              child: Container(),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => _deleteKey(6),
          child: Text("deleteNode(head, 6)"),
        ),
      ],
    );
  }
}

class ChainedDynamicHashTableDeletePainter extends CustomPainter {
  final List<List<MapEntry<int, int>>> table;
  final List<int> visibleLengths;
  final int? highlightedI;
  final int? highlightedJ;
  final double cellWidth = 60;
  final double cellHeight = 40;

  ChainedDynamicHashTableDeletePainter(this.table, this.visibleLengths, this.highlightedI, this.highlightedJ);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

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

    final textPainter = TextPainter(textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    final textStyle = TextStyle(color: Colors.white, fontSize: 16);

    for (int i = 0; i < table.length; i++) {
      final baseOffset = Offset(0, i * cellHeight);
      final bucketRect = Rect.fromLTWH(baseOffset.dx, baseOffset.dy, cellWidth, cellHeight);

      RRect bucketRRect = RRect.fromRectAndCorners(bucketRect,
        topLeft: i == 0 ? Radius.circular(10) : Radius.zero,
        bottomLeft: i == table.length - 1 ? Radius.circular(10) : Radius.zero,
        topRight: i == 0 ? Radius.circular(10) : Radius.zero,
        bottomRight: i == table.length - 1 ? Radius.circular(10) : Radius.zero,
      );

      canvas.drawRRect(bucketRRect.shift(Offset(5, 4)), shadowPaint);
      canvas.drawRRect(bucketRRect, fillPaint);
      canvas.drawRRect(bucketRRect, borderPaint1);

      textPainter.text = TextSpan(text: '$i', style: textStyle);
      textPainter.layout();
      textPainter.paint(canvas, baseOffset + Offset(5, 10));

      List<MapEntry<int, int>> chain = table[i];
      int visible = visibleLengths[i];

      for (int j = 0; j < visible && j < chain.length; j++) {
        final chainX = (j + 1) * (cellWidth + 10);
        final chainY = baseOffset.dy;
        final chainRect = Rect.fromLTWH(chainX, chainY, cellWidth, cellHeight);
        final chainRRect = RRect.fromRectAndRadius(chainRect, Radius.circular(8));

        canvas.drawRRect(chainRRect.shift(Offset(4, 4)), shadowPaint);

        final isHighlighted = (highlightedI == i && highlightedJ == j);
        final fillChainPaint = Paint()
          ..color = isHighlighted ? Colors.purple.shade600 : Colors.purple.shade200
          ..style = PaintingStyle.fill;

        canvas.drawRRect(chainRRect, fillChainPaint);
        canvas.drawRRect(chainRRect, borderPaint);

        final pair = chain[j];
        final separatorX = chainX + cellWidth * 0.4;

        canvas.drawLine(
          Offset(separatorX, chainY + 5),
          Offset(separatorX, chainY + cellHeight - 5),
          Paint()
            ..color = Colors.white
            ..strokeWidth = 1.5,
        );

        final TextStyle keyStyle = textStyle.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        );
        final TextStyle valueStyle = keyStyle;

        textPainter.text = TextSpan(text: '${pair.key}', style: keyStyle);
        textPainter.layout(minWidth: 0, maxWidth: cellWidth * 0.4 - 10);
        textPainter.paint(canvas, Offset(chainX + 8, chainY + (cellHeight - textPainter.height) / 2));

        textPainter.text = TextSpan(text: '${pair.value}', style: valueStyle);
        textPainter.layout(minWidth: 0, maxWidth: cellWidth * 0.6 - 10);
        textPainter.paint(canvas, Offset(separatorX + 8, chainY + (cellHeight - textPainter.height) / 2));

        Offset arrowStart = j == 0
            ? Offset(baseOffset.dx + cellWidth, baseOffset.dy + cellHeight / 2)
            : Offset((j) * (cellWidth + 10) + cellWidth,
            chainY + cellHeight / 2);
        Offset arrowEnd = Offset(chainX, chainY + cellHeight / 2);
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