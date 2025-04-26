import 'package:flutter/material.dart';

class ArrayAllocationWidget extends StatefulWidget {
  @override
  _ArrayAllocationWidgetState createState() => _ArrayAllocationWidgetState();
}

class _ArrayAllocationWidgetState extends State<ArrayAllocationWidget> {
  List<int?> array = [];
  int size = 0;
  final int capacity = 5;
  bool showArray = false;

  void _createEmptyArray() {
    setState(() {
      array = List.filled(capacity, null);
      size = 0;
      showArray = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _createEmptyArray,
            child: Text('createArray(5)'),
          ),

          SizedBox(height: 20),

          if (showArray) ...[
            // Tömb kirajzolása
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                capacity,
                    (i) => Container(
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 1),
                  decoration: BoxDecoration(
                    color: array[i] != null ? Color(0xFFDFAEE8) : Colors.grey.shade300,
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    array[i]?.toString() ?? '',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),

            Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  width: capacity * 54.0,
                  height: 2,
                  color: Colors.grey,
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: size * 54.0,
                  height: 2,
                  color: Colors.black,
                ),
              ],
            ),

            SizedBox(height: 5),

            Text(
              'Size: $size     |     Capacity: $capacity',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ],
      ),
    );
  }

}

