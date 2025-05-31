import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HashCodeAnimation extends StatefulWidget {
  const HashCodeAnimation({super.key});

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
                      color: Color(0xFF255f38),
                    ),
                  ) : SizedBox.shrink(),
                ),
              ],
            ),
          SizedBox(height: 10),

          Text(
            'hashCode(5)',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 10),

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
                _startAnimation();
                HapticFeedback.mediumImpact();
              },
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              constraints: const BoxConstraints.tightFor(width: 45, height: 45),
              child: Center(
                child : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.play_arrow_rounded,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      size: 24,
                    ),
                    Text(
                      AppLocalizations.of(context)!.play_animation_button_text,
                      style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------------------------------------------------------------------------------------------------------

class HashCode2Animation extends StatefulWidget {
  const HashCode2Animation({super.key});

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