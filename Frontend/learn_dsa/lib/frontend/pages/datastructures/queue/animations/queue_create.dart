import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedQueueCreateWidget extends StatefulWidget {
  @override
  _AnimatedQueueCreateWidgetState createState() => _AnimatedQueueCreateWidgetState();
}

class _AnimatedQueueCreateWidgetState extends State<AnimatedQueueCreateWidget> {
  List<int> queue = [];
  final int capacity = 5;
  final List<int> values = [3, 5, 8, 1, 7];
  int index = 0;
  int front = -1;
  int rear = -1;
  bool isRunning = false;
  bool isQueueCreated = false;

  void _createEmptyQueue() {
    setState(() {
      queue.clear();
      index = 0;
      front = -1;
      rear = -1;
      isRunning = false;
      isQueueCreated = true;
    });
  }

  void _startAnimation() {
    if (isRunning || !isQueueCreated) return;
    isRunning = true;

    Timer.periodic(Duration(milliseconds: 800), (timer) {
      if (queue.length < capacity) {
        setState(() {
          queue.add(values[index % values.length]);
          if (front == -1) front = 0;
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
                  queue.clear();
                  isRunning = false;
                  isQueueCreated = false;
                });
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

        // Front/Rear info
        Text(
          'Front: ${front == -1 ? "-1" : front}  |  Rear: ${rear == -1 ? "-1" : rear}  |  Capacity: $capacity',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
