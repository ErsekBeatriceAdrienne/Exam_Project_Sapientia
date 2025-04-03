import 'package:flutter/material.dart';
import 'dart:async';

// Binary Tree Node Definition
class BinaryTreeNode {
  int value;
  BinaryTreeNode? left, right;
  BinaryTreeNode(this.value);
}

BinaryTreeNode? insert(BinaryTreeNode? root, int value) {
  if (root == null) return BinaryTreeNode(value);

  if (root.left == null) {
    root.left = BinaryTreeNode(value);
  }
  else if (root.right == null) {
    root.right = BinaryTreeNode(value);
  }
  else {
    if (_countNodes(root.left) <= _countNodes(root.right)) {
      root.left = insert(root.left, value);
    } else {
      root.right = insert(root.right, value);
    }
  }

  return root;
}

int _countNodes(BinaryTreeNode? node) {
  if (node == null) return 0;
  return 1 + _countNodes(node.left) + _countNodes(node.right);
}


class BinaryTreePreorderAnimation extends StatefulWidget {
  @override
  _BinaryTreePreorderAnimationState createState() => _BinaryTreePreorderAnimationState();
}

class _BinaryTreePreorderAnimationState extends State<BinaryTreePreorderAnimation> {
  BinaryTreeNode? root;
  List<int> values = [20, 5, 19, 3, 87, 56, 89, 88];
  List<int> traversalValues = [];
  int? currentNodeValue;
  bool isAnimating = false;
  int insertCount = 0;

  @override
  void initState() {
    super.initState();
    _startAutoInsertion();
  }

  // Automatically insert nodes from values list with a delay
  void _startAutoInsertion() async {
    for (int i = 0; i < values.length; i++) {
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        root = insert(root, values[i]);
        insertCount++;
      });
    }
  }

  // Start animation for Preorder traversal
  Future<void> performTraversal() async {
    traversalValues.clear();
    setState(() {});
    await _preorder(root);
  }

  // Preorder Traversal (Root → Left → Right)
  Future<void> _preorder(BinaryTreeNode? node) async {
    if (node == null) return;
    setState(() {
      currentNodeValue = node.value;
      traversalValues.add(node.value);
    });
    await Future.delayed(Duration(seconds: 1));
    await _preorder(node.left);
    await _preorder(node.right);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tree Visualization
        Container(
          height: 300,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomPaint(
            painter: BinaryTreePainter(root, currentNodeValue),
            child: Container(),
          ),
        ),
        const SizedBox(height: 20),

        // Display preorder traversal results
        Text(
          "bejárás: ${traversalValues.join(", ")}",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),

        // Button to control animation
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await performTraversal();
              },
              child: Text("prebejárás(gy)"),
            ),
          ],
        ),
      ],
    );
  }
}

// Painter to draw the Binary Tree
class BinaryTreePainter extends CustomPainter {
  final BinaryTreeNode? root;
  final int? highlightValue;

  BinaryTreePainter(this.root, this.highlightValue);

  @override
  void paint(Canvas canvas, Size size) {
    if (root == null) return;

    double width = size.width;
    double nodeRadius = 20;

    _drawNode(canvas, root, width / 2, 50, width / 4, nodeRadius);
  }

  void _drawNode(Canvas canvas, BinaryTreeNode? node, double x, double y, double offset, double radius) {
    if (node == null) return;

    Paint nodePaint = Paint()
      ..color = (node.value == highlightValue ? Colors.purple : Color(0xFFDFAEE8));
    Paint linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    // Draw edges
    if (node.left != null) {
      canvas.drawLine(Offset(x, y), Offset(x - offset, y + 60), linePaint);
      _drawNode(canvas, node.left, x - offset, y + 60, offset / 1.5, radius);
    }
    if (node.right != null) {
      canvas.drawLine(Offset(x, y), Offset(x + offset, y + 60), linePaint);
      _drawNode(canvas, node.right, x + offset, y + 60, offset / 1.5, radius);
    }

    // Draw node circle
    canvas.drawCircle(Offset(x, y), radius, nodePaint);

    // Draw node value
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: node.value.toString(),
        style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(x - textPainter.width / 2, y - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
