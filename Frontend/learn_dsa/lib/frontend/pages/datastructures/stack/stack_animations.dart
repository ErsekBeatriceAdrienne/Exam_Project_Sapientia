import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AnimatedStackWidget extends StatefulWidget
{
  @override
  _AnimatedStackWidgetState createState() => _AnimatedStackWidgetState();
}

class _AnimatedStackWidgetState extends State<AnimatedStackWidget>
{
  List<int> stack = [];
  final int capacity = 5;
  final List<int> values = [3, 5, 8]; // Elements to be added
  int index = 0;
  int top = -1;
  bool isAnimating = false;
  bool isPaused = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
  }

  void _startOrToggleAnimation() {
    if (!isAnimating) {
      setState(() {
        index = 0;
        top = -1;
        stack.clear();
        isAnimating = true;
        isPaused = false;
      });
      _startAnimation();
    } else {
      setState(() {
        isPaused = !isPaused;
      });

      if (isPaused) {
        _timer?.cancel();
      } else {
        _startAnimation();
      }
    }
  }

  void _startAnimation() {
    _timer?.cancel();

    _timer = Timer.periodic(Duration(milliseconds: 800), (timer) {
      if (!isAnimating || isPaused) {
        timer.cancel();
        return;
      }

      if (index < values.length && stack.length < capacity) {
        setState(() {
          stack.add(values[index]);
          top++;
          index++;
        });
      } else {
        timer.cancel();
        // Restart after a short pause
        Future.delayed(Duration(seconds: 1), () {
          if (isAnimating && !isPaused) {
            setState(() {
              stack.clear();
              index = 0;
              top = -1;
            });
            _startAnimation();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
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
                  color: i < stack.length ? Color(0xFF255f38) : Colors.grey.shade300,
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

        // Stack Info
        Text(
          '${AppLocalizations.of(context)!.top_text} $top | ${AppLocalizations.of(context)!.capacity_text}: $capacity',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
      ],
    );
  }
}
