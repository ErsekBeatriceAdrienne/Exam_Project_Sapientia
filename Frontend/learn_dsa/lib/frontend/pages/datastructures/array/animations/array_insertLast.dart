import 'dart:async';
import 'package:flutter/material.dart';

class ArrayInsertLastWidget extends StatefulWidget {
  @override
  _ArrayInsertLastWidgetState createState() => _ArrayInsertLastWidgetState();
}

class _ArrayInsertLastWidgetState extends State<ArrayInsertLastWidget> {
  List<int?> array = [];
  int size = 3;
  final int capacity = 5;
  bool showArray = true;

  @override
  void initState() {
    super.initState();
    array = [3, 5, 8, null, null];
  }

  void _insertAt(int index, int value) {
    if (size >= capacity || index < 0 || index > size) return;

    int steps = size;
    Timer.periodic(Duration(milliseconds: 150), (timer) {
      if (steps == index) {
        setState(() {
          array[index] = value;
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

  void _insertLast(int value) {
    if (size >= capacity) return;

    setState(() {
      array[size] = value;
      size++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
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
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),

            Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  width: capacity * 54.0,
                  height: 2,
                  color: Colors.grey,
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: size * 54.0,
                  height: 2,
                  color: Colors.black,
                ),
              ],
            ),

            SizedBox(height: 5),

            Text(
              'Size: $size     |     Capacity: $capacity',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 15),

            ElevatedButton(
              onPressed: () => _insertLast(9),
              child: Text('insertLast(9)'),
            ),
          ],
        ],
      ),
    );
  }

}
