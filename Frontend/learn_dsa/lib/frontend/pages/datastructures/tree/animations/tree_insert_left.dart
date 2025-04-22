import 'package:flutter/material.dart';

class BinaryTreeInsertLeftAnimation extends StatefulWidget {
  @override
  _BinaryTreeInsertLeftAnimationState createState() => _BinaryTreeInsertLeftAnimationState();
}

class _BinaryTreeInsertLeftAnimationState extends State<BinaryTreeInsertLeftAnimation> with SingleTickerProviderStateMixin {
  BinaryTreeNode? root;
  BinaryTreeNode? leftChild;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    root = BinaryTreeNode(10);
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
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomPaint(
            painter: BinaryTreePainter(root, leftChild, _fadeAnimation),
            child: Container(height: 200, width: 300),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => insertLeftNode(5),
          child: Text("beszúrás_balra(csp,5)"),
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

    Paint paint = Paint()
      ..color = Color(0xFFDFAEE8)
      ..style = PaintingStyle.fill;

    double centerX = size.width / 2;
    double centerY = size.height / 2;

    canvas.drawCircle(Offset(centerX, centerY - 50), 30, paint);
    drawNodeText(canvas, root!, centerX, centerY - 50);

    if (leftChild != null) {
      Paint leftPaint = Paint()
        ..color = Colors.purple.withOpacity(fadeAnimation.value)
        ..style = PaintingStyle.fill;

      Paint linePaint = Paint()
        ..color = Colors.black
        ..strokeWidth = 2;

      double newX = centerX - 60;
      double newY = centerY + 20;

      canvas.drawLine(Offset(centerX, centerY - 30), Offset(newX, newY - 30), linePaint);
      canvas.drawCircle(Offset(newX, newY), 30, leftPaint);
      drawNodeText(canvas, leftChild!, newX, newY);
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

    // Node info text on the right side
    TextPainter infoPainter = TextPainter(
      text: TextSpan(
        text: "info: ${node.value}\njobb: ${node.right?.value ?? 'NULL'}\nbal: ${node.left?.value ?? 'NULL'}",
        style: TextStyle(color: Colors.black, fontSize: 14),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
    );
    infoPainter.layout(maxWidth: 100);
    infoPainter.paint(canvas, Offset(x + 35, y - 10));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class BinaryTreeNode {
  int value;
  BinaryTreeNode? left, right;
  BinaryTreeNode(this.value);
}
