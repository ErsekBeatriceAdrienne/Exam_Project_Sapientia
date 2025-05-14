import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ArrayDeleteAtWidget extends StatefulWidget {
  @override
  _ArrayDeleteAtWidgetState createState() => _ArrayDeleteAtWidgetState();
}

class _ArrayDeleteAtWidgetState extends State<ArrayDeleteAtWidget> {
  List<int?> array = [];
  int size = 3;
  final int capacity = 5;
  bool showArray = true;

  bool hasInserted = false;
  bool isAnimating = false;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    array = [3, 5, 8, null, null];
  }

  void _deleteAt(int index) {
    if (index < 0 || index >= size) return;

    int steps = index;
    Timer.periodic(Duration(milliseconds: 150), (timer) {
      if (steps == size - 1) {
        setState(() {
          array[steps] = null;
          size--;
        });
        timer.cancel();
      } else {
        setState(() {
          array[steps] = array[steps + 1];
        });
        steps++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    BorderSide side = BorderSide(color: Colors.white, width: 1.5);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showArray) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                capacity,
                    (i) {
                  BorderRadius borderRadius;

                  if (i == 0)
                    borderRadius =
                        BorderRadius.horizontal(left: Radius.circular(12));
                  else if (i == capacity - 1)
                    borderRadius =
                        BorderRadius.horizontal(right: Radius.circular(12));
                  else
                    borderRadius = BorderRadius.zero;

                  final bool isHighlighted = i < size;

                  return Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: array[i] != null ? Color(0xFF255f38) : Colors.grey
                          .shade300,
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
              '${AppLocalizations.of(context)!.size_text}: $size | ${AppLocalizations.of(context)!.capacity_text}: $capacity',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "deleteItemAt(a, 1)",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xFF1f7d53)),
              ),
            ),

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
                onPressed: isAnimating ? null : () {
                  if (!hasInserted) {
                    _deleteAt(1);
                    setState(() {
                      hasInserted = true;
                      HapticFeedback.mediumImpact();
                    });
                  } else {
                    setState(() {
                      array = [3, 5, 8, null, null];
                      size = 3;
                      hasInserted = false;
                      HapticFeedback.mediumImpact();
                    });
                    Future.delayed(Duration(milliseconds: 200), () {
                      _deleteAt(1);
                      setState(() {
                        hasInserted = true;
                        HapticFeedback.mediumImpact();
                      });
                    });
                  }
                },
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                constraints: const BoxConstraints.tightFor(
                    width: 45, height: 45),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isAnimating
                            ? (isPaused ? Icons.play_arrow_rounded : Icons
                            .pause)
                            : Icons.play_arrow_rounded,
                        color: Theme
                            .of(context)
                            .scaffoldBackgroundColor,
                        size: 24,
                      ),
                      Text(
                        isAnimating && !isPaused ? AppLocalizations.of(context)!.pause_animation_button_text : AppLocalizations.of(context)!.play_animation_button_text,
                        style: TextStyle(
                          color: Theme
                              .of(context)
                              .scaffoldBackgroundColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

}
