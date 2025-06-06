import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AnimatedArrayWidget extends StatefulWidget {
  const AnimatedArrayWidget({super.key});

  @override
  _AnimatedArrayWidgetState createState() => _AnimatedArrayWidgetState();
}

class _AnimatedArrayWidgetState extends State<AnimatedArrayWidget> {
  List<int?> array = List.filled(4, null);
  int size = 0;
  final int capacity = 5;
  final List<int> values = [3, 5, 8, 4];
  int index = 0;
  bool isAnimating = false;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    array = List.filled(capacity, null);
    for (int i = 0; i < values.length; i++) {
      array[i] = values[i];
    }
    size = values.length;
    index = values.length;
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

                if (i == 0) {
                  borderRadius = BorderRadius.horizontal(left: Radius.circular(12));
                } else if (i == capacity - 1) {
                  borderRadius =
                      BorderRadius.horizontal(right: Radius.circular(12));
                }
                else {
                  borderRadius = BorderRadius.zero;
                }

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
        ],
      ),
    );
  }
}
