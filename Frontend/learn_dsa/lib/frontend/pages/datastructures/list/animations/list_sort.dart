import 'package:flutter/material.dart';

class LinkedListSortAnimation extends StatefulWidget {
  @override
  State<LinkedListSortAnimation> createState() => _LinkedListSortAnimationState();
}

class _LinkedListSortAnimationState extends State<LinkedListSortAnimation> {
  List<int> nodes = [20, 40, 10, 30, 50];
  bool isSorting = false;

  void _sortNodes() async {
    if (isSorting) return;

    setState(() => isSorting = true);

    for (int i = 0; i < nodes.length - 1; i++) {
      for (int j = 0; j < nodes.length - i - 1; j++) {
        if (nodes[j] > nodes[j + 1]) {
          await Future.delayed(Duration(milliseconds: 500));
          setState(() {
            int temp = nodes[j];
            nodes[j] = nodes[j + 1];
            nodes[j + 1] = temp;
          });
        }
      }
    }

    setState(() => isSorting = false);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int itemCount = nodes.length * 2 - 1;
        double maxItemWidth = constraints.maxWidth / itemCount;
        double nodeSize = maxItemWidth.clamp(25.0, 60.0);
        double fontSize = nodeSize * 0.4;
        double arrowSize = nodeSize * 0.6;

        return Column(
          children: [
            const SizedBox(height: 30),
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isSorting ? null : _sortNodes,
              child: const Text('sortList(head)'),
            ),
            const SizedBox(height: 20),
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
