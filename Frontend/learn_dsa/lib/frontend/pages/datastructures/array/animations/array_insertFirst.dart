import 'dart:async';
import 'package:flutter/material.dart';

class ArrayInsertFirstWidget extends StatefulWidget {
  @override
  _ArrayInsertFirstWidgetState createState() => _ArrayInsertFirstWidgetState();
}

class _ArrayInsertFirstWidgetState extends State<ArrayInsertFirstWidget> {
  List<int?> array = [];
  int size = 3;
  final int capacity = 5;
  bool showArray = true;
  bool hasInsertedOne = false; // Új változó a duplikáció elkerüléséhez

  @override
  void initState() {
    super.initState();
    array = [3, 5, 8, null, null];
  }

  void _insertFirst(int value) {
    if (size >= capacity || hasInsertedOne) return;

    hasInsertedOne = true; // beszúrás megkezdésekor rögtön letiltjuk újrahasználatot

    int steps = size;
    Timer.periodic(Duration(milliseconds: 150), (timer) {
      if (steps == 0) {
        setState(() {
          array[0] = value;
          size++;
        });
        timer.cancel();
      } else {
        setState(() {
          array[steps] = array[steps - 1];
        });
        steps--;
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
                  color: array[i] != null ? Color(0xFFDFAEE8) : Colors.grey.shade300,
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  array[i]?.toString() ?? '',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: hasInsertedOne ? null : () => _insertFirst(1),
                child: Text('insertFirst(1)'),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
