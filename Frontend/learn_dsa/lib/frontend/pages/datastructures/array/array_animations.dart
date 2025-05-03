import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedArrayWidget extends StatefulWidget
{
  @override
  _AnimatedArrayWidgetState createState() => _AnimatedArrayWidgetState();
}

class _AnimatedArrayWidgetState extends State<AnimatedArrayWidget> {
  List<int?> array = List.filled(5, null);
  int size = 0;
  final int capacity = 5;
  final List<int> values = [3, 5, 8];
  int index = 0;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (index < values.length) {
        setState(() {
          array[index] = values[index];
          size++;
          index++;
        });
      } else {
        // Reset animation after filling the array
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            array = List.filled(capacity, null); // Clear array
            size = 0; // Reset size
            index = 0; // Restart index
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Array Representation with Borders
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              capacity,
                  (i) =>
                  Container(
                    width: 50,
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 1),
                    decoration: BoxDecoration(
                      color: array[i] != null ? Color(0xFF9dc183) : Colors.grey
                          .shade300,
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      array[i]?.toString() ?? '',
                      style: TextStyle(fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
            ),
          ),

          SizedBox(height: 10),

          // Size Arrow + Text
          Stack(
            children: [
              // Capacity Line (Fixed)
              Container(
                width: capacity * 54.0,
                height: 2,
                color: Colors.grey,
              ),

              // Size Line (Animated)
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                width: size * 54.0,
                height: 2,
                color: Colors.black,
              ),
            ],
          ),

          SizedBox(height: 5),

          // Capacity Label
          Text(
            'Size: $size     |     Capacity: $capacity',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}