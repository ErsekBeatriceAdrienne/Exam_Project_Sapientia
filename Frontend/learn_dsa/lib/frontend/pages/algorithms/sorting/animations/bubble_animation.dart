import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../helpers/essentials.dart';

class BubbleSortAnimationWidget extends StatefulWidget {
  const BubbleSortAnimationWidget({super.key});

  @override
  _BubbleSortAnimationWidgetState createState() => _BubbleSortAnimationWidgetState();
}

class _BubbleSortAnimationWidgetState extends State<BubbleSortAnimationWidget> {
  List<int> array = [64, 34, 25, 12, 22, 11];
  int? currentIndex;
  int? comparingIndex;
  bool isAnimating = false;
  bool isPaused = false;
  Completer<void>? _pauseCompleter;

  void _startOrToggleAnimation() {
    if (!isAnimating) {
      setState(() {
        array = [64, 34, 25, 12, 22, 11];
        currentIndex = null;
        comparingIndex = null;
        isAnimating = true;
        isPaused = false;
      });
      _bubbleSort().then((_) {
        setState(() {
          isAnimating = false;
          currentIndex = null;
          comparingIndex = null;
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

  Future<void> _bubbleSort() async {
    int n = array.length;
    for (int i = 0; i < n - 1; i++) {
      for (int j = 0; j < n - i - 1; j++) {
        setState(() {
          currentIndex = j;
          comparingIndex = j + 1;
        });

        await Future.delayed(Duration(seconds: 1));
        await _pauseIfNeeded();

        if (array[j] > array[j + 1]) {
          // Swap
          int temp = array[j];
          array[j] = array[j + 1];
          array[j + 1] = temp;

          HapticFeedback.mediumImpact();
          setState(() {});
          await Future.delayed(Duration(seconds: 1));
          await _pauseIfNeeded();
        }
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
                color = Colors.green; // éppen vizsgált elem
              } else if (i == comparingIndex) {
                color = Colors.green.shade800; // összehasonlítás alatt álló elem
              } else if (i >= array.length - 1 - (currentIndex ?? 0)) {
                // már rendezett rész (opcionális, csak vizuálisan jelezve)
                color = Colors.green.shade800;
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
                Essentials()
                    .buildHighlightedCodeLinesWithoutLineNumbers(
                    'bubbleSort(arr, ${array.length});'),
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
