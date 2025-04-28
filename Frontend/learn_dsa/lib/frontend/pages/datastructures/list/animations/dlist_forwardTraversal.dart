import 'dart:async';
import 'package:flutter/material.dart';

class DoublyLinkedListForwardTraversalAnimation extends StatefulWidget {
  @override
  _DoublyLinkedListForwardTraversalAnimationState createState() => _DoublyLinkedListForwardTraversalAnimationState();
}

class _DoublyLinkedListForwardTraversalAnimationState extends State<DoublyLinkedListForwardTraversalAnimation> {
  final List<int> values = [30, 10, 50, 40, 20];
  List<int> nodes = [];
  int traversalIndex = -1;
  bool isTraversing = false;
  String traversalOutput = ''; // Kiírás a bejárásról

  @override
  void initState() {
    super.initState();
    nodes = List.from(values); // Lista rögtön megjelenik
  }

  void _startForwardTraversal() {
    if (isTraversing || nodes.isEmpty) return;

    setState(() {
      isTraversing = true;
      traversalIndex = 0;
      traversalOutput = 'Traversal started: ${nodes[0]}'; // Kezdő érték kiírása
    });

    Timer.periodic(Duration(seconds: 1), (timer) {
      if (traversalIndex < nodes.length - 1) {
        setState(() {
          traversalIndex++;
          traversalOutput = 'Traversing: ${nodes[traversalIndex]}'; // Kiíratjuk a lépést
        });
      } else {
        timer.cancel();
        setState(() {
          traversalIndex = -1;
          isTraversing = false;
          traversalOutput = 'Traversal completed.'; // A bejárás vége
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(
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
                          _buildNode(value, nodeSize, index == traversalIndex),
                          if (index == nodes.length - 1) _buildNullPointer(nodeSize),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            traversalOutput, // A bejárás állapota
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        ElevatedButton(
          onPressed: _startForwardTraversal,
          child: Text('forwardTraversal(head)'),
        ),

      ],
    );
  }

  Widget _buildNode(int value, double size, bool isHighlighted) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isHighlighted ? Colors.purple : Color(0xFFDFAEE8),
        borderRadius: BorderRadius.circular(size * 0.2),
        border: Border.all(color: isHighlighted ? Colors.purple.shade200 : Colors.white, width: 3),
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
