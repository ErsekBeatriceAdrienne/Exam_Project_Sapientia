import 'dart:async';
import 'package:flutter/material.dart';

class LinkedListAnimation extends StatefulWidget {
  @override
  _LinkedListAnimationState createState() => _LinkedListAnimationState();
}

class _LinkedListAnimationState extends State<LinkedListAnimation> {
  List<int> nodes = [];
  int currentIndex = 0;
  final List<int> values = [10, 20, 30, 40, 50];

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (currentIndex < values.length) {
        setState(() {
          nodes.add(values[currentIndex]);
          currentIndex++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            width: constraints.maxWidth,
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: nodes.asMap().entries.map((entry) {
                int index = entry.key;
                int value = entry.value;
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildNode(value),
                    if (index < nodes.length - 1) _buildArrow(),
                  ],
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNode(int value) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: 30,
      height: 30,
      margin: EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: Color(0xFFDFAEE8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white, width: 2),
      ),
      alignment: Alignment.center,
      child: Text(
        value.toString(),
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _buildArrow() {
    return Icon(Icons.arrow_right_alt, color: Colors.black, size: 24);
  }
}
