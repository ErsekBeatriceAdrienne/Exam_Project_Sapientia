import 'package:flutter/material.dart';
import 'dart:math';

class ChainedHashTableAnimation extends StatefulWidget {
  @override
  _ChainedHashTableAnimationState createState() => _ChainedHashTableAnimationState();
}

class _ChainedHashTableAnimationState extends State<ChainedHashTableAnimation> {
  List<List<int>> hashTable = List.generate(5, (_) => []);
  int insertCount = 0;
  final int maxValues = 10;
  final int tableSize = 5;

  @override
  void initState() {
    super.initState();
    _startAutoInsertion();
  }

  void _startAutoInsertion() async {
    while (insertCount < maxValues) {
      await Future.delayed(const Duration(seconds: 1));
      int newValue = Random().nextInt(100);
      setState(() {
        _insertValue(newValue);
        insertCount++;
      });
    }
  }

  void _insertValue(int value) {
    int index = value % tableSize;
    hashTable[index].add(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomPaint(
            painter: ChainedHashTablePainter(hashTable),
            child: Container(),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class ChainedHashTablePainter extends CustomPainter {
  final List<List<int>> hashTable;

  ChainedHashTablePainter(this.hashTable);

  @override
  void paint(Canvas canvas, Size size) {
    double cellHeight = size.height / hashTable.length;
    double cellWidth = 60;
    double borderRadius = 10;

    Paint cellPaint = Paint()
      ..color = Colors.purple
      ..style = PaintingStyle.fill;

    Paint borderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke;

    Paint linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    for (int i = 0; i < hashTable.length; i++) {
      double y = i * cellHeight;
      RRect cellRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(10, y, cellWidth, cellHeight - 5),
        Radius.circular(borderRadius),
      );
      canvas.drawRRect(cellRect, cellPaint);
      canvas.drawRRect(cellRect, borderPaint);

      TextPainter indexText = TextPainter(
        text: TextSpan(
          text: '$i',
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        textDirection: TextDirection.ltr,
      );
      indexText.layout();
      indexText.paint(canvas, Offset(25, y + (cellHeight - indexText.height) / 2));

      double xOffset = 80;
      for (int value in hashTable[i]) {
        RRect valueRect = RRect.fromRectAndRadius(
          Rect.fromLTWH(xOffset, y, cellWidth, cellHeight - 5),
          Radius.circular(borderRadius),
        );
        canvas.drawRRect(valueRect, cellPaint);
        canvas.drawRRect(valueRect, borderPaint);

        TextPainter valueText = TextPainter(
          text: TextSpan(
            text: '$value',
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          textDirection: TextDirection.ltr,
        );
        valueText.layout();
        valueText.paint(canvas, Offset(xOffset + 10, y + (cellHeight - valueText.height) / 2));

        if (xOffset > 80) {
          canvas.drawLine(Offset(xOffset - 10, y + cellHeight / 2), Offset(xOffset, y + cellHeight / 2), linePaint);
        }

        xOffset += 70;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}