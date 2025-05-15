import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AnimatedStackPushWidget extends StatefulWidget {
  @override
  _AnimatedStackPushWidgetState createState() => _AnimatedStackPushWidgetState();
}

class _AnimatedStackPushWidgetState extends State<AnimatedStackPushWidget> {
  List<int> stack = [];
  final int capacity = 5;
  final List<int> values = [3, 5, 8, 2, 9]; // Elements to be added
  int index = 0;
  int top = -1;

  void _pushNextElement() {
    if (index < values.length && stack.length < capacity) {
      setState(() {
        stack.add(values[index]);
        top++;
        index++;
      });
    }
  }

  String _getNextButtonText() {
    if (index < values.length && stack.length < capacity) {
      return 'push(s, ${values[index]})';
    } else {
      return AppLocalizations.of(context)!.start_exercise_button_text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Stack container (Bucket)
        Container(
          width: 70,
          height: 180,
          padding: EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.vertical(top: Radius.circular(15), bottom: Radius.circular(15)),
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(
              capacity,
                  (i) => Container(
                width: 60,
                height: 30,
                margin: EdgeInsets.symmetric(vertical: 1),
                decoration: BoxDecoration(
                  color: i < stack.length
                      ? Color(0xFF255f38)
                      : Colors.grey.shade300,
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    )
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  i < stack.length ? stack[i].toString() : '',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ).reversed.toList(),
          ),
        ),

        SizedBox(height: 5),

        // Stack Info
        Text(
          '${AppLocalizations.of(context)!.top_text}: $top | ${AppLocalizations.of(context)!.capacity_text}: $capacity',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 20),

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
              if (index < values.length && stack.length < capacity) {
                _pushNextElement();
              } else {
                // Reset the stack when full and button is pressed again
                setState(() {
                  stack.clear();
                  index = 0;
                  top = -1;
                });
              }
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
                  Icons.play_arrow_rounded,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  size: 22,
                ),
                Text(_getNextButtonText(),
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
    );
  }
}
