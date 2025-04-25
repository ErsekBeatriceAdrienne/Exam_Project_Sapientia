import 'package:flutter/material.dart';

class BSTInsertAnimation extends StatefulWidget {
  @override
  _BSTInsertAnimationState createState() => _BSTInsertAnimationState();
}

class _BSTInsertAnimationState extends State<BSTInsertAnimation> with SingleTickerProviderStateMixin {
  BSTNode? rootNode;
  BSTNode? leftChild;
  BSTNode? rightChild;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    rootNode = BSTNode(50);
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  void insertNewNode(int value) {
    setState(() {
      rightChild = BSTNode(value);
      rootNode?.right = rightChild;
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
            painter: BSTNodePainter(rootNode, leftChild, rightChild, _fadeAnimation),
            child: Container(height: 300, width: 300),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => insertNewNode(64),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFDFAEE8),
            foregroundColor: Colors.white,
          ),
          child: Text("beszúrás(64)"),
        ),
      ],
    );
  }
}

class BSTNodePainter extends CustomPainter {
  final BSTNode? rootNode;
  final BSTNode? leftChild;
  final BSTNode? rightChild;
  final Animation<double> fadeAnimation;

  BSTNodePainter(this.rootNode, this.leftChild, this.rightChild, this.fadeAnimation) : super(repaint: fadeAnimation);

  @override
  void paint(Canvas canvas, Size size) {
    if (rootNode == null) return;

    double nodeRadius = 30;
    double lineLength = 90;
    double branchHeight = 40;
    double totalHeight = nodeRadius * 2 + 10 + branchHeight + 20;

    double centerX = size.width / 2;
    double topOffset = (size.height - totalHeight) / 2;
    double centerY = topOffset + nodeRadius;

    final linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    double lineY = centerY + nodeRadius / 2 - 10;
    double startX = centerX - lineLength / 2;
    double endX = centerX + lineLength / 2;

    // Vízszintes vonal és ágak
    canvas.drawLine(Offset(startX, lineY), Offset(endX, lineY), linePaint);
    canvas.drawLine(Offset(startX, lineY), Offset(startX, lineY + branchHeight), linePaint);
    canvas.drawLine(Offset(endX, lineY), Offset(endX, lineY + branchHeight), linePaint);

    // Branches
    double leftX = centerX - lineLength / 2;
    double rightX = centerX + lineLength / 2;

    if (rootNode?.right == null) {
      drawText(canvas, "NULL", rightX - 20, lineY + branchHeight + 5);

      double smallLineLength = 15;
      canvas.drawLine(
        Offset(rightX - smallLineLength / 2, lineY + branchHeight),
        Offset(rightX + smallLineLength / 2, lineY + branchHeight),
        linePaint,
      );
    }

    drawText(canvas, "NULL", startX - 20, lineY + branchHeight + 5);
    drawText(canvas, "" ?? "NULL", endX - 20, lineY + branchHeight + 5);


    if (rightChild != null) {
      Paint rightPaint = Paint()
        ..color = Colors.purple.withOpacity(fadeAnimation.value)
        ..style = PaintingStyle.fill;

      double rightX = endX;
      double rightY = lineY + branchHeight + 30;

      canvas.drawCircle(Offset(rightX, rightY), nodeRadius, rightPaint);
      drawNodeText(canvas, rightChild!, rightX, rightY);
    }

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

    double smallLineLength = 15;
    canvas.drawLine(
      Offset(leftX - smallLineLength / 2, lineY + branchHeight),
      Offset(leftX + smallLineLength / 2, lineY + branchHeight),
      linePaint,
    );

    // Root
    Paint paint = Paint()
      ..color = Color(0xFFDFAEE8)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(centerX, centerY), nodeRadius, paint);
    drawNodeText(canvas, rootNode!, centerX, centerY);
  }

  void drawText(Canvas canvas, String text, double x, double y) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: TextStyle(color: Colors.black, fontSize: 14)),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(x, y));
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
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class BSTNode {
  int value;
  BSTNode? left, right;
  BSTNode(this.value);
}
