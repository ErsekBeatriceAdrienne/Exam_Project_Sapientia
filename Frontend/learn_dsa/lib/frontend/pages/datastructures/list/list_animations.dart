import 'dart:async';
import 'package:flutter/material.dart';

class LinkedListAnimation extends StatefulWidget {
  @override
  _LinkedListAnimationState createState() => _LinkedListAnimationState();
}

class _LinkedListAnimationState extends State<LinkedListAnimation> {
  List<int> nodes = [];
  int currentIndex = 0;
  final List<int> values = [30, 10, 50, 40, 20];

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
        double nodeSize = constraints.maxWidth / 10;
        nodeSize = nodeSize.clamp(25.0, 60.0);

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: nodes.asMap().entries.map((entry) {
                int index = entry.key;
                int value = entry.value;
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildNode(value, nodeSize),
                    if (index < nodes.length - 1)
                      _buildArrow(nodeSize)
                    else
                      _buildNullPointer(nodeSize),
                  ],
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNode(int value, double size) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Color(0xFFDFAEE8),
        borderRadius: BorderRadius.circular(size * 0.2),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(2, 2),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        value.toString(),
        style: TextStyle(
          fontSize: size * 0.4,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildArrow(double size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Icon(
        Icons.arrow_right_alt,
        color: Colors.black,
        size: size * 0.6,
      ),
    );
  }

  Widget _buildNullPointer(double size) {
    return Row(
      children: [
        SizedBox(width: size * 0.2),
        Container(width: size * 0.4, height: 3, color: Colors.black),
        Container(
          width: 3,
          height: size * 0.4,
          color: Colors.black,
          margin: EdgeInsets.only(left: 2),
        ),
        SizedBox(width: size * 0.1),
        Text(
          'NULL',
          style: TextStyle(
            fontSize: size * 0.25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}




//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// DOUBLY LINKED LIST


class DoublyLinkedListAnimation extends StatefulWidget {
  @override
  _DoublyLinkedListAnimationState createState() => _DoublyLinkedListAnimationState();
}

class _DoublyLinkedListAnimationState extends State<DoublyLinkedListAnimation> {
  List<int> nodes = [];
  int currentIndex = 0;
  final List<int> values = [30, 10, 50, 40, 20];

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
        double nodeSize = constraints.maxWidth / 10;
        nodeSize = nodeSize.clamp(25.0, 60.0);

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: nodes.asMap().entries.map((entry) {
                int index = entry.key;
                int value = entry.value;
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (index > 0) _buildDoubleArrow(nodeSize),
                    if (index == 0) _buildLeftNullPointer(nodeSize),
                    _buildNode(value, nodeSize),
                    if (index == nodes.length - 1) _buildNullPointer(nodeSize),
                  ],
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNode(int value, double size) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Color(0xFFDFAEE8),
        borderRadius: BorderRadius.circular(size * 0.2),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(2, 2),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        value.toString(),
        style: TextStyle(
          fontSize: size * 0.4,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildDoubleArrow(double size) {
    double arrowSize = size * 0.6;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(3.1416),
          child: Icon(
            Icons.arrow_right_alt,
            color: Colors.black,
            size: arrowSize,
          ),
        ),
        Icon(
          Icons.arrow_right_alt,
          color: Colors.black,
          size: arrowSize,
        ),
      ],
    );
  }

  Widget _buildNullPointer(double size) {
    return Row(
      children: [
        SizedBox(width: size * 0.2),
        Container(width: size * 0.4, height: 3, color: Colors.black),
        Container(
          width: 3,
          height: size * 0.4,
          color: Colors.black,
          margin: EdgeInsets.only(left: 2),
        ),
        SizedBox(width: size * 0.1),
        Text(
          'NULL',
          style: TextStyle(
            fontSize: size * 0.25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildLeftNullPointer(double size) {
    return Row(
      children: [
        Text(
          'NULL',
          style: TextStyle(
            fontSize: size * 0.25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(width: size * 0.1),
        Container(
          width: 3,
          height: size * 0.4,
          color: Colors.black,
          margin: EdgeInsets.only(right: 2),
        ),
        Container(width: size * 0.4, height: 3, color: Colors.black),
        SizedBox(width: size * 0.2),
      ],
    );
  }

}






