import 'package:flutter/material.dart';

class BSTNewNodeAnimation extends StatefulWidget {
  @override
  _BSTNewNodeAnimationState createState() => _BSTNewNodeAnimationState();
}

class _BSTNewNodeAnimationState extends State<BSTNewNodeAnimation> with SingleTickerProviderStateMixin {
  BSTNode? node;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  void createNewNode(int value) {
    setState(() {
      node = BSTNode(value);
    });
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomPaint(
          painter: BSTNodePainter(node, _fadeAnimation),
          child: Container(height: 100, width: 300),
        ),
        ElevatedButton(
          onPressed: () => createNewNode(50),
          child: Text("létrehozás(50)"),
        )
      ],
    );
  }
}

class BSTNodePainter extends CustomPainter {
  final BSTNode? node;
  final Animation<double> fadeAnimation;

  BSTNodePainter(this.node, this.fadeAnimation) : super(repaint: fadeAnimation);

  @override
  void paint(Canvas canvas, Size size) {
    if (node == null) return;
    Paint paint = Paint()
      ..color = Color(0xFFDFAEE8)
      ..style = PaintingStyle.fill;

    double centerX = size.width / 2;
    double centerY = size.height / 2;

    canvas.drawCircle(Offset(centerX, centerY), 30, paint);

    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: node!.value.toString(),
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(centerX - textPainter.width / 2, centerY - textPainter.height / 2));

    // Node info text on the right side of the node
    TextPainter infoPainter = TextPainter(
      text: TextSpan(
        text: "info: ${node!.value}\njobb: NULL\nbal: NULL",
        style: TextStyle(color: Colors.black, fontSize: 14),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
    );
    infoPainter.layout(maxWidth: size.width);
    infoPainter.paint(canvas, Offset(centerX + 40, centerY - 10));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class BSTNode {
  int value;
  BSTNode? left, right;
  BSTNode(this.value);
}