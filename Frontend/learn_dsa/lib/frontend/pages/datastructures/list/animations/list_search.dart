import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LinkedListSearchAnimation extends StatefulWidget {
  @override
  _LinkedListSearchAnimationState createState() => _LinkedListSearchAnimationState();
}

class _LinkedListSearchAnimationState extends State<LinkedListSearchAnimation> {
  List<int> nodes = [];
  int currentIndex = 0;
  int? searchingIndex;
  bool found = false;
  final List<int> values = [30, 10, 50, 40, 20];
  bool shouldStop = false;
  bool isAnimating = false;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    nodes = List.from(values);
  }

  void _searchNode(int target) async {
    setState(() {
      found = false;
      shouldStop = false;
    });

    for (int i = searchingIndex ?? 0; i < nodes.length; i++) {
      if (shouldStop) break;

      while (isPaused) {
        await Future.delayed(Duration(milliseconds: 200));
      }

      await Future.delayed(Duration(seconds: 1));
      HapticFeedback.mediumImpact();
      if (shouldStop) break;

      setState(() {
        searchingIndex = i;
      });

      if (nodes[i] == target) {
        setState(() {
          found = true;
          isAnimating = false;
        });
        return;
      }
    }

    await Future.delayed(Duration(seconds: 1));
    setState(() {
      isAnimating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              double nodeSize = constraints.maxWidth / 10;
              nodeSize = nodeSize.clamp(25.0, 60.0);

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: nodes.asMap().entries.map((entry) {
                      int index = entry.key;
                      int value = entry.value;
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildNode(value, nodeSize, index == searchingIndex),
                          if (index < nodes.length - 1)
                            _buildArrow(nodeSize)
                          else
                            _buildNullPointer(nodeSize),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'search(head, 50)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        if (found)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'return true',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ),
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
              if (!isAnimating) {
                // Start or resume animation
                setState(() {
                  isAnimating = true;
                  isPaused = false;
                  // only reset if it's a new search
                  if (searchingIndex == null || found || searchingIndex! >= nodes.length) {
                    searchingIndex = 0;
                    found = false;
                  }
                });
                _searchNode(50);
              } else {
                // Pause the animation
                setState(() {
                  isPaused = !isPaused;
                });
              }

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
                    isAnimating
                        ? (isPaused ? Icons.play_arrow_rounded : Icons.pause)
                        : Icons.play_arrow_rounded,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    size: 24,
                  ),
                  Text(
                    isAnimating && !isPaused ? AppLocalizations.of(context)!.pause_animation_button_text : AppLocalizations.of(context)!.play_animation_button_text,
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

  Widget _buildNode(int value, double size, bool isSearching) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isSearching ? Colors.green : Color(0xFF255f38),
        borderRadius: BorderRadius.circular(size * 0.2),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(2, 2),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        value.toString(),
        style: TextStyle(
          fontSize: size * 0.4,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildArrow(double size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Icon(
        Icons.arrow_right_alt,
        color: Colors.black,
        size: size * 0.6,
      ),
    );
  }

  Widget _buildNullPointer(double size) {
    return Row(
      children: [
        SizedBox(width: size * 0.2),
        Container(width: size * 0.4, height: 3, color: Colors.black),
        Container(
          width: 3,
          height: size * 0.4,
          color: Colors.black,
          margin: EdgeInsets.only(left: 2),
        ),
        SizedBox(width: size * 0.1),
        Text(
          'NULL',
          style: TextStyle(
            fontSize: size * 0.25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
