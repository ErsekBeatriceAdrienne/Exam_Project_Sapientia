import 'package:flutter/material.dart';

// BT Node Definition
class BTNode {
  int value;
  BTNode? left, right;
  BTNode(this.value);
}

BTNode? insert(BTNode? root, int value) {
  if (root == null) return BTNode(value);

  if (root.left == null) {
    root.left = BTNode(value);
  }
  else if (root.right == null) {
    root.right = BTNode(value);
  }
  else {
    if (_countNodes(root.left) <= _countNodes(root.right)) {
      root.left = insert(root.left, value);
    } else {
      root.right = insert(root.right, value);
    }
  }

  return root;
}

int _countNodes(BTNode? node) {
  if (node == null) return 0;
  return 1 + _countNodes(node.left) + _countNodes(node.right);
}

class BTAnimation extends StatefulWidget {
  @override
  _BTAnimationState createState() => _BTAnimationState();
}

class _BTAnimationState extends State<BTAnimation> {
  BTNode? root;
  List<int> values = [20, 5, 19, 3, 87, 56, 89, 88];
  int insertCount = 0;
  bool _isRunning = true;
  bool _resetNeeded = false;

  @override
  void initState() {
    super.initState();
    _startAutoInsertion();
  }

  // Automatically insert nodes from values list with a delay
  void _startAutoInsertion() async {
    while (true) {
      if (_resetNeeded) {
        root = null;
        insertCount = 0;
        _resetNeeded = false;
      }

      if (_isRunning && insertCount < values.length) {
        int waited = 0;
        // 1 másodperces várás, de közben figyeljük, hogy _isRunning közben nem változik-e
        while (waited < 1000) {
          if (!_isRunning) {
            await Future.delayed(const Duration(milliseconds: 100));
            continue;
          }
          await Future.delayed(const Duration(milliseconds: 50));
          waited += 50;
        }

        // Ha valaki közben leállította, akkor ne szúrjunk be új elemet!
        if (!_isRunning) continue;

        setState(() {
          root = insert(root, values[insertCount]);
          insertCount++;
        });
      } else if (insertCount >= values.length) {
        // Befejeztük a beszúrást
        // Most is: várjuk meg, amíg újra elindítják
        while (!_isRunning) {
          await Future.delayed(const Duration(milliseconds: 100));
        }

        // Most már újra mehet a reset és újraindul
        await Future.delayed(const Duration(seconds: 2));
        if (!_isRunning) continue; // Ha közben megint megállították, ne reseteljük!

        setState(() {
          _resetNeeded = true;
          insertCount = 0;
        });
      } else {
        // Általános várakozás, ha szünetel
        await Future.delayed(const Duration(milliseconds: 100));
      }
    }
  }

  void _toggleAnimation() {
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            // Animated BT Visualization
            Container(
              height: 300,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(12),
              ),
              child: CustomPaint(
                painter: BTPainter(root),
                child: Container(),
              ),
            ),
          ],
        ),
        Positioned(
          top: 10,
          right: 10,
          child: ElevatedButton(
            onPressed: _toggleAnimation,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              _isRunning ? "Stop" : "Start",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

// Painter to draw the Binary Tree
class BTPainter extends CustomPainter {
  final BTNode? root;

  BTPainter(this.root);

  @override
  void paint(Canvas canvas, Size size) {
    if (root == null) return;

    double width = size.width;
    double nodeRadius = 20;

    _drawNode(canvas, root, width / 2, 50, width / 5, nodeRadius);
  }

  void _drawNode(Canvas canvas, BTNode? node, double x, double y, double offset, double radius) {
    if (node == null) return;

    Paint nodePaint = Paint()..color = Color(0xFFDFAEE8);
    Paint linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: node.value.toString(),
        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    // Draw edges to left and right children
    if (node.left != null) {
      canvas.drawLine(Offset(x, y), Offset(x - offset, y + 60), linePaint);
      _drawNode(canvas, node.left, x - offset, y + 60, offset / 1.5, radius);
    }
    if (node.right != null) {
      canvas.drawLine(Offset(x, y), Offset(x + offset, y + 60), linePaint);
      _drawNode(canvas, node.right, x + offset, y + 60, offset / 1.5, radius);
    }

    // Draw node circle
    canvas.drawCircle(Offset(x, y), radius, nodePaint);

    // Draw node value
    textPainter.paint(canvas, Offset(x - textPainter.width / 2, y - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}







// BST Node Definition
class BSTNode
{
  int value;
  BSTNode? left, right;
  BSTNode(this.value);
}

// Insert function for BST
BSTNode? insert1(BSTNode? root, int value)
{
  if (root == null) return BSTNode(value);
  if (value < root.value) root.left = insert1(root.left, value);
  else if (value > root.value) root.right = insert1(root.right, value);
  return root;
}

class BSTAnimation extends StatefulWidget {
  @override
  _BSTAnimationState createState() => _BSTAnimationState();
}

class _BSTAnimationState extends State<BSTAnimation> {
  BSTNode? root;
  List<int> values = [20 ,5, 19, 3, 87, 56, 89, 88];
  int insertCount = 0;
  bool _isRunning = true;
  bool _resetNeeded = false;

  @override
  void initState() {
    super.initState();
    _startAutoInsertion();
  }

  // Automatically insert nodes from values list with a delay
  void _startAutoInsertion() async {
    while (true) {
      if (_resetNeeded) {
        root = null;
        insertCount = 0;
        _resetNeeded = false;
      }

      if (_isRunning && insertCount < values.length) {
        int waited = 0;
        // 1 másodperces várás, de közben figyeljük, hogy _isRunning közben nem változik-e
        while (waited < 1000) {
          if (!_isRunning) {
            await Future.delayed(const Duration(milliseconds: 100));
            continue;
          }
          await Future.delayed(const Duration(milliseconds: 50));
          waited += 50;
        }

        // Ha valaki közben leállította, akkor ne szúrjunk be új elemet!
        if (!_isRunning) continue;

        setState(() {
          root = insert1(root, values[insertCount]);
          insertCount++;
        });
      } else if (insertCount >= values.length) {
        // Befejeztük a beszúrást
        // Most is: várjuk meg, amíg újra elindítják
        while (!_isRunning) {
          await Future.delayed(const Duration(milliseconds: 100));
        }

        // Most már újra mehet a reset és újraindul
        await Future.delayed(const Duration(seconds: 2));
        if (!_isRunning) continue; // Ha közben megint megállították, ne reseteljük!

        setState(() {
          _resetNeeded = true;
          insertCount = 0;
        });
      } else {
        // Általános várakozás, ha szünetel
        await Future.delayed(const Duration(milliseconds: 100));
      }
    }
  }

  void _toggleAnimation() {
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            // Animated BT Visualization
            Container(
              height: 300,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(12),
              ),
              child: CustomPaint(
                painter: BSTPainter(root),
                child: Container(),
              ),
            ),
          ],
        ),
        Positioned(
          top: 10,
          right: 10,
          child: ElevatedButton(
            onPressed: _toggleAnimation,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              _isRunning ? "Stop" : "Start",
              style: const TextStyle(color: Colors.white),
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

  BSTPainter(this.root);

  @override
  void paint(Canvas canvas, Size size) {
    if (root == null) return;

    double width = size.width;
    double nodeRadius = 20;

    _drawNode(canvas, root, width / 2, 50, width / 5, nodeRadius);
  }

  void _drawNode(Canvas canvas, BSTNode? node, double x, double y, double offset, double radius) {
    if (node == null) return;

    Paint nodePaint = Paint()..color = Color(0xFFDFAEE8);
    Paint linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: node.value.toString(),
        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    // Draw edges
    if (node.left != null) {
      canvas.drawLine(Offset(x, y), Offset(x - offset, y + 60), linePaint);
      _drawNode(canvas, node.left, x - offset, y + 60, offset / 1.5, radius);
    }
    if (node.right != null) {
      canvas.drawLine(Offset(x, y), Offset(x + offset, y + 60), linePaint);
      _drawNode(canvas, node.right, x + offset, y + 60, offset / 1.5, radius);
    }

    // Draw node circle
    canvas.drawCircle(Offset(x, y), radius, nodePaint);

    // Draw node value
    textPainter.paint(canvas, Offset(x - textPainter.width / 2, y - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}