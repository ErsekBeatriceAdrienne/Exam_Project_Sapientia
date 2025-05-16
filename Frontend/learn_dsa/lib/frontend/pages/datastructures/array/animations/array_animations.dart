import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AnimatedArrayWidget extends StatefulWidget {
  @override
  _AnimatedArrayWidgetState createState() => _AnimatedArrayWidgetState();
}

class _AnimatedArrayWidgetState extends State<AnimatedArrayWidget> {
  List<int?> array = List.filled(5, null);
  int size = 0;
  final int capacity = 5;
  final List<int> values = [3, 5, 8, 4, 2];
  int index = 0;
  bool isAnimating = false;
  bool isPaused = false;

  void _startOrToggleAnimation() {
    if (!isAnimating) {
      // Reset everything and start fresh
      setState(() {
        array = List.filled(capacity, null);
        size = 0;
        index = 0;
        isAnimating = true;
        isPaused = false;
      });
      _runAnimationStep();
    } else {
      // Pause or resume
      setState(() {
        isPaused = !isPaused;
      });
      if (!isPaused) {
        _runAnimationStep();
      }
    }
  }

  void _runAnimationStep() async {
    if (!isAnimating || isPaused || index >= values.length) return;

    await Future.delayed(Duration(seconds: 1));
    HapticFeedback.heavyImpact();
    if (!isAnimating || isPaused) return;

    setState(() {
      array[index] = values[index];
      size++;
      index++;
    });

    if (index < values.length) {
      _runAnimationStep(); // Continue the animation
    } else {
      setState(() {
        isAnimating = false;
        isPaused = false;
      });
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
            '${AppLocalizations.of(context)!.size_text}: $size | ${AppLocalizations.of(context)!.capacity_text}: $capacity',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 10),

          // Play button
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

          /*Container(
            width: 70,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 4,
                  offset: Offset(0, 1),
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
              constraints: const BoxConstraints.tightFor(width: 90, height: 40),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isAnimating
                          ? (isPaused ? Icons.play_arrow_rounded : Icons.pause)
                          : Icons.play_arrow_rounded,
                      color: Color(0xFF27391c),
                      size: 24,
                    ),
                    Text(
                      isAnimating && !isPaused ? 'Pause' : 'Play',
                      style: const TextStyle(
                        color: Color(0xFF27391c),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),*/

        ],
      ),
    );
  }
}

/*
Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 4,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: RawMaterialButton(
              onPressed: _startOrToggleAnimation,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              constraints: const BoxConstraints.tightFor(width: 45, height: 45),
              child: Icon(
                isAnimating
                    ? (isPaused ? Icons.play_arrow_rounded : Icons.pause)
                    : Icons.play_arrow_rounded,
                color:  Color(0xFF27391c),
                size: 30,
              ),
            ),
          ),
 */
