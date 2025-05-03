import 'package:flutter/material.dart';

class HashCodeAnimation extends StatefulWidget {
  @override
  _HashCodeAnimationState createState() => _HashCodeAnimationState();
}

class _HashCodeAnimationState extends State<HashCodeAnimation> {
  final int key = 0;
  final int capacity = 5;
  int? hashCodeResult;
  bool _showCalculation = false;

  void _startAnimation() {
    setState(() {
      _showCalculation = true;
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          hashCodeResult = key % capacity;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_showCalculation)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$key % $capacity', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: hashCodeResult != null ? Text('= $hashCodeResult',
                    key: ValueKey(hashCodeResult),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ) : SizedBox.shrink(),
                ),
              ],
            ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: _startAnimation,
            child: Text('hash_code($key)'),
          ),
        ],
      ),
    );
  }


}
