import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                  ? Color(0xFF255f38)
                  : Colors.grey.shade300;

              // Highlight front & rear
              if (i == front && front != -1) cellColor = Color(0xFF255f38);
              if (i == rear && rear != -1) cellColor = Color(0xFF255f38);
              if (i == front && i == rear && front != -1) cellColor = Color(0xFF255f38);

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
          '${AppLocalizations.of(context)!.front_text}: ${front == -1 ? "-1" : front} | ${AppLocalizations.of(context)!.rear_text}: ${rear == -1 ? "-1" : rear} | ${AppLocalizations.of(context)!.capacity_text}: 5',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),

        Container(
          width: 'dequeue(q)'.length * 10 + 40,
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
              _dequeue();
              HapticFeedback.mediumImpact();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (queue.isEmpty)
                  Icon(
                    Icons.play_arrow_rounded,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                if (queue.isEmpty)
                  SizedBox(width: 6),
                Text(
                  queue.isEmpty ? AppLocalizations.of(context)!.start_exercise_button_text : 'dequeue(q)',
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


