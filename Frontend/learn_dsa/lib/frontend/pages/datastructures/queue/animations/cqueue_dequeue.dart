import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedCircularQueueDequeueWidget extends StatefulWidget {
  @override
  _AnimatedCircularQueueDequeueWidgetState createState() => _AnimatedCircularQueueDequeueWidgetState();
}

class _AnimatedCircularQueueDequeueWidgetState extends State<AnimatedCircularQueueDequeueWidget> {
  final int capacity = 5;
  final List<int> values = [3, 5, 8, 1, 7];
  List<int?> queue = List.filled(5, null);
  int front = -1;
  int rear = -1;
  int index = 0;
  int dequeueCount = 0;

  @override
  void initState() {
    super.initState();
    _fillQueueInitially();
  }

  void _fillQueueInitially() {
    for (int i = 0; i < capacity; i++) {
      _enqueue(values[i % values.length]);
      index++;
    }
  }

  void _startAnimation() {
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      if (!_isFull()) {
        _enqueue(values[index % values.length]);
        index++;
      } else {
        timer.cancel();
        Future.delayed(Duration(seconds: 1), () {
          // Remove 2 elements but leave nulls in place
          Timer.periodic(Duration(milliseconds: 1000), (removeTimer) {
            if (dequeueCount < 1 && !_isEmpty()) {
              _dequeue();
              dequeueCount++;
            } else {
              removeTimer.cancel();
            }
          });
        });
      }
    });
  }

  bool _isFull() {
    return (front == (rear + 1) % capacity);
  }

  bool _isEmpty() {
    return front == -1;
  }

  void _enqueue(int value) {
    if (_isFull()) return;

    setState(() {
      if (_isEmpty()) {
        front = rear = 0;
      } else {
        rear = (rear + 1) % capacity;
      }
      queue[rear] = value;
    });
  }

  void _dequeue() {
    if (_isEmpty()) return;

    setState(() {
      queue[front] = null;

      if (front == rear) {
        front = rear = -1;
      } else {
        // move front forward
        do {
          front = (front + 1) % capacity;
        } while (queue[front] == null && front != rear);
        // extra check: if all are null
        if (queue[front] == null) {
          front = -1;
          rear = -1;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Queue display
        Container(
          width: 320,
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(capacity, (i) {
              Color cellColor = queue[i] != null
                  ? Color(0xFFDFAEE8)
                  : Colors.grey.shade300;

              // Highlight front & rear
              if (i == front && front != -1) cellColor = Color(0xFFDFAEE8);
              if (i == rear && rear != -1) cellColor = Color(0xFFDFAEE8);
              if (i == front && i == rear && front != -1) {
                cellColor = Color(0xFFDFAEE8);
              }

              return Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: cellColor,
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                alignment: Alignment.center,
                child: Text(
                  queue[i]?.toString() ?? '',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              );
            }),
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Front: ${front == -1 ? "-1" : front}  |  Rear: ${rear == -1 ? "-1" : rear}  |  Capacity: $capacity',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: _dequeue,
          child: Text('dequeue(q)'),
        ),
      ],
    );
  }
}
