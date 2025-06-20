import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AnimatedEnqueueWidget extends StatefulWidget {
  @override
  _AnimatedEnqueueWidgetState createState() => _AnimatedEnqueueWidgetState();
}

class _AnimatedEnqueueWidgetState extends State<AnimatedEnqueueWidget> with TickerProviderStateMixin {
  List<int> queue = [3, 5];
  final int capacity = 5;
  final List<int> values = [8, 1, 7, 2, 9];
  int index = 0;
  int front = 0;
  int rear = 1;

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  void _enqueue() {
    if (queue.length >= capacity) {
      setState(() {
        queue.clear();
        index = 0;
        front = -1;
        rear = -1;
      });

      _controller.forward(from: 0);
      return;
    }

    setState(() {
      queue.add(values[index % values.length]);

      if (queue.length == 1) {
        front = 0;
      }

      rear = (rear + 1) % capacity;
      index++;
    });

    _controller.forward(from: 0);
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildQueueBox(int i) {
    bool isActive = i < queue.length;
    bool isLast = i == queue.length - 1;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double scale = (isLast && _controller.isAnimating) ? _scaleAnimation.value : 1.0;

        return Transform.scale(
          scale: scale,
          child: Container(
            width: 50,
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              color: isActive ? Color(0xFF255f38) : Colors.grey.shade300,
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
    int nextValue = values[index % values.length];
    bool isFull = queue.length >= capacity;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Queue visualization
        Container(
          width: 300,
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(
              capacity,
                  (i) => _buildQueueBox(i),
            ),
          ),
        ),

        SizedBox(height: 10),

        // Front/Rear info
        Text(
          '${AppLocalizations.of(context)!.front_text}: ${front == -1 ? "-1" : front} | ${AppLocalizations.of(context)!.rear_text}: ${rear == -1 ? "-1" : rear} | ${AppLocalizations.of(context)!.capacity_text}: 5',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 20),

        // Enqueue button with next value
        Container(
          width: AppLocalizations.of(context)!.play_animation_button_text.length * 12 + 20,
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
              _enqueue();
              HapticFeedback.mediumImpact();
            },
            child: queue.length >= capacity
                ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.play_arrow_rounded, color: Theme.of(context).scaffoldBackgroundColor),
                SizedBox(width: 6),
                Text(
                  AppLocalizations.of(context)!.start_exercise_button_text,
                  style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
                : Text(
              'enqueue($nextValue)',
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
