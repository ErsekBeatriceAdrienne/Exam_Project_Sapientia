import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../helpers/essentials.dart';

class SelectionSortAnimationWidget extends StatefulWidget {
  const SelectionSortAnimationWidget({super.key});

  @override
  _SelectionSortAnimationWidgetState createState() => _SelectionSortAnimationWidgetState();
}

class _SelectionSortAnimationWidgetState extends State<SelectionSortAnimationWidget> {
  List<int> array = [64, 25, 12, 22, 11];
  int? currentIndex;
  int? comparingIndex;
  int? minIndex;
  bool isAnimating = false;
  bool isPaused = false;
  Completer<void>? _pauseCompleter;

  void _startOrToggleAnimation() {
    if (!isAnimating) {
      setState(() {
        array = [64, 25, 12, 22, 11];
        currentIndex = null;
        comparingIndex = null;
        minIndex = null;
        isAnimating = true;
        isPaused = false;
      });
      _selectionSort().then((_) {
        setState(() {
          isAnimating = false;
          currentIndex = null;
          comparingIndex = null;
          minIndex = null;
        });
      });
    } else {
      setState(() {
        isPaused = !isPaused;
      });
      if (!isPaused) {
        _pauseCompleter?.complete();
      }
    }
  }

  Future<void> _pauseIfNeeded() async {
    if (isPaused) {
      _pauseCompleter = Completer<void>();
      await _pauseCompleter!.future;
      _pauseCompleter = null;
    }
  }

  Future<void> _selectionSort() async {
    int n = array.length;
    for (int i = 0; i < n - 1; i++) {
      minIndex = i;
      setState(() {
        currentIndex = i;
        comparingIndex = null;
      });
      await Future.delayed(Duration(seconds: 1));
      await _pauseIfNeeded();

      for (int j = i + 1; j < n; j++) {
        setState(() {
          comparingIndex = j;
        });
        await Future.delayed(Duration(seconds: 1));
        await _pauseIfNeeded();

        if (array[j] < array[minIndex!]) {
          minIndex = j;
          setState(() {});
          await Future.delayed(Duration(milliseconds: 500));
          await _pauseIfNeeded();
        }
      }

      if (minIndex != i) {
        int temp = array[i];
        array[i] = array[minIndex!];
        array[minIndex!] = temp;

        HapticFeedback.mediumImpact();
        setState(() {});
        await Future.delayed(Duration(seconds: 1));
        await _pauseIfNeeded();
      }
    }
  }

  @override
  void dispose() {
    isAnimating = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BorderSide side = BorderSide(color: Colors.white, width: 1.5);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Array Display
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(array.length, (i) {
              Color color = Colors.grey.shade300;

              if (i == currentIndex) {
                color = Colors.green;
              } else if (i == comparingIndex) {
                color = Colors.green.shade700;
              } else if (i == minIndex) {
                color = Colors.green.shade700;
              } else if (currentIndex != null && i < currentIndex!) {
                // már rendezett rész
                color = Colors.green.shade900;
              } else {
                color = Color(0xFF255f38);
              }

              BorderRadius borderRadius;
              if (i == 0) {
                borderRadius = BorderRadius.horizontal(left: Radius.circular(12));
              } else if (i == array.length - 1)
                borderRadius = BorderRadius.horizontal(right: Radius.circular(12));
              else
                borderRadius = BorderRadius.zero;

              return Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: color,
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
                  array[i].toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              );
            }),
          ),

          SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Essentials().buildHighlightedCodeLinesWithoutLineNumbers(
                  'selectionSort(arr, 5);',
                ),
              ],
            ),
          ),

          // Play/pause button
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
                _startOrToggleAnimation();
                HapticFeedback.mediumImpact();
              },
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isAnimating
                        ? (isPaused ? Icons.play_arrow_rounded : Icons.pause)
                        : Icons.play_arrow_rounded,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    size: 22,
                  ),
                  SizedBox(width: 8),
                  Text(
                    isAnimating && !isPaused
                        ? AppLocalizations.of(context)!.pause_animation_button_text
                        : AppLocalizations.of(context)!.play_animation_button_text,
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
      ),
    );
  }
}
