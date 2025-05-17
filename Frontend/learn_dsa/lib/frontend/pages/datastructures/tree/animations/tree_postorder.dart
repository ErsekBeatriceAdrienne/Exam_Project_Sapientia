import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BinaryTreeNode {
  int value;
  BinaryTreeNode? left, right;
  BinaryTreeNode(this.value);
}

BinaryTreeNode? insert(BinaryTreeNode? root, int value) {
  if (root == null) {
    HapticFeedback.mediumImpact();
    return BinaryTreeNode(value);
  }

  if (root.left == null) {
    root.left = BinaryTreeNode(value);
    HapticFeedback.mediumImpact();
  }
  else if (root.right == null) {
    root.right = BinaryTreeNode(value);
    HapticFeedback.mediumImpact();
  }
  else {
    if (_countNodes(root.left) <= _countNodes(root.right)) {
      root.left = insert(root.left, value);
      HapticFeedback.mediumImpact();
    } else {
      root.right = insert(root.right, value);
      HapticFeedback.mediumImpact();
    }
  }

  return root;
}

int _countNodes(BinaryTreeNode? node) {
  if (node == null) return 0;
  return 1 + _countNodes(node.left) + _countNodes(node.right);
}

class BinaryTreePreorderTraversalAnimation extends StatefulWidget {
  const BinaryTreePreorderTraversalAnimation({super.key});

  @override
  _BinaryTreePreorderTraversalAnimationState createState() => _BinaryTreePreorderTraversalAnimationState();
}

class _BinaryTreePreorderTraversalAnimationState extends State<BinaryTreePreorderTraversalAnimation> {
  BinaryTreeNode? root;
  List<int> values = [20, 5, 19, 3, 87, 56, 89];
  List<int> traversalValues = [];
  int? currentNodeValue;
  bool isAnimating = false;
  String traversalType = "Postorder";
  int insertCount = 0;
  bool isSearching = false;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    _insertAllImmediately();
  }

  void _insertAllImmediately() {
    for (int value in values) {
      root = insert(root, value);
      insertCount++;
    }
    setState(() {});
  }

  Future<void> performTraversal() async {
    traversalValues.clear();
    setState(() {});
    if (traversalType == "Postorder") {
      await _postorder(root);
    }
  }

  Future<void> _postorder(BinaryTreeNode? node) async {
    if (node == null) return;
    await _postorder(node.left);
    await _postorder(node.right);
    setState(() {
      currentNodeValue = node.value;
      traversalValues.add(node.value);
      HapticFeedback.mediumImpact();
    });
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tree Visualization
        Container(
          height: 300,
          padding: const EdgeInsets.all(10),
          /*decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(12),
          ),*/
          child: CustomPaint(
            painter: BinaryTreePainter(root, currentNodeValue),
            child: Container(),
          ),
        ),
        const SizedBox(height: 20),

        // Display traversal type and results
        Text(
          "Postorder traversal: ${traversalValues.join(", ")}",
          style: TextStyle(fontSize: 16),
        ),

        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            "postorderTraversal(root)",
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
              performTraversal();
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

// Painter to draw the Binary Tree
class BinaryTreePainter extends CustomPainter {
  final BinaryTreeNode? root;
  final int? highlightValue;

  BinaryTreePainter(this.root, this.highlightValue);

  @override
  void paint(Canvas canvas, Size size) {
    if (root == null) return;
    double width = size.width;
    double nodeRadius = 20;
    _drawNode(canvas, root, width / 2, 50, width / 4, nodeRadius);
  }

  void _drawNode(Canvas canvas, BinaryTreeNode? node, double x, double y, double offset, double radius) {
    if (node == null) return;

    Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 6);

    Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Paint nodePaint = Paint()
      ..color = (node.value == highlightValue ? Color(0xFF1f7d53) : Color(0xFF255f38));

    Paint linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    // Draw edges
    if (node.left != null) {
      canvas.drawLine(Offset(x, y), Offset(x - offset, y + 60), linePaint);
      _drawNode(canvas, node.left, x - offset, y + 60, offset / 1.5, radius);
    }
    if (node.right != null) {
      canvas.drawLine(Offset(x, y), Offset(x + offset, y + 60), linePaint);
      _drawNode(canvas, node.right, x + offset, y + 60, offset / 1.5, radius);
    }

    // Shadow
    canvas.drawCircle(Offset(x + 2, y + 2), radius, shadowPaint);

    // Border (thin white stroke)
    canvas.drawCircle(Offset(x, y), radius, borderPaint);

    // Node circle (filled)
    canvas.drawCircle(Offset(x, y), radius - 1, nodePaint);

    // Node value
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: node.value.toString(),
        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(x - textPainter.width / 2, y - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
