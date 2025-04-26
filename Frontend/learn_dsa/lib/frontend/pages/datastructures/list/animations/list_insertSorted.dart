import 'package:flutter/material.dart';

class LinkedListInsertSortedNode extends StatefulWidget {
  @override
  State<LinkedListInsertSortedNode> createState() => _LinkedListInsertSortedNodeState();
}

class _LinkedListInsertSortedNodeState extends State<LinkedListInsertSortedNode> {
  List<int> nodes = [20, 30, 50];
  bool isInserting = false;

  void _insertSorted(int newValue) async {
    if (isInserting) return;

    setState(() {
      isInserting = true;
    });

    await Future.delayed(Duration(milliseconds: 800));

    setState(() {

      int insertIndex = nodes.indexWhere((element) => newValue < element);
      if (insertIndex == -1) {
        nodes.add(newValue);
      } else {
        nodes.insert(insertIndex, newValue);
      }
      isInserting = false;
    });
    isInserting = true;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int itemCount = nodes.length * 2 - 1;
        double maxItemWidth = constraints.maxWidth / 8;
        double nodeSize = maxItemWidth.clamp(25.0, 70.0);
        double fontSize = nodeSize * 0.4;
        double arrowSize = nodeSize * 0.6;

        return Column(
          children: [
            const SizedBox(height: 60),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    key: ValueKey(nodes.toString()), // Key ensures proper animation
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: nodes.asMap().entries.expand((entry) {
                      int index = entry.key;
                      int value = entry.value;
                      return [
                        _buildNode(value, nodeSize, fontSize),
                        if (index < nodes.length - 1)
                          _buildArrow(nodeSize)
                        else
                          _buildNullPointer(nodeSize),
                      ];
                    }).toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: isInserting ? null : () => _insertSorted(40),
              child: const Text('insertIntoSorted(head, 40)'),
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
        borderRadius: BorderRadius.circular(size * 0.2),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(2, 2),
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

  // Creates an arrow between nodes to represent a linked connection
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