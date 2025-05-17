import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BinaryTreeInsertLeftAnimation extends StatefulWidget {
  const BinaryTreeInsertLeftAnimation({super.key});

  @override
  _BinaryTreeInsertLeftAnimationState createState() => _BinaryTreeInsertLeftAnimationState();
}

class _BinaryTreeInsertLeftAnimationState extends State<BinaryTreeInsertLeftAnimation>
    with SingleTickerProviderStateMixin {
  BinaryTreeNode? root;
  BinaryTreeNode? leftChild;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  bool isSearching = false;
  bool isPaused = false;

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
          child: CustomPaint(
            painter: BinaryTreePainter(root, leftChild, _fadeAnimation),
            child: Container(height: 100, width: 300),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            "insertLeft(root, 5)",
            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1f7d53)),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: AppLocalizations.of(context)!.play_animation_button_text.length * 10 + 20,
          height: 40,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF255f38), Color(0xFF27391c)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 4,
                offset: Offset(4, 4),
              ),
            ],
          ),
          child: RawMaterialButton(
            onPressed: () {
              insertLeftNode(5);
              HapticFeedback.mediumImpact();
            },
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            constraints: const BoxConstraints.tightFor(width: 45, height: 45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  isSearching
                      ? (isPaused ? Icons.play_arrow_rounded : Icons.pause)
                      : Icons.play_arrow_rounded,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  size: 22,
                ),
                Text(
                  isSearching && !isPaused ? AppLocalizations.of(context)!.pause_animation_button_text : AppLocalizations.of(context)!.play_animation_button_text,
                  style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
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
      double leftChildX = leftX;
      double leftChildY = lineY + branchHeight + 30;

      Paint leftShadowPaint = Paint()
        ..color = Colors.black.withOpacity(0.5)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4);
      canvas.drawCircle(Offset(leftChildX + 4, leftChildY + 4), nodeRadius, leftShadowPaint);

      Paint leftBorderPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawCircle(Offset(leftChildX, leftChildY), nodeRadius, leftBorderPaint);

      Paint leftPaint = Paint()
        ..color = Color(0xFF1f7d53)
        ..style = PaintingStyle.fill;
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

    // Root
    Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawCircle(Offset(centerX + 4, centerY + 4), nodeRadius, shadowPaint);

    canvas.drawCircle(Offset(centerX + 3, centerY + 3), nodeRadius, shadowPaint);

    Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(Offset(centerX, centerY), nodeRadius, borderPaint);

    Paint fillPaint = Paint()
      ..color = Color(0xFF255f38)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(centerX, centerY), nodeRadius, fillPaint);
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
