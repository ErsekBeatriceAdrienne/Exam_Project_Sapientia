import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChainedHashTableAnimation extends StatefulWidget {
  const ChainedHashTableAnimation({super.key});

  @override
  _ChainedHashTableAnimationState createState() => _ChainedHashTableAnimationState();
}

class _ChainedHashTableAnimationState extends State<ChainedHashTableAnimation> with TickerProviderStateMixin {
  final List<MapEntry<int, int>> entriesToInsert = [
    MapEntry(0, 11),
    MapEntry(1, 2),
    MapEntry(4, 4),
    MapEntry(6, 5),
    MapEntry(8, 1),
    MapEntry(11, 22),
    MapEntry(9, 23),
  ];

  final int tableSize = 5;
  late List<List<MapEntry<int, int>>> hashTable;
  late List<int> visibleLengths;

  @override
  void initState() {
    super.initState();
    hashTable = List.generate(tableSize, (_) => []);
    visibleLengths = List.filled(tableSize, 0);

    for (final entry in entriesToInsert) {
      int index = _hash(entry.key);
      hashTable[index].add(entry);
      visibleLengths[index]++;
    }
  }

  int _hash(int key) => key % tableSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              height: 250,
              padding: const EdgeInsets.all(10),
              child: CustomPaint(
                painter: ChainedHashTablePainter(hashTable, visibleLengths),
                child: Center(
                  child: Container(),
                ),
              ),
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
  void paint(Canvas canvas, Size size)
  {
    final Paint fillPaint = Paint()
      ..color = Color(0xFF255f38)
      ..style = PaintingStyle.fill;

    final Paint borderPaint1 = Paint()
      ..color = Colors.white
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4.0);

    final textPainter = TextPainter(textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    final textStyle = TextStyle(color: Colors.white, fontSize: 14);

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
      textPainter.text = TextSpan(text: '$i', style: textStyle);
      textPainter.layout();
      textPainter.paint(canvas, baseOffset + Offset(5, 10));

      // Values
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

        final totalRect = RRect.fromRectAndCorners(
          Rect.fromLTWH(chainX, chainY, keyWidth + valueWidth, cellHeight),
          topLeft: isFirst ? Radius.circular(10) : Radius.zero,
          bottomLeft: isFirst ? Radius.circular(10) : Radius.zero,
          topRight: isLast ? Radius.circular(10) : Radius.zero,
          bottomRight: isLast ? Radius.circular(10) : Radius.zero,
        );
        // Shadow
        canvas.drawRRect(totalRect.shift(Offset(4, 4)), shadowPaint);

        // Drawing the key-value cells with the rounded corners
        if (isFirst && isLast) {
          // Apply rounded corners for both the first and last cell
          canvas.drawRRect(
            RRect.fromRectAndCorners(
              Rect.fromLTWH(chainX, chainY, keyWidth, cellHeight),
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            Paint()..color = Color(0xFF006a42),
          );
          canvas.drawRRect(
            RRect.fromRectAndCorners(
              Rect.fromLTWH(chainX + keyWidth, chainY, valueWidth, cellHeight),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            Paint()..color = Color(0xFF006a42),
          );
        } else if (isFirst && !isLast) {
          // Apply rounded corners only for the first cell (left side)
          canvas.drawRRect(
            RRect.fromRectAndCorners(
              Rect.fromLTWH(chainX, chainY, keyWidth, cellHeight),
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            Paint()..color = Color(0xFF006a42),
          );
          canvas.drawRRect(
            RRect.fromRectAndCorners(
              Rect.fromLTWH(chainX + keyWidth, chainY, valueWidth, cellHeight),
              topRight: Radius.circular(0),
              bottomRight: Radius.circular(0),
            ),
            Paint()..color = Color(0xFF006a42),
          );
        } else if (isLast && !isFirst) {
          // Apply rounded corners only for the last cell (right side)
          canvas.drawRRect(
            RRect.fromRectAndCorners(
              Rect.fromLTWH(chainX, chainY, keyWidth, cellHeight),
              topLeft: Radius.circular(0),
              bottomLeft: Radius.circular(0),
            ),
            Paint()..color = Color(0xFF006a42),
          );
          canvas.drawRRect(
            RRect.fromRectAndCorners(
              Rect.fromLTWH(chainX + keyWidth, chainY, valueWidth, cellHeight),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            Paint()..color = Color(0xFF006a42),
          );
        } else {
          // Regular cell without rounded corners for middle cells
          canvas.drawRect(
            Rect.fromLTWH(chainX, chainY, keyWidth, cellHeight),
            Paint()..color = Color(0xFF006a42),
          );
          canvas.drawRect(
            Rect.fromLTWH(chainX + keyWidth, chainY, valueWidth, cellHeight),
            Paint()..color = Color(0xFF006a42),
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

/*
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
*/


// ----------------------------------------------------------------------------------------------------------------------------------------------------------------------

class ChainedDynamicHashTableAnimation extends StatefulWidget {
  const ChainedDynamicHashTableAnimation({super.key});

  @override
  _ChainedDynamicHashTableAnimationState createState() => _ChainedDynamicHashTableAnimationState();
}

class _ChainedDynamicHashTableAnimationState extends State<ChainedDynamicHashTableAnimation> with TickerProviderStateMixin {
  final List<List<MapEntry<int, int>>> hashTable = [
    [MapEntry(0, 11)],
    [MapEntry(1, 2), MapEntry(6, 5), MapEntry(11, 22)],
    [],
    [MapEntry(8, 1)],
    [MapEntry(4, 4), MapEntry(9, 23)],
  ];

  late List<int> visibleLengths;

  @override
  void initState() {
    super.initState();
    visibleLengths = hashTable.map((list) => list.length).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
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
        ),
      ],
    );
  }
}

class ChainedDynamicHashTablePainter extends CustomPainter {
  final List<List<MapEntry<int, int>>> table;
  final List<int> visibleLengths;
  final double cellWidth = 60;
  final double cellHeight = 40;

  ChainedDynamicHashTablePainter(this.table, this.visibleLengths);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final Paint borderPaint1 = Paint()
      ..color = Colors.white
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final Paint fillPaint = Paint()
      ..color = Color(0xFF255f38)
      ..style = PaintingStyle.fill;

    final Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4.0);

    final textPainter = TextPainter(textAlign: TextAlign.center, textDirection: TextDirection.ltr);
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

      List<MapEntry<int, int>> chain = table[i];
      int visible = visibleLengths[i];

      for (int j = 0; j < visible && j < chain.length; j++) {
        final chainX = (j + 1) * (cellWidth + 10);
        final chainY = baseOffset.dy;

        final chainRect = Rect.fromLTWH(chainX, chainY, cellWidth, cellHeight);
        final chainRRect = RRect.fromRectAndRadius(chainRect, Radius.circular(8));

        final shadowPaint = Paint()
          ..color = Colors.black26
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4);

        // Shadow
        canvas.drawRRect(
          chainRRect.shift(Offset(4, 4)),
          shadowPaint,
        );

        final fillChainPaint = Paint()
          ..color = Color(0xFF006a42)
          ..style = PaintingStyle.fill;

        canvas.drawRRect(chainRRect, fillChainPaint);
        canvas.drawRRect(chainRRect, borderPaint);

        final pair = chain[j];
        final separatorX = chainX + cellWidth * 0.4;

        canvas.drawLine(
          Offset(separatorX, chainY + 5),
          Offset(separatorX, chainY + cellHeight - 5),
          Paint()..color = Colors.white..strokeWidth = 1.5,
        );

        final TextStyle keyStyle = textStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12);
        final TextStyle valueStyle = textStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12);

// Draw key
        textPainter.text = TextSpan(
          text: '${pair.key}',
          style: keyStyle,
        );
        textPainter.layout(minWidth: 0, maxWidth: cellWidth * 0.4 - 10);
        textPainter.paint(canvas, Offset(chainX + 8, chainY + (cellHeight - textPainter.height) / 2));

// Draw value
        textPainter.text = TextSpan(
          text: '${pair.value}',
          style: valueStyle,
        );
        textPainter.layout(minWidth: 0, maxWidth: cellWidth * 0.6 - 10);
        textPainter.paint(canvas, Offset(separatorX + 8, chainY + (cellHeight - textPainter.height) / 2));

        Offset arrowStart = j == 0
            ? Offset(baseOffset.dx + cellWidth, baseOffset.dy + cellHeight / 2)
            : Offset((j) * (cellWidth + 10) + cellWidth, chainY + cellHeight / 2);

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


