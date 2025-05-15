import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AnimatedQueuePeek extends StatefulWidget {
  @override
  _AnimatedQueuePeekState createState() => _AnimatedQueuePeekState();
}

class _AnimatedQueuePeekState extends State<AnimatedQueuePeek> with SingleTickerProviderStateMixin {
  final List<int> queue = [8, 1, 7, 2, 9];
  final int capacity = 5;
  int index = 0;
  int front = 0;
  int rear = 4;
  int currentIndex = 0;
  bool isAnimating = false;
  bool isPaused = false;
  bool isPeeking = false;
  int? peekIndex;
  String? peekMessage;

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

  void _peek() async {
    if (queue.isEmpty || isAnimating || isPeeking) return;

    setState(() {
      peekIndex = 0;
      isPeeking = true;
      peekMessage = "return ${queue[0]}";
    });

    await _controller.forward(from: 0);
    await Future.delayed(Duration(milliseconds: 400));

    setState(() {
      isPeeking = false;
      peekIndex = null;
    });

    HapticFeedback.mediumImpact();
  }

  Widget _buildQueueBox(int i) {
    bool isActive = i < queue.length;
    bool isCurrent = (i == currentIndex && isAnimating) || (i == peekIndex && isPeeking);

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

        SizedBox(height: 10),

        if (peekMessage != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              peekMessage!,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),

        SizedBox(height: 12),

        Container(
          width: AppLocalizations.of(context)!.play_animation_button_text.length * 10 + 40,
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
              _peek();
              HapticFeedback.mediumImpact();
            },
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.play_arrow_rounded, color: Theme.of(context).scaffoldBackgroundColor, size: 22),
                SizedBox(width: 6),
                Text(
                  AppLocalizations.of(context)!.play_animation_button_text,
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
