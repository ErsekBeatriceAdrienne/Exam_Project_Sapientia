import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedQueueWidget extends StatefulWidget {
  @override
  _AnimatedQueueWidgetState createState() => _AnimatedQueueWidgetState();
}

class _AnimatedQueueWidgetState extends State<AnimatedQueueWidget>
{
  List<int> queue = [];
  final int capacity = 5;
  final List<int> values = [3, 5, 8, 1, 7];
  int index = 0;
  int front = -1;
  int rear = -1;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    Timer.periodic(Duration(milliseconds: 800), (timer) {
      if (queue.length < capacity) {
        setState(() {
          queue.add(values[index % values.length]);
          if (front == -1) front = 0; // Set front when the first element is added
          rear = (rear + 1) % capacity;
          index++;
        });
      }

      if (queue.length == capacity) {
        timer.cancel();
        Future.delayed(Duration(seconds: 1), () {
          Timer.periodic(Duration(milliseconds: 900), (removeTimer) {
            if (queue.isNotEmpty) {
              setState(() {
                queue.removeAt(0);
                if (queue.isEmpty) {
                  front = -1;
                  rear = -1;
                } else {
                  front = (front + 1) % capacity;
                }
              });
            } else {
              removeTimer.cancel();
              Future.delayed(Duration(seconds: 1), () {
                setState(() {
                  index = 0;
                  front = -1;
                  rear = -1;
                });
                _startAnimation();
              });
            }
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Queue container
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
            mainAxisAlignment: MainAxisAlignment.start, // FIFO
            children: List.generate(
              capacity,
                  (i) => Container(
                width: 50,
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: i < queue.length ? Color(0xFFDFAEE8) : Colors.grey.shade300,
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                alignment: Alignment.center,
                child: Text(
                  i < queue.length ? queue[i].toString() : '',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 10),

        // Front and Rear positions
        Text(
          'Front: ${front == -1 ? "-1" : front}  |  Rear: ${rear == -1 ? "-1" : rear}  |  Capacity: 5',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
