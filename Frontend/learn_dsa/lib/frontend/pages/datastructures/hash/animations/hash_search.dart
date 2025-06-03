import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChainedHashTableSearchAnimation extends StatefulWidget {
  const ChainedHashTableSearchAnimation({super.key});

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

  final double cellWidth = 60;
  final double cellHeight = 40;

  ChainedDynamicHashTablePainter(this.table, this.visibleLengths, this.currentI, this.currentJ, this.found);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint borderPaint1 = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = Colors.purple.shade500
      ..style = PaintingStyle.fill;

    final Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4.0);

    final textStyle = TextStyle(color: Colors.white, fontSize: 16);
    final textPainter = TextPainter(textAlign: TextAlign.center, textDirection: TextDirection.ltr);

    // Indexes
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
        } else if (isFirst && !isLast) {
          // Apply rounded corners only for the first cell (left side)
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
              topRight: Radius.circular(0),
              bottomRight: Radius.circular(0),
            ),
            Paint()..color = Colors.purple.shade200,
          );
        } else if (isLast && !isFirst) {
          // Apply rounded corners only for the last cell (right side)
          canvas.drawRRect(
            RRect.fromRectAndCorners(
              Rect.fromLTWH(chainX, chainY, keyWidth, cellHeight),
              topLeft: Radius.circular(0),
              bottomLeft: Radius.circular(0),
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
        } else {
          // Regular cell without rounded corners for middle cells
          canvas.drawRect(
            Rect.fromLTWH(chainX, chainY, keyWidth, cellHeight),
            Paint()..color = Colors.purple.shade200,
          );
          canvas.drawRect(
            Rect.fromLTWH(chainX + keyWidth, chainY, valueWidth, cellHeight),
            Paint()..color = Colors.purple.shade200,
          );
        }

        Color color = Colors.purple.shade200;
        if (i == currentI && j == currentJ) {
          color = found ? Colors.purpleAccent : Colors.purple.shade900;
        }
        final fillChainPaint = Paint()..color = color;
        canvas.drawRRect(totalRect, fillChainPaint);

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

        canvas.drawRRect(totalRect, borderPaint1);

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

//---------------------------------------------------------------------------------------------------------------

class ChainedDynamicHashTableSearchAnimation extends StatefulWidget {
  const ChainedDynamicHashTableSearchAnimation({super.key});

  @override
  _ChainedDynamicHashTableSearchAnimationState createState() => _ChainedDynamicHashTableSearchAnimationState();
}

class _ChainedDynamicHashTableSearchAnimationState extends State<ChainedDynamicHashTableSearchAnimation>
    with TickerProviderStateMixin {
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

  Future<void> _searchForKey(int key) async {
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

      if (hashTable[bucket][j].key == key) break;
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
              painter: ChainedDynamicHashTableSearchPainter(
                hashTable,
                visibleLengths,
                highlightedIndexI,
                highlightedIndexJ,
              ),
              child: Container(),
            ),
          ),
        ),

        Text(
          'searchItem(table, 6)',
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
              _searchForKey(6);
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

class ChainedDynamicHashTableSearchPainter extends CustomPainter {
  final List<List<MapEntry<int, int>>> table;
  final List<int> visibleLengths;
  final int? highlightedI;
  final int? highlightedJ;
  final double cellWidth = 60;
  final double cellHeight = 40;

  ChainedDynamicHashTableSearchPainter(this.table, this.visibleLengths, this.highlightedI, this.highlightedJ);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint borderPaint = Paint()
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

      RRect bucketRRect = RRect.fromRectAndCorners(bucketRect,
        topLeft: i == 0 ? Radius.circular(10) : Radius.zero,
        bottomLeft: i == table.length - 1 ? Radius.circular(10) : Radius.zero,
        topRight: i == 0 ? Radius.circular(10) : Radius.zero,
        bottomRight: i == table.length - 1 ? Radius.circular(10) : Radius.zero,
      );

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

        canvas.drawRRect(chainRRect.shift(Offset(4, 4)), shadowPaint);

        final isHighlighted = (highlightedI == i && highlightedJ == j);
        final fillChainPaint = Paint()
          ..color = isHighlighted ? Color(0xFF255f38) :  Color(0xFF1f7d53)
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
