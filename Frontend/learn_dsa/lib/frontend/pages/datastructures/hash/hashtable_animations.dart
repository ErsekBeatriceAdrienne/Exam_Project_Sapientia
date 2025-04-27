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

  ChainedHashTablePainter(this.hashTable);

  @override
  void paint(Canvas canvas, Size size) {
    double cellHeight = size.height / hashTable.length;
    double cellWidth = cellHeight;
    double borderRadius = 10;

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
      ..strokeWidth = 2;

    // Indexes
    for (int i = 0; i < hashTable.length; i++) {
      double y = i * cellHeight;

      RRect indexRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(10, y, cellWidth, cellHeight - 5),
        Radius.circular(borderRadius),
      );
      canvas.drawRRect(indexRect, indexCellPaint);
      canvas.drawRRect(indexRect, borderPaint);

      /*if (hashTable[i].isNotEmpty) {
        _drawArrowWithHead(
          canvas,
          Offset(10 + cellWidth, y + (cellHeight - 5) / 2),
          Offset(10 + cellWidth + 20, y + (cellHeight - 5) / 2),
          linePaint,
        );
      }*/

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

      double xOffset = 10 + cellWidth + 10;

      // The values for the indexes
      for (int value in hashTable[i]) {
        RRect valueRect = RRect.fromRectAndRadius(
          Rect.fromLTWH(xOffset, y, cellWidth, cellHeight - 5),
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
          xOffset + (cellWidth - valueText.width) / 2,
          y + (cellHeight - valueText.height) / 2,
        ));

        if (xOffset > 10 + cellWidth + 10) {
          _drawArrow(
            canvas,
            Offset(xOffset - cellWidth - 10 + cellWidth, y + cellHeight / 2),
            Offset(xOffset, y + cellHeight / 2),
            linePaint,
          );
        }

        xOffset += cellWidth + 10;
      }
    }
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

  void _drawArrowWithHead(Canvas canvas, Offset start, Offset end, Paint paint) {

    canvas.drawLine(start, end, paint);
    final double arrowHeadSize = 8;
    final angle = atan2(end.dy - start.dy, end.dx - start.dx);

    final path = Path();
    path.moveTo(end.dx, end.dy);
    path.lineTo(
      end.dx - arrowHeadSize * cos(angle - pi / 6),
      end.dy - arrowHeadSize * sin(angle - pi / 6),
    );
    path.moveTo(end.dx, end.dy);
    path.lineTo(
      end.dx - arrowHeadSize * cos(angle + pi / 6),
      end.dy - arrowHeadSize * sin(angle + pi / 6),
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
