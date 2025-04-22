import 'package:flutter/material.dart';

class BSTInsertAnimation extends StatefulWidget {
  @override
  _BSTInsertAnimationState createState() => _BSTInsertAnimationState();
}

class _BSTInsertAnimationState extends State<BSTInsertAnimation> with SingleTickerProviderStateMixin {
  BSTNode? rootNode;
  BSTNode? newNode;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    rootNode = BSTNode(30);
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  void insertNewNode(int value) {
    setState(() {
      newNode = BSTNode(value);
      rootNode?.right = newNode;
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
            painter: BSTNodePainter(rootNode, newNode, _fadeAnimation),
            child: Container(height: 200, width: 300),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => insertNewNode(50),
          child: Text("beszúrás(50)"),
        ),
      ],
    );
  }
}

class BSTNodePainter extends CustomPainter {
  final BSTNode? rootNode;
  final BSTNode? newNode;
  final Animation<double> fadeAnimation;

  BSTNodePainter(this.rootNode, this.newNode, this.fadeAnimation) : super(repaint: fadeAnimation);

  @override
  void paint(Canvas canvas, Size size) {
    if (rootNode == null) return;
    Paint paint = Paint()
      ..color = Color(0xFFDFAEE8)
      ..style = PaintingStyle.fill;

    double centerX = size.width / 2;
    double centerY = size.height / 2;

    canvas.drawCircle(Offset(centerX, centerY - 50), 30, paint);
    drawNodeText(canvas, rootNode!, centerX, centerY - 50);

    if (newNode != null) {
      Paint newPaint = Paint()
        ..color = Colors.purple.withOpacity(fadeAnimation.value)
        ..style = PaintingStyle.fill;

      Paint linePaint = Paint()
        ..color = Colors.black
        ..strokeWidth = 2;

      double newX = centerX + 60;
      double newY = centerY + 20;

      canvas.drawLine(Offset(centerX, centerY - 30), Offset(newX, newY - 30), linePaint);
      canvas.drawCircle(Offset(newX, newY), 30, newPaint);
      drawNodeText(canvas, newNode!, newX, newY);
    }
  }

  void drawNodeText(Canvas canvas, BSTNode node, double x, double y) {
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

class BSTNode {
  int value;
  BSTNode? left, right;
  BSTNode(this.value);
}
