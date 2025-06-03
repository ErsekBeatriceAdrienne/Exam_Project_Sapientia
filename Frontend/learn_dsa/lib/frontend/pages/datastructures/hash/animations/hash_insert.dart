import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HashTableInsertAnimation extends StatefulWidget {
  const HashTableInsertAnimation({super.key});

  @override
  _HashTableInsertAnimationState createState() => _HashTableInsertAnimationState();
}

class _HashTableInsertAnimationState extends State<HashTableInsertAnimation> with SingleTickerProviderStateMixin {
  final List<List<MapEntry<int, int>>> hashTable = [
    [],
    [],
    [],
    [],
    [],
  ];

  late List<int> visibleLengths;
  bool hasInserted = false;

  @override
  void initState() {
    super.initState();
    visibleLengths = List.filled(hashTable.length, 0);
  }

  Future<void> _startAnimation() async {
    setState(() {
      hashTable[0].add(MapEntry(0, 23));
    });

    await Future.delayed(Duration(milliseconds: 500));
    HapticFeedback.heavyImpact();
    setState(() {
      visibleLengths[0]++;
      hasInserted = true;
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

        Text(
          'insert(table, 0, 23)',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 10),

        Container(
          width: AppLocalizations.of(context)!.play_animation_button_text.length * 10 + 20,
          height: 40,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF255f38), Color(0xFF27391c)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 4,
                offset: Offset(4, 4),
              ),
            ],
          ),
          child: RawMaterialButton(
            onPressed: () {
              hasInserted ? null : _startAnimation();
              HapticFeedback.mediumImpact();
            },
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            constraints: const BoxConstraints.tightFor(width: 45, height: 45),
            child: Center(
              child : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.play_arrow_rounded,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    size: 24,
                  ),
                  Text(
                    AppLocalizations.of(context)!.play_animation_button_text,
                    style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
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
    final blackBorder = Paint()
      ..color = Colors.white
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = Color(0xFF255f38)
      ..style = PaintingStyle.fill;

    final Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4.0);

    final textStyleHeader = TextStyle(color: Colors.black, fontSize: 16);
    final textStyleCell = TextStyle(color: Colors.white, fontSize: 16);

    final textPainter = TextPainter(textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    final textStyle = TextStyle(color: Colors.white, fontSize: 14);

    // Indexes
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
            Paint()..color = Color(0xFF1f7d53),
          );
          canvas.drawRRect(
            RRect.fromRectAndCorners(
              Rect.fromLTWH(chainX + keyWidth, chainY, valueWidth, cellHeight),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            Paint()..color = Color(0xFF1f7d53),
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

// ---------------------------------------------------------------------------------------------------------------------------------------------------

class ChainedDynamicHashTableInsertAnimation extends StatefulWidget {
  const ChainedDynamicHashTableInsertAnimation({super.key});

  @override
  _ChainedDynamicHashTableInsertAnimationState createState() =>
      _ChainedDynamicHashTableInsertAnimationState();
}

class _ChainedDynamicHashTableInsertAnimationState
    extends State<ChainedDynamicHashTableInsertAnimation> with TickerProviderStateMixin {
  final List<List<MapEntry<int, int>>> hashTable = [
    [MapEntry(0, 11)],
    [MapEntry(1, 2), MapEntry(6, 5), MapEntry(11, 22)],
    [],
    [MapEntry(8, 1)],
    [MapEntry(4, 4), MapEntry(9, 23)],
  ];

  late List<int> visibleLengths;

  static const int capacity = 5;

  @override
  void initState() {
    super.initState();
    visibleLengths = List.generate(hashTable.length, (i) => hashTable[i].length);
  }

  int hashCodeInt(int key) {
    int sum = 0;
    int factor = 31;
    while (key != 0) {
      int digit = key % 10;
      sum = (sum + (digit * factor) % capacity) % capacity;
      factor = (factor * 31) % 32767;
      key ~/= 10;
    }
    return sum;
  }

  bool _hasInserted = false;

  Future<void> _insertEntry(int key, int value) async {
    if (_hasInserted) return;

    int index = hashCodeInt(key);
    hashTable[index].add(MapEntry(key, value));
    HapticFeedback.mediumImpact();

    setState(() {
      visibleLengths[index] = hashTable[index].length;
      _hasInserted = true;
    });
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
        const Text(
          'insert(table, 13, 7)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10),

        Container(
          width: AppLocalizations.of(context)!.play_animation_button_text.length * 10 + 20,
          height: 40,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF255f38), Color(0xFF27391c)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 4,
                offset: Offset(4, 4),
              ),
            ],
          ),
          child: RawMaterialButton(
            onPressed: () {
              _insertEntry(13, 7);
              HapticFeedback.mediumImpact();
            },
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            constraints: const BoxConstraints.tightFor(width: 45, height: 45),
            child: Center(
              child : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.play_arrow_rounded,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    size: 24,
                  ),
                  Text(
                    AppLocalizations.of(context)!.play_animation_button_text,
                    style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
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

    final Paint fillPaint = Paint()
      ..color =  Color(0xFF255f38)
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

      canvas.drawRRect(bucketRRect.shift(Offset(5, 4)), shadowPaint);
      canvas.drawRRect(bucketRRect, fillPaint);
      canvas.drawRRect(bucketRRect, borderPaint);

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

        final shadowPaint = Paint()
          ..color = Colors.black26
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4);

        canvas.drawRRect(chainRRect.shift(Offset(4, 4)), shadowPaint);

        final fillChainPaint = Paint()
          ..color = Color(0xFF1f7d53)
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

        textPainter.text = TextSpan(text: '${pair.key}', style: keyStyle);
        textPainter.layout(minWidth: 0, maxWidth: cellWidth * 0.4 - 10);
        textPainter.paint(canvas, Offset(chainX + 8, chainY + (cellHeight - textPainter.height) / 2));

        textPainter.text = TextSpan(text: '${pair.value}', style: valueStyle);
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
