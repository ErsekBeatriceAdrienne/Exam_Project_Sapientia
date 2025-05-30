import 'package:flutter/material.dart';

// BT Node Definition
class BTNode {
  int value;
  BTNode? left, right;
  BTNode(this.value);
}

BTNode? insert(BTNode? root, int value) {
  if (root == null) return BTNode(value);

  if (root.left == null) {
    root.left = BTNode(value);
  }
  else if (root.right == null) {
    root.right = BTNode(value);
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

int _countNodes(BTNode? node) {
  if (node == null) return 0;
  return 1 + _countNodes(node.left) + _countNodes(node.right);
}

class BTAnimation extends StatefulWidget {
  const BTAnimation({super.key});

  @override
  _BTAnimationState createState() => _BTAnimationState();
}

class _BTAnimationState extends State<BTAnimation> {
  BTNode? root;
  List<int> values = [20, 5, 19, 3, 87, 56, 89, 88];
  int insertCount = 0;

  @override
  void initState() {
    super.initState();
    for (int value in values) {
      root = insert(root, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            // Animated BT Visualization
            Container(
              height: 300,
              padding: const EdgeInsets.all(10),
              /*decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(12),
              ),*/
              child: CustomPaint(
                painter: BTPainter(root),
                child: Container(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Painter to draw the Binary Tree
class BTPainter extends CustomPainter {
  final BTNode? root;

  BTPainter(this.root);

  @override
  void paint(Canvas canvas, Size size) {
    if (root == null) return;

    double width = size.width;
    double nodeRadius = 20;

    _drawNode(canvas, root, width / 2, 50, width / 5, nodeRadius);
  }

  void _drawNode(Canvas canvas, BTNode? node, double x, double y, double offset, double radius) {
    if (node == null) return;

    Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 6);

    Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Paint nodePaint = Paint()
      ..color = Color(0xFF255f38);

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

    // Shadow
    canvas.drawCircle(Offset(x + 2, y + 2), radius, shadowPaint);

    // Border (thin white stroke)
    canvas.drawCircle(Offset(x, y), radius, borderPaint);

    // Node circle (filled)
    canvas.drawCircle(Offset(x, y), radius - 1, nodePaint);

    // Node value
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: node.value.toString(),
        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(x - textPainter.width / 2, y - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}







// BST Node Definition
class BSTNode
{
  int value;
  BSTNode? left, right;
  BSTNode(this.value);
}

// Insert function for BST
BSTNode? insert1(BSTNode? root, int value)
{
  if (root == null) return BSTNode(value);
  if (value < root.value) {
    root.left = insert1(root.left, value);
  } else if (value > root.value) root.right = insert1(root.right, value);
  return root;
}

class BSTAnimation extends StatefulWidget {
  const BSTAnimation({super.key});

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
    for (int value in values) {
      root = insert1(root, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            // Animated BT Visualization
            Container(
              height: 300,
              padding: const EdgeInsets.all(10),
              /*decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(12),
              ),*/
              child: CustomPaint(
                painter: BSTPainter(root),
                child: Container(),
              ),
            ),
          ],
        ),
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

    _drawNode(canvas, root, width / 2, 50, width / 5, nodeRadius);
  }

  void _drawNode(Canvas canvas, BSTNode? node, double x, double y, double offset, double radius) {
    if (node == null) return;

    Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 6);

    Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Paint nodePaint = Paint()
      ..color = Color(0xFF255f38);

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

    // Shadow
    canvas.drawCircle(Offset(x + 2, y + 2), radius, shadowPaint);

    // Border (thin white stroke)
    canvas.drawCircle(Offset(x, y), radius, borderPaint);

    // Node circle (filled)
    canvas.drawCircle(Offset(x, y), radius - 1, nodePaint);

    // Node value
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: node.value.toString(),
        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(x - textPainter.width / 2, y - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}