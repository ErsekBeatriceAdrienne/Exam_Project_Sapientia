import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AnimatedArrayUpdateWidget extends StatefulWidget {
  @override
  _AnimatedArrayUpdateWidgetState createState() => _AnimatedArrayUpdateWidgetState();
}

class _AnimatedArrayUpdateWidgetState extends State<AnimatedArrayUpdateWidget> {
  final List<int> values = [3, 5, 8, 4, 2];
  int currentIndex = -1;
  int foundIndex = -1;
  bool isUpdating = false;
  bool isPaused = false;

  void _updateElement() async {
    setState(() {
      values[3] = 4;
      currentIndex = -1;
      foundIndex = -1;
      isUpdating = true;
      isPaused = false;
    });

    for (int i = 0; i <= 3; i++) {
      await Future.delayed(Duration(milliseconds: 600));
      HapticFeedback.selectionClick();

      if (!mounted) return;

      setState(() {
        currentIndex = i;
      });
    }

    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      values[3] = 9;
      foundIndex = 3;
      isUpdating = false;
    });
    HapticFeedback.heavyImpact();
  }


  @override
  void dispose() {
    isUpdating = false;
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

          const SizedBox(height: 10),

          Text(
            'Size: 5 | Capacity: 5',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "update(a, 3, 9)",
              style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1f7d53)),
            ),
          ),

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
              onPressed: () {
                _updateElement();
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
                    isUpdating
                        ? (isPaused ? Icons.play_arrow_rounded : Icons.pause)
                        : Icons.play_arrow_rounded,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    size: 22,
                  ),
                  Text(
                    isUpdating && !isPaused ? 'Pause' : 'Play',
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
