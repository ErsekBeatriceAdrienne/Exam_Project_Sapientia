import 'package:flutter/material.dart';
import 'dart:math';

/// 1. Animation
/*
class ChainedHashTableAnimation extends StatefulWidget {
  @override
  _ChainedHashTableAnimationState createState() => _ChainedHashTableAnimationState();
}

class _ChainedHashTableAnimationState extends State<ChainedHashTableAnimation> {
  List<List<int>> hashTable = List.generate(6, (_) => []);
  int insertCount = 0;
  final int maxValues = 7;
  final int tableSize = 6;

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
        Center(
          child: Container(
            height: 300,
            padding: const EdgeInsets.all(10),
            /*decoration: BoxDecoration( // Box around the animation
              border: Border.all(color: Colors.black26),
              borderRadius: BorderRadius.circular(12),
            ),*/
            child: CustomPaint(
              painter: ChainedHashTablePainter(hashTable),
              child: Container(),
            ),
          ),
        ),
      ],
    );
  }
}

class ChainedHashTablePainter extends CustomPainter {
  final List<List<int>> hashTable;
  final int tableSize = 6;

  ChainedHashTablePainter(this.hashTable);

  @override
  void paint(Canvas canvas, Size size) {
    double cellHeight = size.height / hashTable.length;
    double cellWidth = cellHeight;
    double borderRadius = 10;
    double formulaSpacing = 60;
    double valueSpacing = 60;

    Paint indexCellPaint = Paint()
      ..color = const Color(0xFFDFAEE0)
      ..style = PaintingStyle.fill;

    Paint valueCellPaint = Paint()
      ..color = const Color(0xFFDFAEE9)
      ..style = PaintingStyle.fill;

    Paint borderPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Paint linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1;

    // Indexes and values
    for (int i = 0; i < hashTable.length; i++) {
      double y = i * cellHeight;

      RRect indexRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(10, y, cellWidth, cellHeight - 5),
        Radius.circular(borderRadius),
      );
      canvas.drawRRect(indexRect, indexCellPaint);
      canvas.drawRRect(indexRect, borderPaint);

      // Draw index text
      TextPainter indexText = TextPainter(
        text: TextSpan(
          text: '$i',
          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        textDirection: TextDirection.ltr,
      );
      indexText.layout();
      indexText.paint(canvas, Offset(
        10 + (cellWidth - indexText.width) / 2,
        y + (cellHeight - indexText.height) / 2,
      ));

      double xOffset = 10 + cellWidth + formulaSpacing;

      if (i == hashTable.length ~/ 2) {
        RRect formulaRect = RRect.fromRectAndRadius(
          Rect.fromLTWH(xOffset, y, cellWidth, cellHeight - 5),
          Radius.circular(borderRadius),
        );
        Paint formulaCellPaint = Paint()
          ..color = Colors.grey
          ..style = PaintingStyle.fill;

        canvas.drawRRect(formulaRect, formulaCellPaint);
        canvas.drawRRect(formulaRect, borderPaint);

        // Draw the text "key % CAPACITY"
        TextPainter formulaText = TextPainter(
          text: TextSpan(
            text: 'hashCode',
            style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
          ),
          textDirection: TextDirection.ltr,
        );
        formulaText.layout();
        formulaText.paint(canvas, Offset(
          xOffset + (cellWidth - formulaText.width) / 2,
          y + (cellHeight - formulaText.height) / 2, // Use 'y' for the formula's vertical position
        ));

        // Now, draw arrows from each index to the formula cell
        for (int i = 0; i < hashTable.length; i++) {
          _drawArrowIcon(
            canvas,
            Offset(10 + cellWidth, i * cellHeight + cellHeight / 2), // From index rectangle (right side)
            Offset(xOffset, y + cellHeight / 2), // To formula box
          );

          // Draw reverse arrows from the formula back to the index values
          for (int value in hashTable[i]) {
            double valueXOffset = xOffset + cellWidth + 10;
            _drawArrowIcon(
              canvas,
              Offset(xOffset + cellWidth, y + cellHeight / 2), // From formula
              Offset(valueXOffset, y + cellHeight / 2), // To values
            );
          }
        }
        // Csak az első értékhez rajzolunk nyilat minden sorban
        for (int row = 0; row < hashTable.length; row++) {
          if (hashTable[row].isNotEmpty) {
            double valueXOffset = xOffset + cellWidth + valueSpacing;
            double valueY = row * cellHeight;

            int firstValue = hashTable[row].first;

            _drawArrowIcon(
              canvas,
              Offset(xOffset + cellWidth, y + cellHeight / 2),  // From formula cell (middle row)
              Offset(valueXOffset, valueY + cellHeight / 2),    // To first value cell in each row
            );
          }
        }
      }

      double valueXOffset = xOffset + cellWidth + valueSpacing;

      // The values for the indexes
      for (int value in hashTable[i]) {
        RRect valueRect = RRect.fromRectAndRadius(
          Rect.fromLTWH(valueXOffset, y, cellWidth, cellHeight - 5),
          Radius.circular(borderRadius),
        );
        canvas.drawRRect(valueRect, valueCellPaint);
        canvas.drawRRect(valueRect, borderPaint);

        TextPainter valueText = TextPainter(
          text: TextSpan(
            text: '$value',
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          textDirection: TextDirection.ltr,
        );
        valueText.layout();
        valueText.paint(canvas, Offset(
          valueXOffset + (cellWidth - valueText.width) / 2,
          y + (cellHeight - valueText.height) / 2,
        ));

        /*if (valueXOffset > xOffset + cellWidth + 10) {
          _drawArrow(
            canvas,
            Offset(valueXOffset - cellWidth - 10 + cellWidth, y + cellHeight / 2),
            Offset(valueXOffset, y + cellHeight / 2),
            linePaint,
          );
        }*/

        valueXOffset += cellWidth + 10;
      }
    }
  }

  void _drawArrowIcon(Canvas canvas, Offset start, Offset end) {
    const double arrowSize = 8.0;

    // Calculate the angle between the start and end points
    final double angle = atan2(end.dy - start.dy, end.dx - start.dx);

    // Draw the line (arrow body) between the start and end
    canvas.drawLine(start, end, Paint()..color = Colors.black..strokeWidth = 1);

    // Draw the arrowhead at the end of the line
    Path path = Path();
    path.moveTo(end.dx, end.dy);
    path.lineTo(end.dx - arrowSize * cos(angle - pi / 6), end.dy - arrowSize * sin(angle - pi / 6));
    path.moveTo(end.dx, end.dy);
    path.lineTo(end.dx - arrowSize * cos(angle + pi / 6), end.dy - arrowSize * sin(angle + pi / 6));
    canvas.drawPath(path, Paint()..color = Colors.grey..style = PaintingStyle.fill);
  }

  void _drawArrow(Canvas canvas, Offset start, Offset end, Paint paint) {
    const double arrowSize = 8.0;
    canvas.drawLine(start, end, paint);

    final angle = atan2(end.dy - start.dy, end.dx - start.dx);
    final path = Path();
    path.moveTo(end.dx, end.dy);
    path.lineTo(end.dx - arrowSize * cos(angle - pi / 6), end.dy - arrowSize * sin(angle - pi / 6));
    path.moveTo(end.dx, end.dy);
    path.lineTo(end.dx - arrowSize * cos(angle + pi / 6), end.dy - arrowSize * sin(angle + pi / 6));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
*/

/// 2. Animation

class ChainedHashTableAnimation extends StatefulWidget {
  @override
  _ChainedHashTableAnimationState createState() => _ChainedHashTableAnimationState();
}

class _ChainedHashTableAnimationState extends State<ChainedHashTableAnimation> {
  final List<String> names = ['John Smith', 'Lisa Smith', 'Sam Doe', 'Sandra Dee'];
  final List<List<String>> hashTable = List.generate(6, (_) => []);
  final Map<String, int> hashMapping = {};

  int hash(String name) {
    return name.codeUnits.reduce((a, b) => a + b) % hashTable.length;
  }

  void insertName(String name) {
    final index = hash(name);
    setState(() {
      hashTable[index].add(name);
      hashMapping[name] = index;
    });
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < names.length; i++) {
      Future.delayed(Duration(milliseconds: i * 800), () {
        insertName(names[i]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Input names
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: names.map((name) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: AnimatedOpacity(
                    opacity: hashMapping.containsKey(name) ? 0.3 : 1.0,
                    duration: Duration(milliseconds: 400),
                    child: Container(
                      width: 120,
                      padding: EdgeInsets.all(8),
                      color: Colors.cyan,
                      child: Text(name, style: TextStyle(color: Colors.black)),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(width: 40),
            // Arrows & Hash Table
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(hashTable.length, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  padding: EdgeInsets.all(8),
                  width: 100,
                  color: Colors.grey[300],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('[$index]'),
                      ...hashTable[index].map((e) => Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 4),
                        child: Text('→ $e'),
                      )),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}