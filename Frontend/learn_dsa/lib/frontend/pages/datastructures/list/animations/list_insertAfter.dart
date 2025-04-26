import 'package:flutter/material.dart';

class LinkedListInsertAfterNode extends StatefulWidget {
  @override
  State<LinkedListInsertAfterNode> createState() => _LinkedListInsertAfterNodeState();
}

class _LinkedListInsertAfterNodeState extends State<LinkedListInsertAfterNode> {
  List<int> nodes = [40, 30, 20];
  bool isInserting = false;

  void _insertNodeAfter(int index) async {
    if (isInserting) return;

    setState(() {
      isInserting = true;
    });

    await Future.delayed(Duration(milliseconds: 800));

    setState(() {
      nodes.insert(index + 1, 10);
      isInserting = false;
    });
    isInserting = true;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double nodeSize = constraints.maxWidth / 8;
        nodeSize = nodeSize.clamp(25.0, 60.0);
        double fontSize = nodeSize * 0.4;

        return Column(
          children: [
            SizedBox(height: 60),
            Expanded(
              child: Center(
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 800),
                  child: Row(
                    key: ValueKey(nodes.toString()),
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
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: isInserting ? null : () => _insertNodeAfter(1),
              child: Text('insertAfter(30, 10)'),
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
}
