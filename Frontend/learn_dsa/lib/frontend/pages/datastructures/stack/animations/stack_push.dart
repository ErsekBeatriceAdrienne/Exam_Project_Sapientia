import 'package:flutter/material.dart';

class AnimatedStackPushWidget extends StatefulWidget {
  @override
  _AnimatedStackPushWidgetState createState() => _AnimatedStackPushWidgetState();
}

class _AnimatedStackPushWidgetState extends State<AnimatedStackPushWidget> {
  List<int> stack = [];
  final int capacity = 5;
  final List<int> values = [3, 5, 8, 2, 9]; // Elements to be added
  int index = 0;
  int top = -1;

  void _pushNextElement() {
    if (index < values.length && stack.length < capacity) {
      setState(() {
        stack.add(values[index]);
        top++;
        index++;
      });
    }
  }

  String _getNextButtonText() {
    if (index < values.length && stack.length < capacity) {
      return 'Push ${values[index]}';
    } else {
      return 'Stack Full or Done';
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  color: i < stack.length
                      ? Color(0xFFDFAEE8)
                      : Colors.grey.shade300,
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                alignment: Alignment.center,
                child: Text(
                  i < stack.length ? stack[i].toString() : '',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ).reversed.toList(),
          ),
        ),

        SizedBox(height: 5),

        // Stack Info
        Text(
          'Top: $top  |  Capacity: $capacity',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 20),

        ElevatedButton(
          onPressed:
          (index < values.length && stack.length < capacity) ? _pushNextElement : null,
          child: Text(_getNextButtonText()),
        ),
      ],
    );
  }
}
