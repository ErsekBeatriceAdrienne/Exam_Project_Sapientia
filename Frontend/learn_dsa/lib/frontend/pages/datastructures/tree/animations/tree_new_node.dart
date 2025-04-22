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
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomPaint(
            painter: BSTNodePainter(node, _fadeAnimation),
            child: Container(height: 200, width: 300),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => createNewNode(50),
          child: Text("létrehozás(50)"),
        ),
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
    double nodeRadius = 30;
    double lineLength = 80;
    double branchHeight = 40;
    double totalHeight = nodeRadius * 2 + 10 + branchHeight + 20;

    // Új: számoljuk ki úgy a kezdő Y-t, hogy az egész struktúra középen legyen
    double topOffset = (size.height - totalHeight) / 2;
    double centerY = topOffset + nodeRadius;

    // Csomó
    canvas.drawCircle(Offset(centerX, centerY), nodeRadius, paint);

    // Csomó szöveg
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: node!.value.toString(),
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(centerX - textPainter.width / 2, centerY - textPainter.height / 2),
    );

    final linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    double lineY = centerY + nodeRadius + 10;
    double startX = centerX - lineLength / 2;
    double endX = centerX + lineLength / 2;

    canvas.drawLine(Offset(startX, lineY), Offset(endX, lineY), linePaint);
    canvas.drawLine(Offset(startX, lineY), Offset(startX, lineY + branchHeight), linePaint);
    canvas.drawLine(Offset(endX, lineY), Offset(endX, lineY + branchHeight), linePaint);

    final leftText = TextPainter(
      text: TextSpan(
        text: "NULL",
        style: TextStyle(color: Colors.black, fontSize: 14),
      ),
      textDirection: TextDirection.ltr,
    );
    leftText.layout();
    leftText.paint(canvas, Offset(startX - 20, lineY + branchHeight + 5));

    final rightText = TextPainter(
      text: TextSpan(
        text: " NULL",
        style: TextStyle(color: Colors.black, fontSize: 14),
      ),
      textDirection: TextDirection.ltr,
    );
    rightText.layout();
    rightText.paint(canvas, Offset(endX - 20, lineY + branchHeight + 5));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class BSTNode {
  int value;
  BSTNode? left, right;
  BSTNode(this.value);
}
