import 'package:flutter/material.dart';

class AnimatedEnqueueWidget extends StatefulWidget {
  @override
  _AnimatedEnqueueWidgetState createState() => _AnimatedEnqueueWidgetState();
}

class _AnimatedEnqueueWidgetState extends State<AnimatedEnqueueWidget> with TickerProviderStateMixin {
  List<int> queue = [3, 5]; // Alapértelmezett 2 elem
  final int capacity = 5;
  final List<int> values = [8, 1, 7, 2, 9];
  int index = 0;
  int front = 0;
  int rear = 1;

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  void _enqueue() {
    if (queue.length >= capacity) return;

    setState(() {
      queue.add(values[index % values.length]);
      rear = (rear + 1) % capacity;
      index++;
    });

    _controller.forward(from: 0); // újraindítjuk az animációt
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
              color: isActive ? Color(0xFFDFAEE8) : Colors.grey.shade300,
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(5),
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
            border: Border.all(color: Colors.black, width: 1),
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
          'Front: $front  |  Rear: ${queue.isEmpty ? -1 : rear}  |  Capacity: $capacity',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 20),

        // Enqueue button with next value
        ElevatedButton(
          onPressed: isFull ? null : _enqueue,
          child: Text('enqueue($nextValue)'),
        ),
      ],
    );
  }
}
