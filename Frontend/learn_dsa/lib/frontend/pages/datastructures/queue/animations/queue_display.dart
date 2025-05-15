import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AnimatedQueueDisplay extends StatefulWidget {
  @override
  _AnimatedQueueDisplayState createState() => _AnimatedQueueDisplayState();
}

class _AnimatedQueueDisplayState extends State<AnimatedQueueDisplay> with SingleTickerProviderStateMixin {
  final List<int> queue = [8, 1, 7, 2, 9];
  final int capacity = 5;
  int index = 0;
  int front = 0;
  int rear = 4;
  int currentIndex = 0;
  bool isAnimating = false;
  bool isPaused = false;

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startOrToggleAnimation() {
    if (!isAnimating) {
      setState(() {
        currentIndex = 0;
        isAnimating = true;
        isPaused = false;
      });
      _runAnimationStep();
    } else {
      setState(() {
        isPaused = !isPaused;
      });
      if (!isPaused) {
        _runAnimationStep();
      }
    }
  }

  void _runAnimationStep() async {
    if (!isAnimating || isPaused || currentIndex >= queue.length) return;

    await Future.delayed(Duration(seconds: 1));
    HapticFeedback.mediumImpact();

    if (!isAnimating || isPaused) return;

    await _controller.forward(from: 0); // Run animation

    setState(() {
      currentIndex++;
    });

    if (currentIndex < queue.length) {
      _runAnimationStep();
    } else {
      setState(() {
        isAnimating = false;
        isPaused = false;
      });
    }
  }

  Widget _buildQueueBox(int i) {
    bool isActive = i < queue.length;
    bool isCurrent = i == currentIndex;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double scale = (isCurrent && _controller.isAnimating) ? _scaleAnimation.value : 1.0;

        return Transform.scale(
          scale: scale,
          child: Container(
            width: 50,
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              color: isCurrent
                  ? Color(0xFF1f7d53)
                  : (isActive ? Color(0xFF255f38) : Colors.grey.shade300),
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
              isActive ? queue[i].toString() : '',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Queue container with border
        Container(
          width: 300,
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(capacity, (i) => _buildQueueBox(i)),
          ),
        ),

        SizedBox(height: 10),

        // Front/Rear info
        Text(
          '${AppLocalizations.of(context)!.front_text}: ${front == -1 ? "-1" : front} | '
              '${AppLocalizations.of(context)!.rear_text}: ${rear == -1 ? "-1" : rear} | '
              '${AppLocalizations.of(context)!.capacity_text}: 5',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 16),

        if (currentIndex > 0)
          Column(
            children: [
              Text(
                'display(q):',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                '${queue.take(currentIndex).join(', ')}',
                style: TextStyle(
                  color: Color(0xFF006a42),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),

        SizedBox(height: 20),

        // Play / Pause Button
        Container(
          width: AppLocalizations.of(context)!.start_exercise_button_text.length * 12 + 40,
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
                  size: 24,
                ),
                SizedBox(width: 6),
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
      ],
    );
  }
}
