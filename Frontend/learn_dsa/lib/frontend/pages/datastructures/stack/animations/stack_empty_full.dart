import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AnimatedStackIsEmptyWidget extends StatefulWidget {
  @override
  _AnimatedStackIsEmptyWidgetState createState() => _AnimatedStackIsEmptyWidgetState();
}

class _AnimatedStackIsEmptyWidgetState extends State<AnimatedStackIsEmptyWidget> {
  List<int> stack = [4, 9];
  final int capacity = 5;
  bool? isEmptyResult;
  bool isAnimating = false;
  bool isPaused = false;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 70,
          height: 180,
          padding: EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            border: Border.all(color: Colors.black, width: 1),
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
                  color: i < stack.length ? Color(0xFF006a42) : Colors.grey.shade300,
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                alignment: Alignment.center,
                child: Text(
                  i < stack.length ? stack[i].toString() : '',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ).reversed.toList(),
          ),
        ),

        SizedBox(height: 5),

        Text(
          'Top: ${stack.isEmpty ? -1 : stack.length - 1} | ${AppLocalizations.of(context)!.capacity_text}: $capacity',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 8),

        if (isEmptyResult != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'return ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  isEmptyResult.toString(),
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
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
              final result = stack.every((e) => e == null);
              setState(() {
                isEmptyResult = result;
              });
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
    );
  }
}


/// Is full



class AnimatedStackIsFullWidget extends StatefulWidget {
  @override
  _AnimatedStackIsFullWidgetState createState() => _AnimatedStackIsFullWidgetState();
}

class _AnimatedStackIsFullWidgetState extends State<AnimatedStackIsFullWidget> {
  List<int> stack = [];
  final int capacity = 5;
  bool? isEmptyResult;
  bool isAnimating = false;
  bool isPaused = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 70,
          height: 180,
          padding: EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            border: Border.all(color: Colors.black, width: 1),
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
                  color: Colors.grey.shade300,
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                alignment: Alignment.center,
                child: Text(
                  '',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ).reversed.toList(),
          ),
        ),

        SizedBox(height: 5),

        Text(
          'Top: -1 | ${AppLocalizations.of(context)!.capacity_text}: $capacity',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 8),

        if (isEmptyResult != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'return ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  isEmptyResult.toString(),
                  style: TextStyle(
                    color: isEmptyResult! ? Colors.green : Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
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
              final result = stack.every((e) => e == null);
              setState(() {
                isEmptyResult = result;
              });
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
    );
  }
}