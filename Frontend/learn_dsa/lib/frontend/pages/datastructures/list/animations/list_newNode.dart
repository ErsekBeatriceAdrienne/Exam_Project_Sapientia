import 'package:flutter/material.dart';

class LinkedListNewNodeAnimation extends StatefulWidget {
  @override
  _LinkedListNewNodeAnimationState createState() => _LinkedListNewNodeAnimationState();
}

class _LinkedListNewNodeAnimationState extends State<LinkedListNewNodeAnimation> {
  List<int> nodes = [];
  int currentIndex = 0;
  final List<int> values = [10];

  void _addNextNode() {
    if (currentIndex < values.length) {
      setState(() {
        nodes.add(values[currentIndex]);
        currentIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double nodeSize = constraints.maxWidth / 8;
        nodeSize = nodeSize.clamp(25.0, 60.0);
        double fontSize = nodeSize * 0.4;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: EdgeInsets.all(16),
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
                        _buildNode(value, nodeSize, fontSize),
                        if (nodes.length == 1 || index != nodes.length - 1)
                          _buildNullPointer(nodeSize),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: _addNextNode,
              child: Text('newNode(10)'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildNode(int value, double size, double fontSize) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Color(0xFFDFAEE8),
        borderRadius: BorderRadius.circular(size * 0.35),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(4, 4),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        value.toString(),
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildNullPointer(double nodeSize) {
    return Row(
      children: [
        SizedBox(width: nodeSize * 0.15),
        Container(width: nodeSize * 0.4, height: 4, color: Colors.black),
        Container(
          width: 4,
          height: nodeSize * 0.4,
          color: Colors.black,
          margin: EdgeInsets.only(left: 2),
        ),
        SizedBox(width: nodeSize * 0.1),
        Text(
          'NULL',
          style: TextStyle(
            fontSize: nodeSize * 0.25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}



//----------------------------------------------------------------------------------------------------------------------------------

class DoublyLinkedListNewNodeAnimation extends StatefulWidget {
  @override
  _DoublyLinkedListNewNodeAnimationState createState() => _DoublyLinkedListNewNodeAnimationState();
}

class _DoublyLinkedListNewNodeAnimationState extends State<DoublyLinkedListNewNodeAnimation> {
  List<int> nodes = [];
  int currentIndex = 0;
  final List<int> values = [10];

  void _addNextNode() {
    if (currentIndex < values.length) {
      setState(() {
        nodes.add(values[currentIndex]);
        currentIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double nodeSize = constraints.maxWidth / 8;
        nodeSize = nodeSize.clamp(25.0, 60.0);
        double fontSize = nodeSize * 0.4;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: EdgeInsets.all(16),
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
                        if (index == 0) _buildLeftNullPointer(nodeSize), // BALRA NULL az elsőnél
                        _buildNode(value, nodeSize, fontSize),
                        if (index == 0) _buildNullPointer(nodeSize), // közte dupla nyíl
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: _addNextNode,
              child: Text('newNode(10)'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildNode(int value, double size, double fontSize) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Color(0xFFDFAEE8),
        borderRadius: BorderRadius.circular(size * 0.35),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(4, 4),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        value.toString(),
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildLeftNullPointer(double nodeSize) {
    return Row(
      children: [
        Text(
          'NULL',
          style: TextStyle(
            fontSize: nodeSize * 0.25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(width: nodeSize * 0.1),
        Container(
          width: 4,
          height: nodeSize * 0.4,
          color: Colors.black,
          margin: EdgeInsets.only(right: 2),
        ),
        Container(width: nodeSize * 0.4, height: 4, color: Colors.black),
        SizedBox(width: nodeSize * 0.15),
      ],
    );
  }

  Widget _buildNullPointer(double nodeSize) {
    return Row(
      children: [
        SizedBox(width: nodeSize * 0.15),
        Container(width: nodeSize * 0.4, height: 4, color: Colors.black),
        Container(
          width: 4,
          height: nodeSize * 0.4,
          color: Colors.black,
          margin: EdgeInsets.only(left: 2),
        ),
        SizedBox(width: nodeSize * 0.1),
        Text(
          'NULL',
          style: TextStyle(
            fontSize: nodeSize * 0.25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
