import 'package:flutter/material.dart';

// BST Node Definition
class BSTNode
{
  int value;
  BSTNode? left, right;
  BSTNode(this.value);
}

// Insert function for BST
BSTNode? insert(BSTNode? root, int value)
{
  if (root == null) return BSTNode(value);
  if (value < root.value) {
    root.left = insert(root.left, value);
  } else if (value > root.value) {
    root.right = insert(root.right, value);
  }
  return root;
}

class BSTAnimation extends StatefulWidget {
  @override
  _BSTAnimationState createState() => _BSTAnimationState();
}

class _BSTAnimationState extends State<BSTAnimation> {
  BSTNode? root;
  List<int> values = [20 ,5, 19, 3, 87, 56, 89, 88];
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

// Painter to draw the BST
class BSTPainter extends CustomPainter {
  final BSTNode? root;

  BSTPainter(this.root);

  @override
  void paint(Canvas canvas, Size size) {
    if (root == null) return;

    double width = size.width;
    double nodeRadius = 20;

    _drawNode(canvas, root, width / 2, 50, width / 4, nodeRadius);
  }

  void _drawNode(Canvas canvas, BSTNode? node, double x, double y, double offset, double radius) {
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
      _drawNode(canvas, node.left, x - offset, y + 60, offset / 1.5, radius);
    }
    if (node.right != null) {
      canvas.drawLine(Offset(x, y), Offset(x + offset, y + 60), linePaint);
      _drawNode(canvas, node.right, x + offset, y + 60, offset / 1.5, radius);
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