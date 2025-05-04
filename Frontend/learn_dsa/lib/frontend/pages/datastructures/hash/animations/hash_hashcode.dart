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

// ------------------------------------------------------------------------------------------------------------------------------------------------------------

class HashCode2Animation extends StatefulWidget {
  @override
  _HashCode2AnimationState createState() => _HashCode2AnimationState();
}

class _HashCode2AnimationState extends State<HashCode2Animation> {
  final int key = 13;
  final int capacity = 13;
  List<String> steps = [];
  int? finalResult;
  int visibleSteps = 0;

  void _startAnimation() async {
    steps.clear();
    finalResult = null;
    visibleSteps = 0;
    setState(() {});

    int sum = 0;
    int factor = 31;
    int k = key;

    while (k != 0) {
      int digit = k % 10;
      int stepResult = (digit * factor) % capacity;
      sum = (sum + stepResult) % capacity;

      steps.add(
          'Digit: $digit, Factor: $factor, (digit × factor) % $capacity = $stepResult, sum = $sum');
      factor = (factor * 31) % 32767;
      k ~/= 10;

      visibleSteps++;
      setState(() {});
      await Future.delayed(Duration(seconds: 1));
    }

    finalResult = sum;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
        Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (finalResult != null)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'return $finalResult',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startAnimation,
              child: Text('hashCode($key)'),
            ),
          ],
        ),
      ),
    );
  }
}