import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BSTNewNodeAnimation extends StatefulWidget {
  const BSTNewNodeAnimation({super.key});

  @override
  _BSTNewNodeAnimationState createState() => _BSTNewNodeAnimationState();
}

class _BSTNewNodeAnimationState extends State<BSTNewNodeAnimation> with SingleTickerProviderStateMixin {
  BSTNode? node;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  bool isAnimating = false;
  bool isPaused = false;

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
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            "createNewNode(50)",
            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1f7d53)),
          ),
        ),
        const SizedBox(height: 20),
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
              createNewNode(50);
              HapticFeedback.mediumImpact();
            },
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  isAnimating
                      ? (isPaused ? Icons.play_arrow_rounded : Icons.pause)
                      : Icons.play_arrow_rounded,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  size: 22,
                ),
                Text(
                  isAnimating && !isPaused ? AppLocalizations.of(context)!.pause_animation_button_text : AppLocalizations.of(context)!.play_animation_button_text,
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

class BSTNodePainter extends CustomPainter {
  final BSTNode? node;
  final Animation<double> fadeAnimation;

  BSTNodePainter(this.node, this.fadeAnimation) : super(repaint: fadeAnimation);

  @override
  void paint(Canvas canvas, Size size) {
    if (node == null) return;

    double centerX = size.width / 2;
    double nodeRadius = 30;
    double lineLength = 90;
    double branchHeight = 40;
    double totalHeight = nodeRadius * 2 + 10 + branchHeight + 20;
    double topOffset = (size.height - totalHeight) / 2;
    double centerY = topOffset + nodeRadius;

    final linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    double lineY = centerY + nodeRadius / 2 - 10;
    double startX = centerX - lineLength / 2;
    double endX = centerX + lineLength / 2;

    canvas.drawLine(Offset(startX, lineY), Offset(endX, lineY), linePaint);
    canvas.drawLine(Offset(startX, lineY), Offset(startX, lineY + branchHeight), linePaint);
    canvas.drawLine(Offset(endX, lineY), Offset(endX, lineY + branchHeight), linePaint);

    // Small lines when Null
    double smallLineLength = 15;
    canvas.drawLine(
      Offset(startX - smallLineLength / 2, lineY + branchHeight),
      Offset(startX + smallLineLength / 2, lineY + branchHeight),
      linePaint,
    );
    canvas.drawLine(
      Offset(endX - smallLineLength / 2, lineY + branchHeight),
      Offset(endX + smallLineLength / 2, lineY + branchHeight),
      linePaint,
    );

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
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class BSTNode {
  int value;
  BSTNode? left, right;
  BSTNode(this.value);
}
