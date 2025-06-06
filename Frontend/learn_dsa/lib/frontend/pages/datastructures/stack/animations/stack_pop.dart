import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AnimatedStackPopWidget extends StatefulWidget {
  const AnimatedStackPopWidget({super.key});

  @override
  _AnimatedStackPopWidgetState createState() => _AnimatedStackPopWidgetState();
}

class _AnimatedStackPopWidgetState extends State<AnimatedStackPopWidget> {
  List<int> stack = [];
  final int capacity = 5;
  final List<int> values = [3, 5, 8, 6, 9];
  int index = 0;
  int top = -1;

  @override
  void initState() {
    super.initState();
    setState(() {
      stack = values.sublist(0, 4);
      index = 4;
      top = stack.length - 1;
    });
  }

  void _popElement() {
    if (stack.isNotEmpty) {
      setState(() {
        HapticFeedback.mediumImpact();
        stack.removeLast();
        top--;
      });
    }
  }

  String _getNextButtonText() {
    if (stack.isNotEmpty) {
      return 'pop(s, ${stack.last})';
    } else {
      return AppLocalizations.of(context)!.start_exercise_button_text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Stack container
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
                  color: i < stack.length ? Color(0xFF255f38) : Colors.grey.shade300,
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
          width: 120 + 20,
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
              if (stack.isNotEmpty) {
                _popElement();
              } else {
                // Reset stack to initial state
                setState(() {
                  stack = values.sublist(0, 4);
                  index = 4;
                  top = stack.length - 1;
                });
                HapticFeedback.mediumImpact();
              }
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
