import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// BST Node Definition
class BSTNode {
  int value;
  BSTNode? left, right;
  BSTNode(this.value);
}

// Insert function for BST
BSTNode? insert(BSTNode? root, int value) {
  if (root == null) return BSTNode(value);
  if (value < root.value) {
    root.left = insert(root.left, value);
  } else if (value > root.value) {
    root.right = insert(root.right, value);
  }
  return root;
}

// Delete node function
BSTNode? deleteNode(BSTNode? root, int key) {
  if (root == null) return root;

  if (key < root.value) {
    root.left = deleteNode(root.left, key);
  } else if (key > root.value) {
    root.right = deleteNode(root.right, key);
  } else {
    // If the node has one or no child
    if (root.left == null) {
      BSTNode? temp = root.right;
      root = null;  // Free the current node
      return temp;
    } else if (root.right == null) {
      BSTNode? temp = root.left;
      root = null;  // Free the current node
      return temp;
    }

    // If the node has two children
    BSTNode? temp = minValueNode(root.right);
    root.value = temp!.value;  // Copy the inorder successor's value
    root.right = deleteNode(root.right, temp.value);  // Delete inorder successor
  }
  return root;
}

// Find minimum value node
BSTNode? minValueNode(BSTNode? node) {
  BSTNode? current = node;
  while (current != null && current.left != null) {
    current = current.left;
  }
  return current;
}

class BSTDeleteNodeAnimation extends StatefulWidget {
  const BSTDeleteNodeAnimation({super.key});

  @override
  _BSTDeleteNodeAnimationState createState() => _BSTDeleteNodeAnimationState();
}

class _BSTDeleteNodeAnimationState extends State<BSTDeleteNodeAnimation> {
  BSTNode? root;
  List<int> values = [20, 5, 19, 3, 87, 56, 89, 88];
  int? currentNodeValue;
  int? deletedNodeValue;
  bool isSearching = false;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    for (int value in values) {
      root = insert(root, value);
    }
  }

  BSTNode? maxValueNode(BSTNode? node) {
    BSTNode? current = node;
    while (current != null && current.right != null) {
      current = current.right;
    }
    return current;
  }

  // Perform node deletion and update UI step by step
  Future<void> performNodeDeletion() async {
    setState(() {
      isSearching = true;
      isPaused = false;
    });
    root = await _deleteNode(root, 87);
    setState(() {
      isSearching = false;
      currentNodeValue = null;
    });
  }


  Future<BSTNode?> _deleteNode(BSTNode? node, int key) async {
    if (node == null) return null;

    HapticFeedback.mediumImpact();
    setState(() {
      currentNodeValue = node.value;
    });
    await Future.delayed(Duration(seconds: 1));

    if (key < node.value) {
      HapticFeedback.mediumImpact();
      node.left = await _deleteNode(node.left, key);
    } else if (key > node.value) {
      HapticFeedback.mediumImpact();
      node.right = await _deleteNode(node.right, key);
    } else {
      HapticFeedback.mediumImpact();
      setState(() {
        deletedNodeValue = node.value;
      });
      await Future.delayed(Duration(seconds: 1));

      if (node.left == null && node.right == null) {
        HapticFeedback.mediumImpact();
        return null;
      } else if (node.left == null) {
        HapticFeedback.mediumImpact();
        return node.right;
      } else if (node.right == null) {
        HapticFeedback.mediumImpact();
        return node.left;
      } else {
        HapticFeedback.mediumImpact();
        BSTNode? temp = maxValueNode(node.left);
        if (temp != null) {
          HapticFeedback.mediumImpact();
          setState(() {
            currentNodeValue = temp.value;
          });
          await Future.delayed(Duration(seconds: 1));
          HapticFeedback.mediumImpact();
          node.value = temp.value;
          node.left = await _deleteNode(node.left, temp.value);
        }
      }
    }

    HapticFeedback.mediumImpact();
    return node;
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // BST Visualization
        Container(
          height: 300,
          padding: const EdgeInsets.all(10),
          /*decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(12),
          ),*/
          child: CustomPaint(
            painter: BSTPainter(root, currentNodeValue, deletedNodeValue),
            child: Container(),
          ),
        ),

        const SizedBox(height: 20),

        Text("Deleted: ${deletedNodeValue ?? 'none'}"),

        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            "deleteNode(root, 87)",
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
              performNodeDeletion();
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

// Painter to draw the BST
class BSTPainter extends CustomPainter {
  final BSTNode? root;
  final int? highlightValue;
  final int? deletedValue;

  BSTPainter(this.root, this.highlightValue, this.deletedValue);

  @override
  void paint(Canvas canvas, Size size) {
    if (root == null) return;
    double width = size.width;
    double nodeRadius = 20;
    _drawNode(canvas, root, width / 2, 50, width / 4, nodeRadius);
  }

  void _drawNode(Canvas canvas, BSTNode? node, double x, double y, double offset, double radius) {
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

void main() => runApp(MaterialApp(home: Scaffold(body: BSTDeleteNodeAnimation())));
