import 'package:flutter/material.dart';

class BinaryTreeInsertLeftAnimation extends StatefulWidget {
  @override
  _BinaryTreeInsertLeftAnimationState createState() => _BinaryTreeInsertLeftAnimationState();
}

class _BinaryTreeInsertLeftAnimationState extends State<BinaryTreeInsertLeftAnimation>
    with SingleTickerProviderStateMixin {
  BinaryTreeNode? root;
  BinaryTreeNode? leftChild;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    root = BinaryTreeNode(50);
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  void insertLeftNode(int value) {
    setState(() {
      leftChild = BinaryTreeNode(value);
      root?.left = leftChild;
    });
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          /*decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(12),
          ),*/
          child: CustomPaint(
            painter: BinaryTreePainter(root, leftChild, _fadeAnimation),
            child: Container(height: 300, width: 300),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => insertLeftNode(5),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFDFAEE8),
            foregroundColor: Colors.white,
          ),
          child: Text("beszúrás_balra(csp, 5)"),
        ),
      ],
    );
  }
}

class BinaryTreePainter extends CustomPainter {
  final BinaryTreeNode? root;
  final BinaryTreeNode? leftChild;
  final Animation<double> fadeAnimation;

  BinaryTreePainter(this.root, this.leftChild, this.fadeAnimation) : super(repaint: fadeAnimation);

  @override
  void paint(Canvas canvas, Size size) {
    if (root == null) return;

    double nodeRadius = 30;
    double lineLength = 90;
    double branchHeight = 40;
    double totalHeight = nodeRadius * 2 + 10 + branchHeight + 20;

    double centerX = size.width / 2;
    double topOffset = (size.height - totalHeight) / 2;
    double centerY = topOffset + nodeRadius;

    Paint linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    // Branches
    double lineY = centerY + nodeRadius / 2 - 10;
    double leftX = centerX - lineLength / 2;
    double rightX = centerX + lineLength / 2;

    canvas.drawLine(Offset(leftX, lineY), Offset(rightX, lineY), linePaint);
    canvas.drawLine(Offset(leftX, lineY), Offset(leftX, lineY + branchHeight), linePaint);
    canvas.drawLine(Offset(rightX, lineY), Offset(rightX, lineY + branchHeight), linePaint);

    if (leftChild == null) {
      drawText(canvas, "NULL", leftX - 20, lineY + branchHeight + 5);

      double smallLineLength = 15;
      canvas.drawLine(
        Offset(leftX - smallLineLength / 2, lineY + branchHeight),
        Offset(leftX + smallLineLength / 2, lineY + branchHeight),
        linePaint,
      );
    } else {
      Paint leftPaint = Paint()
        ..color = Colors.purple.withOpacity(fadeAnimation.value)
        ..style = PaintingStyle.fill;

      double leftChildX = leftX;
      double leftChildY = lineY + branchHeight + 30;

      canvas.drawCircle(Offset(leftChildX, leftChildY), nodeRadius, leftPaint);
      drawNodeText(canvas, leftChild!, leftChildX, leftChildY);
    }

    if (root?.right == null) {
      drawText(canvas, "NULL", rightX - 20, lineY + branchHeight + 5);

      double smallLineLength = 15;
      canvas.drawLine(
        Offset(rightX - smallLineLength / 2, lineY + branchHeight),
        Offset(rightX + smallLineLength / 2, lineY + branchHeight),
        linePaint,
      );
    }

    drawText(canvas, "NULL", rightX - 20, lineY + branchHeight + 5);

    Paint paint = Paint()
      ..color = Color(0xFFDFAEE8)
      ..style = PaintingStyle.fill;

    // Root
    canvas.drawCircle(Offset(centerX, centerY), nodeRadius, paint);
    drawNodeText(canvas, root!, centerX, centerY);
  }

  void drawText(Canvas canvas, String text, double x, double y) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: TextStyle(color: Colors.black, fontSize: 14)),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(x, y));
  }

  void drawNodeText(Canvas canvas, BinaryTreeNode node, double x, double y)
  {
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
