import 'package:flutter/material.dart';

class AnimatedStackPopWidget extends StatefulWidget {
  @override
  _AnimatedStackPopWidgetState createState() => _AnimatedStackPopWidgetState();
}

class _AnimatedStackPopWidgetState extends State<AnimatedStackPopWidget> {
  List<int> stack = [];
  final int capacity = 5;
  final List<int> values = [3, 5, 8, 6, 9]; // Összes pusholható elem
  int index = 0;
  int top = -1;

  @override
  void initState() {
    super.initState();
    // Alapból betöltünk 4 elemet a stack-be
    setState(() {
      stack = values.sublist(0, 4); // [3, 5, 8, 6]
      index = 4; // következő push: values[4]
      top = stack.length - 1; // top = 3
    });
  }

  void _pushNextElement() {
    if (index < values.length && stack.length < capacity) {
      setState(() {
        stack.add(values[index]);
        top++;
        index++;
      });
    }
  }

  void _popElement() {
    if (stack.isNotEmpty) {
      setState(() {
        stack.removeLast();
        top--;
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
        // Stack container
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

        // Buttons Row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: stack.isNotEmpty ? _popElement : null,
              child: Text('Pop'),
            ),
          ],
        ),
      ],
    );
  }
}
