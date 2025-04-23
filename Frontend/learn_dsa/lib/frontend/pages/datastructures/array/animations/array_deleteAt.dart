import 'dart:async';
import 'package:flutter/material.dart';

class ArrayDeleteAtWidget extends StatefulWidget {
  @override
  _ArrayDeleteAtWidgetState createState() => _ArrayDeleteAtWidgetState();
}

class _ArrayDeleteAtWidgetState extends State<ArrayDeleteAtWidget> {
  List<int?> array = [];
  int size = 3;
  final int capacity = 5;
  bool showArray = true;

  @override
  void initState() {
    super.initState();
    array = [3, 5, 8, null, null];
  }

  void _deleteAt(int index) {
    if (index < 0 || index >= size) return;

    int steps = index;
    Timer.periodic(Duration(milliseconds: 150), (timer) {
      if (steps == size - 1) {
        setState(() {
          array[steps] = null;
          size--;
        });
        timer.cancel();
      } else {
        setState(() {
          array[steps] = array[steps + 1];
        });
        steps++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showArray) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              capacity,
                  (i) => AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: 50,
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 1),
                decoration: BoxDecoration(
                  color: array[i] != null
                      ? Color(0xFFDFAEE8)
                      : Colors.grey.shade300,
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  array[i]?.toString() ?? '',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),

          SizedBox(height: 10),

          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 30),
                  Container(
                    width: capacity * 54.0,
                    height: 2,
                    color: Colors.grey,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 30),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    width: size * 54.0,
                    height: 2,
                    color: Colors.black,
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 5),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 30 + (capacity * 54.0) / 2 - 60),
              Text(
                'Size: $size     |     Capacity: $capacity',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          SizedBox(height: 15),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _deleteAt(1),
                child: Text('deleteAt(1)'),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
