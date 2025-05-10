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
                  color: i < queue.length ? Color(0xFF255f38) : Colors.grey.shade300,
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

// -----------------------------------------------------------------------------------

class AnimatedCircularQueueWidget extends StatefulWidget {
  @override
  _AnimatedCircularQueueWidgetState createState() => _AnimatedCircularQueueWidgetState();
}

class _AnimatedCircularQueueWidgetState extends State<AnimatedCircularQueueWidget> {
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
    _startAnimation();
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
            if (dequeueCount < 2 && !_isEmpty()) {
              _dequeue();
              dequeueCount++;
            } else {
              removeTimer.cancel();
              dequeueCount = 0;

              // Refill 2 elements
              Future.delayed(Duration(seconds: 1), () {
                Timer.periodic(Duration(milliseconds: 1000), (refillTimer) {
                  if (!_isFull() && dequeueCount < 2) {
                    _enqueue(values[index % values.length]);
                    index++;
                    dequeueCount++;
                  } else {
                    refillTimer.cancel();
                    _startAnimation();
                  }
                });
              });
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
                  ? Color(0xFF006a42)
                  : Colors.grey.shade300;

              // Highlight front & rear
              if (i == front && front != -1) cellColor = Color(0xFF006a42);
              if (i == rear && rear != -1) cellColor = Color(0xFF255f38);
              if (i == front && i == rear && front != -1) {
                cellColor = Color(0xFF27391c);
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
      ],
    );
  }
}

/*
class AnimatedCircularQueueWidget extends StatefulWidget {
  @override
  _AnimatedCircularQueueWidgetState createState() => _AnimatedCircularQueueWidgetState();
}

class _AnimatedCircularQueueWidgetState extends State<AnimatedCircularQueueWidget> {
  final int capacity = 5;
  final List<int> values = [3, 5, 8, 1, 7];
  List<int?> queue = List.filled(5, null);
  int front = -1;
  int rear = -1;
  int index = 0;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      if (!_isFull()) {
        _enqueue(values[index % values.length]);
        index++;
      } else {
        timer.cancel();
        Future.delayed(Duration(seconds: 1), () {
          Timer.periodic(Duration(milliseconds: 1000), (removeTimer) {
            if (!_isEmpty()) {
              _dequeue();
            } else {
              removeTimer.cancel();
              Future.delayed(Duration(seconds: 1), () {
                setState(() {
                  queue = List.filled(capacity, null);
                  front = -1;
                  rear = -1;
                  index = 0;
                });
                _startAnimation();
              });
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
    setState(() {
      if (_isFull()) return;

      if (_isEmpty()) {
        front = 0;
        rear = 0;
      } else {
        rear = (rear + 1) % capacity;
      }

      queue[rear] = value;
    });
  }

  void _dequeue() {
    setState(() {
      if (_isEmpty()) return;

      queue[front] = null;

      if (front == rear) {
        // Only one element was in the queue
        front = -1;
        rear = -1;
      } else {
        front = (front + 1) % capacity;
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
              return Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: queue[i] != null ? Color(0xFFDFAEE8) : Colors.grey.shade300,
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

        // Front and Rear indicators
        Text(
          'Front: ${front == -1 ? "-1" : front}  |  Rear: ${rear == -1 ? "-1" : rear}  |  Capacity: $capacity',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}*/