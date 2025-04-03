import 'package:flutter/material.dart';

class BinaryTreeInsertAnimation extends StatefulWidget {
  @override
  _BinaryTreeInsertAnimationState createState() => _BinaryTreeInsertAnimationState();
}

class _BinaryTreeInsertAnimationState extends State<BinaryTreeInsertAnimation> with SingleTickerProviderStateMixin {
  BinaryTreeNode? root;
  BinaryTreeNode? leftChild;
  BinaryTreeNode? rightChild;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    root = BinaryTreeNode(10);
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  void insertRightNode(int value) {
    setState(() {
      rightChild = BinaryTreeNode(value);
      root?.right = rightChild;
    });
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomPaint(
            painter: BinaryTreePainter(root, leftChild, rightChild, _fadeAnimation),
            child: Container(height: 200, width: 300),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () => insertRightNode(15),
              child: Text("beszúrás_jobbra(csp,15)"),
            ),
          ],
        ),
      ],
    );
  }
}

class BinaryTreePainter extends CustomPainter {
  final BinaryTreeNode? root;
  final BinaryTreeNode? leftChild;
  final BinaryTreeNode? rightChild;
  final Animation<double> fadeAnimation;

  BinaryTreePainter(this.root, this.leftChild, this.rightChild, this.fadeAnimation) : super(repaint: fadeAnimation);

  @override
  void paint(Canvas canvas, Size size) {
    if (root == null) return;

    Paint paint = Paint()
      ..color = Color(0xFFDFAEE8)
      ..style = PaintingStyle.fill;

    double centerX = size.width / 2;
    double centerY = size.height / 2;

    canvas.drawCircle(Offset(centerX, centerY - 50), 30, paint);
    drawNodeText(canvas, root!, centerX, centerY - 50);

    Paint linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    if (rightChild != null) {
      Paint rightPaint = Paint()
        ..color = Colors.purple.withOpacity(fadeAnimation.value)
        ..style = PaintingStyle.fill;

      double rightX = centerX + 60;
      double rightY = centerY + 20;

      canvas.drawLine(Offset(centerX, centerY - 30), Offset(rightX, rightY - 30), linePaint);
      canvas.drawCircle(Offset(rightX, rightY), 30, rightPaint);
      drawNodeText(canvas, rightChild!, rightX, rightY);
    }
  }

  void drawNodeText(Canvas canvas, BinaryTreeNode node, double x, double y) {
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: node.value.toString(),
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(x - textPainter.width / 2, y - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class BinaryTreeNode {
  int value;
  BinaryTreeNode? left, right;
  BinaryTreeNode(this.value);
}
