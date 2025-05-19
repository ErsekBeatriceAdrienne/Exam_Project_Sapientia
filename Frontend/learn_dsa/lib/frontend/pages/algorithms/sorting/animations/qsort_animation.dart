import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../helpers/essentials.dart';

class QuickSortAnimationWidget extends StatefulWidget {
  const QuickSortAnimationWidget({super.key});

  @override
  _QuickSortAnimationWidgetState createState() => _QuickSortAnimationWidgetState();
}

class _QuickSortAnimationWidgetState extends State<QuickSortAnimationWidget> {
  List<int> array = [1, 4, 3, 5, 2];
  int? pivotIndex;
  int? leftIndex;
  int? rightIndex;
  bool isAnimating = false;
  bool isPaused = false;
  Completer<void>? _pauseCompleter;

  void _startOrToggleAnimation() {
    if (!isAnimating) {
      setState(() {
        array = [1, 4, 3, 5, 2];
        pivotIndex = null;
        leftIndex = null;
        rightIndex = null;
        isAnimating = true;
        isPaused = false;
      });
      _quickSort(0, array.length - 1).then((_) {
        setState(() {
          isAnimating = false;
          pivotIndex = null;
          leftIndex = null;
          rightIndex = null;
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

  Future<void> _quickSort(int low, int high) async {
    if (low < high) {
      int p = await _partition(low, high);
      await _quickSort(low, p - 1);
      await _quickSort(p + 1, high);
    }
  }

  Future<int> _partition(int low, int high) async {
    setState(() {
      pivotIndex = high;
      leftIndex = low - 1;
      rightIndex = null;
    });
    await Future.delayed(Duration(seconds: 1));
    await _pauseIfNeeded();

    int pivot = array[high];
    int i = low - 1;

    for (int j = low; j < high; j++) {
      setState(() {
        leftIndex = i;
        rightIndex = j;
      });
      await Future.delayed(Duration(seconds: 1));
      await _pauseIfNeeded();

      if (array[j] <= pivot) {
        i++;
        // Swap
        int temp = array[i];
        array[i] = array[j];
        array[j] = temp;
        HapticFeedback.mediumImpact();
        setState(() {});
        await Future.delayed(Duration(seconds: 1));
        await _pauseIfNeeded();
      }
    }
    // Swap pivot
    int temp = array[i + 1];
    array[i + 1] = array[high];
    array[high] = temp;
    HapticFeedback.heavyImpact();
    setState(() {
      pivotIndex = i + 1;
      leftIndex = null;
      rightIndex = null;
    });
    await Future.delayed(Duration(seconds: 1));
    await _pauseIfNeeded();

    return i + 1;
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
              if (i == pivotIndex) {
                color = Colors.green;
              } else if (i == rightIndex) color = Colors.green.shade600;
              else if (i == leftIndex) color = Colors.green.shade800;
              else if (array[i] != null) color = Color(0xFF255f38);

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
                Essentials()
                    .buildHighlightedCodeLinesWithoutLineNumbers(
                    'qsort(arr, 5, sizeof(int), comp);'),
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
                    isAnimating && !isPaused ? AppLocalizations.of(context)!.pause_animation_button_text : AppLocalizations.of(context)!.play_animation_button_text,
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
