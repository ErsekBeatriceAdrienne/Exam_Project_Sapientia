import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ArrayInsertFirstWidget extends StatefulWidget {
  @override
  _ArrayInsertFirstWidgetState createState() => _ArrayInsertFirstWidgetState();
}

class _ArrayInsertFirstWidgetState extends State<ArrayInsertFirstWidget> {
  List<int?> array = [];
  int size = 3;
  final int capacity = 5;
  bool showArray = true;
  bool hasInsertedOne = false;
  bool isAnimating = false;
  String insertedValuesText = "";
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    array = [3, 5, 8, null, null];
  }

  void _handlePlayButton() {
    if (isAnimating) return;

    if (hasInsertedOne) {
      // Reset state
      setState(() {
        array = [3, 5, 8, null, null];
        size = 3;
        hasInsertedOne = false;
        insertedValuesText = "";
      });
      Future.delayed(Duration(milliseconds: 200), () {
        _insertFirst(1); // restart animation after reset
      });
    } else {
      _insertFirst(1); // start animation first time
    }
  }

  void _insertFirst(int value) {
    if (size >= capacity || hasInsertedOne) return;

    hasInsertedOne = true;
    isAnimating = true;
    isPaused = false;
    int steps = size;

    Timer.periodic(Duration(milliseconds: 300), (timer) {
      if (steps == 0) {
        setState(() {
          array[0] = value;
          size++;
          insertedValuesText += "$value ";
          isAnimating = false;
          isPaused = true;
        });
        timer.cancel();
      } else {
        setState(() {
          array[steps] = array[steps - 1];
          HapticFeedback.mediumImpact();
        });
        steps--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    BorderSide side = BorderSide(color: Colors.white, width: 1.5);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showArray) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                capacity,
                    (i) {
                  BorderRadius borderRadius;

                  if (i == 0)
                    borderRadius = BorderRadius.horizontal(left: Radius.circular(12));
                  else if (i == capacity - 1)
                    borderRadius = BorderRadius.horizontal(right: Radius.circular(12));
                  else
                    borderRadius = BorderRadius.zero;

                  final bool isHighlighted = i < size;

                  return Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: array[i] != null ? Color(0xFF255f38) : Colors.grey.shade300,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 8,
                          offset: Offset(4, 4),
                        ),
                      ],
                      borderRadius: borderRadius,
                      border: Border(
                        top: side,
                        bottom: side,
                        left: i == 0 ? side : BorderSide.none,
                        right: side,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      array[i]?.toString() ?? '',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 10),

            Text(
              'Size: $size | Capacity: $capacity',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "insertFirst(a, 1)",
                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1f7d53)),
              ),
            ),

            SizedBox(height: 10),

            Container(
              width: 70,
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
                onPressed: isAnimating ? null : () {
                  HapticFeedback.mediumImpact();
                  _handlePlayButton();
                },
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                constraints: const BoxConstraints.tightFor(width: 45, height: 45),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      isAnimating
                          ? (isPaused ? Icons.play_arrow_rounded : Icons.pause)
                          : Icons.play_arrow_rounded,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      size: 22,
                    ),
                    Text(
                      isAnimating && !isPaused ? 'Pause' : 'Play',
                      style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ],
      ),
    );
  }
}
