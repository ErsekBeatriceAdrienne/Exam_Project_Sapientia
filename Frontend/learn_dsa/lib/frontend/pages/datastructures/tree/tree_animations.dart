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

// New node animation

class BSTNewNodeAnimation extends StatefulWidget {
  @override
  _BSTNewNodeAnimationState createState() => _BSTNewNodeAnimationState();
}

class _BSTNewNodeAnimationState extends State<BSTNewNodeAnimation> with SingleTickerProviderStateMixin {
  BSTNode? root;
  int insertCount = 0;
  late AnimationController _controller;
  late Animation<double> _nodeAnimation;
  late Animation<double> _lineAnimation;

  @override
  void initState() {
    super.initState();

    // Animation controller for node and line animations
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..addListener(() {
      setState(() {});
    });

    // Animation for node radius (size)
    _nodeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Animation for line opacity
    _lineAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _startNodeInsertion();
  }

  // Start the node insertion animation
  void _startNodeInsertion() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      root = insert(root, 20); // Insert the first node (20)
      insertCount++;
    });

    // Start animation for node appearance
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            painter: BSTNewNodePainter(root, _nodeAnimation, _lineAnimation),
            child: Container(),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

// Painter to draw the BST with animated node and connections
class BSTNewNodePainter extends CustomPainter {
  final BSTNode? root;
  final Animation<double> nodeAnimation;
  final Animation<double> lineAnimation;

  BSTNewNodePainter(this.root, this.nodeAnimation, this.lineAnimation);

  @override
  void paint(Canvas canvas, Size size) {
    if (root == null) return;

    double width = size.width;
    double nodeRadius = 20;
    double yOffset = 50;

    // Draw nodes with animation
    _drawNode(canvas, root, width / 2, yOffset, width / 4, nodeRadius);
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

    // Draw edges with animation
    if (node.left != null) {
      double leftLineOpacity = lineAnimation.value;
      linePaint.color = linePaint.color.withOpacity(leftLineOpacity);
      canvas.drawLine(Offset(x, y), Offset(x - offset, y + 60), linePaint);
      _drawNode(canvas, node.left, x - offset, y + 60, offset / 1.5, radius);
    }
    if (node.right != null) {
      double rightLineOpacity = lineAnimation.value;
      linePaint.color = linePaint.color.withOpacity(rightLineOpacity);
      canvas.drawLine(Offset(x, y), Offset(x + offset, y + 60), linePaint);
      _drawNode(canvas, node.right, x + offset, y + 60, offset / 1.5, radius);
    }

    // Draw node circle with animation (size)
    double currentRadius = radius * nodeAnimation.value;
    canvas.drawCircle(Offset(x, y), currentRadius, nodePaint);

    // Draw node value (animate text if necessary)
    textPainter.paint(canvas, Offset(x - textPainter.width / 2, y - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

