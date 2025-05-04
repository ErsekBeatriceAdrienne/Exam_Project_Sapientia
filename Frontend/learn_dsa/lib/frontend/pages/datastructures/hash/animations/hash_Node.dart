import 'package:flutter/material.dart';

class LinkedListNewNodeAnimation extends StatefulWidget {
  @override
  _LinkedListNewNodeAnimationState createState() =>
      _LinkedListNewNodeAnimationState();
}

class _LinkedListNewNodeAnimationState
    extends State<LinkedListNewNodeAnimation> {
  List<MapEntry<int, int>> nodes = [];
  int currentIndex = 0;
  final List<MapEntry<int, int>> values = [MapEntry(0, 23)];

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
        double fontSize = nodeSize * 0.25;

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
                    MapEntry<int, int> pair = entry.value;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildNode(pair, nodeSize, fontSize),
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
              child: Text('Hash_Item item <- createItem(0, 23)\nnewNode(item)'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildNode(MapEntry<int, int> pair, double size, double fontSize) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: 80,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.purple.shade200,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Key
          Positioned(
            left: 0,
            top: 0,
            width: 80 * 0.4 - 1,
            height: 50,
            child: Center(
              child: Text(
                '${pair.key}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Value
          Positioned(
            left: 80 * 0.4 + 1,
            top: 0,
            width: 80 * 0.6 - 1,
            height: 50,
            child: Center(
              child: Text(
                '${pair.value}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // White line
          Positioned(
            left: 80 * 0.4 - 1, // 40%
            top: 50 * 0.15,
            child: Container(
              width: 2,
              height: 50 * 0.7,
              color: Colors.white,
            ),
          ),
        ],
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
