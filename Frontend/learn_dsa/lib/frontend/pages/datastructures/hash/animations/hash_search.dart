import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class ChainedHashTableSearchAnimation extends StatefulWidget {
  @override
  _ChainedHashTableSearchAnimationState createState() =>
      _ChainedHashTableSearchAnimationState();
}

class _ChainedHashTableSearchAnimationState extends State<ChainedHashTableSearchAnimation> with TickerProviderStateMixin {
  final List<List<MapEntry<int, int>>> hashTable = List.generate(5, (_) => []);

  final List<MapEntry<int, int>> entriesToInsert = [
    MapEntry(0, 11),
    MapEntry(1, 2),
    MapEntry(4, 4),
    MapEntry(6, 5),
    MapEntry(8, 1),
    MapEntry(11, 22),
    MapEntry(16, 9),
    MapEntry(9, 23),
  ];

  late List<int> visibleLengths;
  int? currentSearchI;
  int? currentSearchJ;
  bool found = false;

  @override
  void initState() {
    super.initState();
    for (var entry in entriesToInsert) {
      final index = entry.key % hashTable.length;
      hashTable[index].add(entry);
    }
    visibleLengths = hashTable.map((e) => e.length).toList();
  }

  Future<void> _startSearchAnimation(int targetKey) async {
    setState(() {
      currentSearchI = null;
      currentSearchJ = null;
      found = false;
    });

    final index = targetKey % hashTable.length;

    for (int j = 0; j < hashTable[index].length; j++) {
      setState(() {
        currentSearchI = index;
        currentSearchJ = j;
      });

      await Future.delayed(Duration(milliseconds: 500));

      if (hashTable[index][j].key == targetKey) {
        setState(() {
          found = true;
        });
        return;
      }
    }

    setState(() {
      currentSearchI = null;
      currentSearchJ = null;
      found = false;
    });
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
              painter: ChainedDynamicHashTablePainter(
                hashTable,
                visibleLengths,
                currentSearchI,
                currentSearchJ,
                found,
              ),
              child: Container(),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => _startSearchAnimation(11),
          child: Text('search(11)'),
        ),
      ],
    );
  }
}

class ChainedDynamicHashTablePainter extends CustomPainter {
  final List<List<MapEntry<int, int>>> table;
  final List<int> visibleLengths;
  final int? currentI;
  final int? currentJ;
  final bool found;

  final double cellWidth = 50;
  final double cellHeight = 40;

  ChainedDynamicHashTablePainter(
      this.table,
      this.visibleLengths,
      this.currentI,
      this.currentJ,
      this.found,
      );

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

    final textStyle = TextStyle(color: Colors.white, fontSize: 16);
    final textStyleBlack = TextStyle(color: Colors.black, fontSize: 16);
    final textPainter = TextPainter(textAlign: TextAlign.center, textDirection: TextDirection.ltr);

    textPainter.text = TextSpan(text: 'Indexes', style: textStyleBlack);
    textPainter.layout();
    canvas.drawRect(Rect.fromLTWH(0, -30, 80, 25), Paint()..color = Colors.transparent);
    textPainter.paint(canvas, Offset(5, -25));

    textPainter.text = TextSpan(text: 'Values', style: textStyleBlack);
    textPainter.layout();
    canvas.drawRect(Rect.fromLTWH(60, -30, 80, 25), Paint()..color = Colors.transparent);
    textPainter.paint(canvas, Offset(65, -25));

    for (int i = 0; i < table.length; i++) {
      final baseOffset = Offset(0, i * cellHeight);
      final bucketRect =
      Rect.fromLTWH(baseOffset.dx, baseOffset.dy, cellWidth, cellHeight);

      final RRect bucketRRect = (i == 0)
          ? RRect.fromRectAndCorners(bucketRect,
          topLeft: Radius.circular(10), topRight: Radius.circular(10))
          : (i == table.length - 1)
          ? RRect.fromRectAndCorners(bucketRect,
          bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
          : RRect.fromRectAndRadius(bucketRect, Radius.circular(0));

      canvas.drawRRect(bucketRRect, Paint()..color = Colors.purple.shade500);
      canvas.drawRRect(bucketRRect, borderPaint1);

      textPainter.text = TextSpan(text: '$i', style: textStyle);
      textPainter.layout();
      textPainter.paint(canvas, baseOffset + Offset(5, 10));

      List<MapEntry<int, int>> chain = table[i];
      int visible = visibleLengths[i];
      double chainStartX = (1) * (cellWidth + 10);

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

        // Key Rect
        final keyRect = RRect.fromRectAndCorners(
          Rect.fromLTWH(chainX, chainY, keyWidth, cellHeight),
          topLeft: isFirst ? Radius.circular(10) : Radius.zero,
          bottomLeft: isFirst ? Radius.circular(10) : Radius.zero,
        );
        canvas.drawRRect(keyRect, Paint()..color = Colors.purple.shade500);
        canvas.drawRRect(keyRect, borderPaint);

        textPainter.text = TextSpan(text: '$key', style: textStyle);
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(
            chainX + (keyWidth - textPainter.width) / 2,
            chainY + (cellHeight - textPainter.height) / 2,
          ),
        );

        Color color = Colors.purple.shade200;
        if (i == currentI && j == currentJ) {
          color = found ? Colors.purpleAccent : Colors.purple.shade900;
        }

        final fillChainPaint = Paint()..color = color;
        // Value
        final valueRect = RRect.fromRectAndCorners(
          Rect.fromLTWH(chainX + keyWidth, chainY, valueWidth, cellHeight),
          topRight: isLast ? Radius.circular(10) : Radius.zero,
          bottomRight: isLast ? Radius.circular(10) : Radius.zero,
        );
        canvas.drawRRect(valueRect, fillChainPaint);
        canvas.drawRRect(valueRect, borderPaint);

        textPainter.text = TextSpan(text: '$value', style: textStyle);
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(
            chainX + keyWidth + (valueWidth - textPainter.width) / 2,
            chainY + (cellHeight - textPainter.height) / 2,
          ),
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
