import 'package:flutter/material.dart';

class LinkedListNewNodeAnimation extends StatefulWidget {
  @override
  _LinkedListNewNodeAnimationState createState() => _LinkedListNewNodeAnimationState();
}

class _LinkedListNewNodeAnimationState extends State<LinkedListNewNodeAnimation> {
  List<int> nodes = [];
  int currentIndex = 0;
  final List<int> values = [10, 20, 30, 40, 50];

  void newNode() {
    if (currentIndex < values.length) {
      setState(() {
        nodes.add(values[currentIndex]);
        currentIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Linked List Animation")),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    ...nodes.asMap().entries.map((entry) {
                      int index = entry.key;
                      int value = entry.value;
                      return Row(
                        children: [
                          _buildNode(value),
                          if (index < nodes.length - 1) _buildArrow(),
                        ],
                      );
                    }),
                    if (nodes.isNotEmpty) ...[
                      _buildArrow(),
                      _buildNullLabel(),
                    ]
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: newNode,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildNode(int value) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: 50,
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 4),
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
    return Icon(Icons.arrow_right_alt, color: Colors.black, size: 28);
  }

  Widget _buildNullLabel() {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        'null',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}
