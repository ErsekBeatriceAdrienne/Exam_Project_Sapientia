import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AnimatedArrayGetItemWidget extends StatefulWidget {
  @override
  _AnimatedArrayGetItemWidgetState createState() => _AnimatedArrayGetItemWidgetState();
}

class _AnimatedArrayGetItemWidgetState extends State<AnimatedArrayGetItemWidget> {
  List<int?> array = List.filled(5, null);
  int size = 0;
  final int capacity = 5;
  final List<int> values = [3, 5, 8, 4, 2];
  int index = 0;
  bool isAnimating = false;
  bool isPaused = false;

  void _startOrToggleAnimation() {
    if (!isAnimating) {
      // Start from scratch
      setState(() {
        array = List.filled(capacity, null);
        size = 0;
        index = 0;
        isAnimating = true;
        isPaused = false;
      });
      _runAnimationStep();
    } else {
      // Pause/resume
      setState(() {
        isPaused = !isPaused;
      });
      if (!isPaused) {
        _runAnimationStep();
      }
    }
  }

  void _runAnimationStep() async {
    if (!isAnimating || isPaused || index > 4) return;

    await Future.delayed(Duration(seconds: 1));
    HapticFeedback.mediumImpact();
    if (!isAnimating || isPaused) return;

    setState(() {
      array[index] = values[index];
      size++;
      index++;
    });

    if (index == 4) {
      setState(() {
        isAnimating = false;
      });
    }
    else {
      _runAnimationStep();
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
                    color: isHighlighted ? Color(0xFF1f7d53) : Color(0xFF255f38),
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
                    values[i].toString(),
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

          // Size / Capacity Display
          Text(
            '${AppLocalizations.of(context)!.size_text}: $size | ${AppLocalizations.of(context)!.capacity_text}: $capacity',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'getItemAt(a, 3) = ${values[3]}',
              style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1f7d53)),
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
                _startOrToggleAnimation();
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
                      isAnimating
                          ? (isPaused ? Icons.play_arrow_rounded : Icons.pause)
                          : Icons.play_arrow_rounded,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      size: 24,
                    ),
                    Text(
                      isAnimating && !isPaused ? AppLocalizations.of(context)!.pause_animation_button_text : AppLocalizations.of(context)!.play_animation_button_text,
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
      ),
    );
  }
}
