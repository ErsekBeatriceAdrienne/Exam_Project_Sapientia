import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BinaryTreeInsertAnimation extends StatefulWidget {
  const BinaryTreeInsertAnimation({super.key});

  @override
  _BinaryTreeInsertAnimationState createState() => _BinaryTreeInsertAnimationState();
}

class _BinaryTreeInsertAnimationState extends State<BinaryTreeInsertAnimation> with SingleTickerProviderStateMixin {
  BinaryTreeNode? root;
  BinaryTreeNode? leftChild;
  BinaryTreeNode? rightChild;
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
          /*decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(12),
          ),*/
          child: CustomPaint(
            painter: BinaryTreePainter(root, leftChild, rightChild, _fadeAnimation),
            child: Container(height: 100, width: 300),
          ),
        ),

        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            "insertRight(root, 75)",
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
              insertRightNode(75);
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
  final BinaryTreeNode? rightChild;
  final Animation<double> fadeAnimation;

  BinaryTreePainter(this.root, this.leftChild, this.rightChild, this.fadeAnimation) : super(repaint: fadeAnimation);

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

    double lineY = centerY + nodeRadius / 2 - 10;
    double startX = centerX - lineLength / 2;
    double endX = centerX + lineLength / 2;

    canvas.drawLine(Offset(startX, lineY), Offset(endX, lineY), linePaint);
    canvas.drawLine(Offset(startX, lineY), Offset(startX, lineY + branchHeight), linePaint);
    canvas.drawLine(Offset(endX, lineY), Offset(endX, lineY + branchHeight), linePaint);

    // Branches
    double leftX = centerX - lineLength / 2;
    double rightX = centerX + lineLength / 2;

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
        ..color = Colors.green.withOpacity(fadeAnimation.value)
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

    drawText(canvas, "NULL", startX - 20, lineY + branchHeight + 5);
    drawText(canvas, "" ?? "NULL", endX - 20, lineY + branchHeight + 5);

    if (rightChild != null) {
      double rightX = endX;
      double rightY = lineY + branchHeight + 30;

      Paint rightShadowPaint = Paint()
        ..color = Colors.black.withOpacity(0.4)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4);
      canvas.drawCircle(Offset(rightX + 4, rightY + 4), nodeRadius, rightShadowPaint);

      Paint rightBorderPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawCircle(Offset(rightX, rightY), nodeRadius, rightBorderPaint);

      Paint rightPaint = Paint()
        ..color = Color(0xFF1f7d53)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(rightX, rightY), nodeRadius, rightPaint);
      drawNodeText(canvas, rightChild!, rightX, rightY);
    }

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

  void drawNodeText(Canvas canvas,BinaryTreeNode node, double x, double y) {
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
