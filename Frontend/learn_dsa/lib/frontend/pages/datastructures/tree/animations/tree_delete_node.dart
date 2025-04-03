import 'package:flutter/material.dart';

// BST Node Definition
class BSTNode {
  int value;
  BSTNode? left, right;
  BSTNode(this.value);
}

// Insert function for BST
BSTNode? insert(BSTNode? root, int value) {
  if (root == null) return BSTNode(value);
  if (value < root.value) {
    root.left = insert(root.left, value);
  } else if (value > root.value) {
    root.right = insert(root.right, value);
  }
  return root;
}

// Delete node function
BSTNode? deleteNode(BSTNode? root, int key) {
  if (root == null) return root;

  if (key < root.value) {
    root.left = deleteNode(root.left, key);
  } else if (key > root.value) {
    root.right = deleteNode(root.right, key);
  } else {
    // If the node has one or no child
    if (root.left == null) {
      BSTNode? temp = root.right;
      root = null;  // Free the current node
      return temp;
    } else if (root.right == null) {
      BSTNode? temp = root.left;
      root = null;  // Free the current node
      return temp;
    }

    // If the node has two children
    BSTNode? temp = minValueNode(root.right);
    root.value = temp!.value;  // Copy the inorder successor's value
    root.right = deleteNode(root.right, temp.value);  // Delete inorder successor
  }
  return root;
}

// Find minimum value node
BSTNode? minValueNode(BSTNode? node) {
  BSTNode? current = node;
  while (current != null && current.left != null) {
    current = current.left;
  }
  return current;
}

class BSTDeleteNodeAnimation extends StatefulWidget {
  @override
  _BSTDeleteNodeAnimationState createState() => _BSTDeleteNodeAnimationState();
}

class _BSTDeleteNodeAnimationState extends State<BSTDeleteNodeAnimation> {
  BSTNode? root;
  List<int> values = [20, 5, 19, 3, 87, 56, 89, 88];
  int? currentNodeValue;
  int? deletedNodeValue;

  @override
  void initState() {
    super.initState();
    for (int value in values) {
      root = insert(root, value);
    }
  }

  // Perform node deletion and update UI step by step
  Future<void> performNodeDeletion() async {
    setState(() {});
    await _deleteNode(root, 87);  // Delete the node with value 87
  }

  Future<void> _deleteNode(BSTNode? node, int key) async {
    if (node == null) return;

    // Traverse the tree to find the node to delete
    if (key < node.value) {
      setState(() {
        currentNodeValue = node.value;
      });
      await Future.delayed(Duration(seconds: 1));
      await _deleteNode(node.left, key);
    } else if (key > node.value) {
      setState(() {
        currentNodeValue = node.value;
      });
      await Future.delayed(Duration(seconds: 1));
      await _deleteNode(node.right, key);
    } else {
      setState(() {
        deletedNodeValue = node.value;
      });
      // If node found, perform the deletion
      root = deleteNode(root, key);
      await Future.delayed(Duration(seconds: 1)); // Visualize the deletion process
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // BST Visualization
        Container(
          height: 300,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomPaint(
            painter: BSTPainter(root, currentNodeValue, deletedNodeValue),
            child: Container(),
          ),
        ),

        const SizedBox(height: 20),

        Text("Törölt elem: ${deletedNodeValue ?? 'nincs'}"),

        const SizedBox(height: 20),

        ElevatedButton(
          onPressed: performNodeDeletion,
          child: Text("törlés(87)"),
        ),
      ],
    );
  }
}

// Painter to draw the BST
class BSTPainter extends CustomPainter {
  final BSTNode? root;
  final int? highlightValue;
  final int? deletedValue;

  BSTPainter(this.root, this.highlightValue, this.deletedValue);

  @override
  void paint(Canvas canvas, Size size) {
    if (root == null) return;
    double width = size.width;
    _drawNode(canvas, root, width / 2, 50, width / 4);
  }

  void _drawNode(Canvas canvas, BSTNode? node, double x, double y, double offset) {
    if (node == null) return;

    Paint nodePaint = Paint()
      ..color = (node.value == highlightValue
          ? Colors.purple
          : (node.value == deletedValue ? Colors.red : Color(0xFFDFAEE8)));
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

void main() => runApp(MaterialApp(home: Scaffold(body: BSTDeleteNodeAnimation())));
