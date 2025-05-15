import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AnimatedQueueEmptyWidget extends StatefulWidget {
  @override
  _AnimatedQueueEmptyWidgetState createState() => _AnimatedQueueEmptyWidgetState();
}

class _AnimatedQueueEmptyWidgetState extends State<AnimatedQueueEmptyWidget> {
  List<int> queue = [];
  final int capacity = 5;
  final List<int> values = [3, 5, 8, 1, 7];
  int index = 0;
  int front = -1;
  int rear = -1;
  bool isRunning = false;
  bool isPaused = false;
  bool isQueueCreated = false;
  String? isEmptyResult;
  bool showIsEmptyResult = false;


  void _checkIsEmpty() {
    setState(() {
      isEmptyResult = queue.isEmpty ? 'return true' : 'return false';
      showIsEmptyResult = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        showIsEmptyResult = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Queue visualization
        Container(
          width: 300,
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(
              capacity,
                  (i) => Container(
                width: 50,
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: i < queue.length ? Color(0xFF255f38) : Colors.grey.shade300,
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    )
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  i < queue.length ? queue[i].toString() : '',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 10),

        // Front/Rear info
        Text(
          '${AppLocalizations.of(context)!.front_text}: ${front == -1 ? "-1" : front}  | ${AppLocalizations.of(context)!.rear_text}: ${rear == -1 ? "-1" : rear}  | ${AppLocalizations.of(context)!.capacity_text}: 5',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 10),

        // Animated result of isEmpty
        Text(
          isEmptyResult ?? '',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isEmptyResult == 'return true' ? Colors.green : Colors.red,
          ),
        ),

        SizedBox(height: 10),

        // Play / Pause Button
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
              _checkIsEmpty();
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
                    isRunning
                        ? (isPaused ? Icons.play_arrow_rounded : Icons.pause)
                        : Icons.play_arrow_rounded,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    size: 24,
                  ),
                  Text(
                    isRunning && !isPaused ? AppLocalizations.of(context)!.pause_animation_button_text : AppLocalizations.of(context)!.play_animation_button_text,
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
    );
  }
}


/// ----------------------------Full----------------------------------------------------------------------

class AnimatedQueueFullWidget extends StatefulWidget {
  @override
  _AnimatedQueueFullWidgetState createState() => _AnimatedQueueFullWidgetState();
}

class _AnimatedQueueFullWidgetState extends State<AnimatedQueueFullWidget> with TickerProviderStateMixin {
  List<int> queue = [];
  final int capacity = 5;
  final List<int> values = [3, 5, 8, 1, 7];
  int index = 0;
  int front = -1;
  int rear = -1;
  bool isRunning = false;
  bool isPaused = false;
  bool isQueueCreated = false;
  String? isEmptyResult;
  bool showIsEmptyResult = false;
  late AnimationController _emptyController;
  late Animation<double> _emptyScale;

  void _checkIsFull() {
    setState(() {
      isEmptyResult = queue.length == capacity ? 'return true' : 'return false';
      showIsEmptyResult = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        showIsEmptyResult = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _emptyController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );

    _emptyScale = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _emptyController, curve: Curves.easeIn),
    );
  }

  Widget _buildQueueBox(int i) {
    bool isActive = i < queue.length;

    return AnimatedBuilder(
      animation: _emptyController,
      builder: (context, child) {
        double scale = (_emptyController.isAnimating) ? _emptyScale.value : 1.0;

        return Transform.scale(
          scale: scale,
          child: Container(
            width: 50,
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              color: isActive ? Color(0xFF255f38) : Colors.grey.shade300,
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                )
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              isActive ? queue[i].toString() : '',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Queue visualization
        Container(
          width: 300,
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(capacity, (i) => _buildQueueBox(i)),
          ),
        ),

        SizedBox(height: 10),

        // Front/Rear info
        Text(
          '${AppLocalizations.of(context)!.front_text}: ${front == -1 ? "-1" : front}  | ${AppLocalizations.of(context)!.rear_text}: ${rear == -1 ? "-1" : rear}  | ${AppLocalizations.of(context)!.capacity_text}: 5',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 10),

        // Animated result of isEmpty
        Text(
          isEmptyResult ?? '',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isEmptyResult == 'return true' ? Colors.green : Colors.red,
          ),
        ),

        SizedBox(height: 10),

        // Play / Pause Button
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
              _checkIsFull();
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
                    isRunning
                        ? (isPaused ? Icons.play_arrow_rounded : Icons.pause)
                        : Icons.play_arrow_rounded,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    size: 24,
                  ),
                  Text(
                    isRunning && !isPaused ? AppLocalizations.of(context)!.pause_animation_button_text : AppLocalizations.of(context)!.play_animation_button_text,
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
    );
  }
}
