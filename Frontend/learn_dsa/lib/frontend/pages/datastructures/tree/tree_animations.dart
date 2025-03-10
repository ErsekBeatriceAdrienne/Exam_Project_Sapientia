import 'package:flutter/material.dart';
import 'dart:math';

// Main widget to render the BST animation
class BSTAnimation extends StatefulWidget {
  @override
  _BSTAnimationState createState() => _BSTAnimationState();
}

class _BSTAnimationState extends State<BSTAnimation> {
  BSTNode? root;
  List<int> values = [];
  int insertCount = 0;
  final int maxNodes = 7;
  final int maxDepth = 7;

  @override
  void initState() {
    super.initState();
    _startAutoInsertion();
  }

  // Automatically insert 7 nodes one by one with a delay
  void _startAutoInsertion() async {
    while (insertCount < maxNodes) {
      await Future.delayed(const Duration(seconds: 1));
      int newValue = Random().nextInt(100);

      // Check if the tree depth exceeds maxDepth before inserting
      if (getDepth(root) < maxDepth) {
        setState(() {
          values.add(newValue);
          root = insert(root, newValue);
          insertCount++;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Animated BST Visualization
        Container(
          height: 300,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomPaint(
            painter: BSTPainter(root),
            child: Container(),
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}

// BST Node Definition
class BSTNode {
  int value;
  BSTNode? left, right;

  BSTNode(this.value);
}

// Insert function for BST with depth check
BSTNode? insert(BSTNode? root, int value, [int depth = 1, int maxDepth = 3]) {
  if (root == null) return BSTNode(value);

  if (depth >= maxDepth) return root; // Stop insertion if depth limit reached

  if (value < root.value) {
    root.left = insert(root.left, value, depth + 1, maxDepth);
  } else if (value > root.value) {
    root.right = insert(root.right, value, depth + 1, maxDepth);
  }

  return root;
}

// Get depth of BST
int getDepth(BSTNode? node) {
  if (node == null) return 0;
  return 1 + max(getDepth(node.left), getDepth(node.right));
}

// Painter to draw the BST
class BSTPainter extends CustomPainter {
  final BSTNode? root;

  BSTPainter(this.root);

  @override
  void paint(Canvas canvas, Size size) {
    if (root == null) return;

    double width = size.width;
    double nodeRadius = 20;

    _drawNode(canvas, root, width / 2, 50, width / 4, nodeRadius, 1);
  }

  void _drawNode(Canvas canvas, BSTNode? node, double x, double y, double offset, double radius, int depth) {
    if (node == null) return;

    Paint nodePaint = Paint()..color = Color(0xFFDFAEE8);
    Paint linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: node.value.toString(),
        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    // Draw edges
    if (node.left != null) {
      canvas.drawLine(Offset(x, y), Offset(x - offset, y + 60), linePaint);
      _drawNode(canvas, node.left, x - offset, y + 60, offset / 1.5, radius, depth + 1);
    }
    if (node.right != null) {
      canvas.drawLine(Offset(x, y), Offset(x + offset, y + 60), linePaint);
      _drawNode(canvas, node.right, x + offset, y + 60, offset / 1.5, radius, depth + 1);
    }

    // Draw node circle
    canvas.drawCircle(Offset(x, y), radius, nodePaint);

    // Draw node value
    textPainter.paint(canvas, Offset(x - textPainter.width / 2, y - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
