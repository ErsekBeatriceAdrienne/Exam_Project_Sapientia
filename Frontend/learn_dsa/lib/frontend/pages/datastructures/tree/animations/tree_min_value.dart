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

class BSTMinNodeAnimation extends StatefulWidget {
  @override
  _BSTMinNodeAnimationState createState() => _BSTMinNodeAnimationState();
}

class _BSTMinNodeAnimationState extends State<BSTMinNodeAnimation> {
  BSTNode? root;
  List<int> values = [20, 5, 19, 3, 87, 56, 89, 88];
  int? currentNodeValue;

  @override
  void initState() {
    super.initState();
    for (int value in values) {
      root = insert(root, value);
    }
  }

  // Perform minimum node search and update UI step by step
  Future<void> performMinNodeSearch() async {
    setState(() {});
    await _findMinNode(root);
  }

  Future<void> _findMinNode(BSTNode? node) async {
    if (node == null) return;
    setState(() {
      currentNodeValue = node.value;
    });
    await Future.delayed(Duration(seconds: 1)); // Wait to visualize the visit
    if (node.left != null) {
      await _findMinNode(node.left); // Continue searching the left subtree
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
            painter: BSTPainter(root, currentNodeValue),
            child: Container(),
          ),
        ),

        const SizedBox(height: 20),

        Text("Minimum csomópont: ${currentNodeValue}"),

        const SizedBox(height: 20),

        ElevatedButton(
          onPressed: performMinNodeSearch,
          child: Text("minimum(csp)"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFDFAEE8),
            foregroundColor: Colors.white,
          ),
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

void main() => runApp(MaterialApp(home: Scaffold(body: BSTMinNodeAnimation())));
