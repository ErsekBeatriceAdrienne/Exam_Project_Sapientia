import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AnimatedArraySearchWidget extends StatefulWidget {
  @override
  _AnimatedArraySearchWidgetState createState() => _AnimatedArraySearchWidgetState();
}

class _AnimatedArraySearchWidgetState extends State<AnimatedArraySearchWidget> {
  final List<int> values = [3, 5, 8, 4, 2];
  int currentIndex = -1;
  int foundIndex = -1;
  bool isSearching = false;
  bool isPaused = false;

  void _startOrToggleSearch() {
    if (!isSearching) {
      setState(() {
        currentIndex = -1;
        foundIndex = -1;
        isSearching = true;
        isPaused = false;
      });
      _runSearchStep();
    } else {
      setState(() {
        isPaused = !isPaused;
      });
      if (!isPaused) {
        _runSearchStep();
      }
    }
  }

  void _runSearchStep() async {
    if (!isSearching || isPaused) return;

    while (currentIndex < values.length - 1 && !isPaused) {
      await Future.delayed(Duration(seconds: 1));
      HapticFeedback.mediumImpact();

      if (!isSearching || isPaused) return;

      setState(() {
        currentIndex++;
        if (values[currentIndex] == 8) {
          foundIndex = currentIndex;
          isSearching = false;
        }
      });

      if (foundIndex != -1) break;
    }

    if (currentIndex >= values.length - 1 && foundIndex == -1) {
      setState(() {
        isSearching = false;
      });
    }
  }

  @override
  void dispose() {
    isSearching = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BorderSide side = BorderSide(color: Colors.white, width: 1.5);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Array display
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              values.length,
                  (i) {
                Color boxColor;
                if (i == foundIndex) {
                  boxColor = Color(0xFF1f7d53);
                } else if (i == currentIndex) {
                  boxColor = Color(0xFF006a42);
                } else {
                  boxColor = Color(0xFF255f38);
                }

                BorderRadius borderRadius;
                if (i == 0)
                  borderRadius = BorderRadius.horizontal(left: Radius.circular(12));
                else if (i == values.length - 1)
                  borderRadius = BorderRadius.horizontal(right: Radius.circular(12));
                else
                  borderRadius = BorderRadius.zero;

                return Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: boxColor,
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

          Text(
            '${AppLocalizations.of(context)!.size_text}: 5 | ${AppLocalizations.of(context)!.capacity_text}: 5',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),

          // Search result
          if (foundIndex != -1)
            Text(
              "Element 8 found at index $foundIndex",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
          else if (!isSearching && currentIndex >= values.length - 1)
            Text(
              "Element 8 not found.",
              style: TextStyle(
                color: Colors.red[800],
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "search(a, 8)",
              style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1f7d53)),
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
              onPressed: () {
                _startOrToggleSearch();
                HapticFeedback.mediumImpact();
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
                    isSearching
                        ? (isPaused ? Icons.play_arrow_rounded : Icons.pause)
                        : Icons.play_arrow_rounded,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    size: 22,
                  ),
                  Text(
                    isSearching && !isPaused ? AppLocalizations.of(context)!.pause_animation_button_text : AppLocalizations.of(context)!.play_animation_button_text,
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
