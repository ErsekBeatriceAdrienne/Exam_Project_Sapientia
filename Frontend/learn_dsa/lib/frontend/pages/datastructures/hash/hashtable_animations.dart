import 'package:flutter/material.dart';
import 'dart:math';

class HashTableAnimation extends StatefulWidget {
  @override
  _HashTableAnimationState createState() => _HashTableAnimationState();
}

class _HashTableAnimationState extends State<HashTableAnimation> {
  List<int?> hashTable = List.filled(7, null); // Hash table with size 7
  List<int> values = [];
  int insertCount = 0;
  final int maxValues = 7;
  final int tableSize = 7;

  @override
  void initState() {
    super.initState();
    _startAutoInsertion();
  }

  // Automatically insert values with a delay
  void _startAutoInsertion() async {
    while (insertCount < maxValues) {
      await Future.delayed(const Duration(seconds: 1));
      int newValue = Random().nextInt(100);

      setState(() {
        values.add(newValue);
        _insertValue(newValue);
        insertCount++;
      });
    }
  }

  // Insert value into hash table with simple modulo hashing
  void _insertValue(int value) {
    int index = value % tableSize;
    while (hashTable[index] != null) {
      // Linear probing for collision resolution
      index = (index + 1) % tableSize;
    }
    hashTable[index] = value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Animated Hash Table Visualization
        Container(
          height: 300,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomPaint(
            painter: HashTablePainter(hashTable),
            child: Container(),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

// Painter to draw the Hash Table
class HashTablePainter extends CustomPainter {
  final List<int?> hashTable;

  HashTablePainter(this.hashTable);

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;
    double cellWidth = width / hashTable.length;

    Paint cellPaint = Paint()
      ..color = Colors.deepPurpleAccent
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    Paint borderPaint = Paint()
      ..color = Colors.black26
      ..style = PaintingStyle.stroke;

    Paint textPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Draw the table cells with rounded corners and shadow
    for (int i = 0; i < hashTable.length; i++) {
      double x = i * cellWidth;
      double y = 0;
      Rect cellRect = Rect.fromLTWH(x, y, cellWidth, height);

      // Apply rounded corners and shadow
      canvas.drawRRect(RRect.fromRectAndRadius(cellRect, Radius.circular(8)), cellPaint);
      canvas.drawRRect(RRect.fromRectAndRadius(cellRect, Radius.circular(8)), borderPaint);

      // Draw the values inside the cells
      if (hashTable[i] != null) {
        TextPainter textPainter = TextPainter(
          text: TextSpan(
            text: hashTable[i].toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        // Center the text in the cell
        textPainter.paint(
            canvas, Offset(x + (cellWidth - textPainter.width) / 2, height / 2 - textPainter.height / 2));
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
