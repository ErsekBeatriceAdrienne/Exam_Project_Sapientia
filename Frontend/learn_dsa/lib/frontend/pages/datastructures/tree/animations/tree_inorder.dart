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

class BinaryTreeInorderTraversalAnimation extends StatefulWidget {
  @override
  _BinaryTreeInorderTraversalAnimationState createState() => _BinaryTreeInorderTraversalAnimationState();
}

class _BinaryTreeInorderTraversalAnimationState extends State<BinaryTreeInorderTraversalAnimation> {
  BinaryTreeNode? root;
  List<int> values = [20, 5, 19, 3, 87, 56, 89];
  List<int> traversalValues = [];
  int? currentNodeValue;
  bool isAnimating = false;
  String traversalType = "Preorder"; // Default traversal type
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

  // Start animation for the selected traversal type
  Future<void> performTraversal() async {
    traversalValues.clear();
    setState(() {});
    await _inorder(root);
  }

  // Inorder Traversal (Left → Root → Right)
  Future<void> _inorder(BinaryTreeNode? node) async {
    if (node == null) return;
    await _inorder(node.left);
    setState(() {
      currentNodeValue = node.value;
      traversalValues.add(node.value);
    });
    await Future.delayed(Duration(seconds: 1));
    await _inorder(node.right);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tree Visualization
        Container(
          height: 300,
          padding: const EdgeInsets.all(10),
          /*decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(12),
          ),*/
          child: CustomPaint(
            painter: BinaryTreePainter(root, currentNodeValue),
            child: Container(),
          ),
        ),
        const SizedBox(height: 20),

        // Display traversal type and results
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
              onPressed: isAnimating ? null : () async {
                setState(() {
                  isAnimating = true;
                });
                await performTraversal();
                setState(() {
                  isAnimating = false;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFDFAEE8),
                foregroundColor: Colors.white,
              ),
              child: Text("inorder_bejárás(gy)"),
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
    canvas.drawCircle(Offset(x, y), 20, nodePaint);

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










// BST Node Definition
class BSTNode {
  int value;
  BSTNode? left, right;
  BSTNode(this.value);
}

// Insert function for BST
BSTNode? insert1(BSTNode? root, int value) {
  if (root == null) return BSTNode(value);
  if (value < root.value) {
    root.left = insert1(root.left, value);
  } else if (value > root.value) {
    root.right = insert1(root.right, value);
  }
  return root;
}

class BSTInorderAnimation extends StatefulWidget {
  @override
  _BSTInorderAnimationState createState() => _BSTInorderAnimationState();
}

class _BSTInorderAnimationState extends State<BSTInorderAnimation> {
  BSTNode? root;
  List<int> values = [20, 5, 19, 3, 87, 56, 89];
  List<int> inorderTraversal = [];
  int? currentNodeValue;

  @override
  void initState() {
    super.initState();
    for (int value in values) {
      root = insert1(root, value);
    }
  }

  // Perform inorder traversal and update UI step by step
  Future<void> performInorderTraversal() async {
    inorderTraversal.clear();
    setState(() {});
    await _inorder(root);
  }

  Future<void> _inorder(BSTNode? node) async {
    if (node == null) return;
    await _inorder(node.left);
    setState(() {
      currentNodeValue = node.value;
      inorderTraversal.add(node.value);
    });
    await Future.delayed(Duration(seconds: 1));
    await _inorder(node.right);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // BST Visualization
        Container(
          height: 300,
          padding: const EdgeInsets.all(10),
          /*decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(12),
          ),*/
          child: CustomPaint(
            painter: BSTPainter(root, currentNodeValue),
            child: Container(),
          ),
        ),

        const SizedBox(height: 20),

        Text("Inorder Bejárás: ${inorderTraversal.join(", ")}"),
        ElevatedButton(
          onPressed: () async {
            await performInorderTraversal();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFDFAEE8),
            foregroundColor: Colors.white,
          ),
          child: Text("bejárás(gy)"),
        ),
      ],
    );
  }
}

// Painter to draw the BST
class BSTPainter extends CustomPainter {
  final BSTNode? root;
  final int? highlightValue;

  BSTPainter(this.root, this.highlightValue);

  @override
  void paint(Canvas canvas, Size size) {
    if (root == null) return;
    double width = size.width;
    _drawNode(canvas, root, width / 2, 50, width / 4);
  }

  void _drawNode(Canvas canvas, BSTNode? node, double x, double y, double offset) {
    if (node == null) return;
    Paint nodePaint = Paint()
      ..color = (node.value == highlightValue ? Colors.purple : Color(0xFFDFAEE8));
    Paint linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    // Draw edges
    if (node.left != null) {
      canvas.drawLine(Offset(x, y), Offset(x - offset, y + 60), linePaint);
      _drawNode(canvas, node.left, x - offset, y + 60, offset / 1.5);
    }
    if (node.right != null) {
      canvas.drawLine(Offset(x, y), Offset(x + offset, y + 60), linePaint);
      _drawNode(canvas, node.right, x + offset, y + 60, offset / 1.5);
    }

    // Draw node circle
    canvas.drawCircle(Offset(x, y), 20, nodePaint);

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

