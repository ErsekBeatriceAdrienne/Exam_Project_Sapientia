import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DoublyLinkedListBackwardTraversalAnimation extends StatefulWidget {
  @override
  _DoublyLinkedListBackwardTraversalAnimationState createState() =>
      _DoublyLinkedListBackwardTraversalAnimationState();
}

class _DoublyLinkedListBackwardTraversalAnimationState
    extends State<DoublyLinkedListBackwardTraversalAnimation> {
  final List<int> values = [30, 10, 50, 40, 20];
  List<int> nodes = [];
  int traversalIndex = -1;
  bool isTraversing = false;
  String traversalOutput = '';
  bool isForwardTraversal = true;
  List<int> traversedNodes = [];

  @override
  void initState() {
    super.initState();
    nodes = List.from(values); // Initial node values
  }

  void _startBackwardTraversal() {
    if (isTraversing || nodes.isEmpty) return;

    setState(() {
      isTraversing = true;
      traversalIndex = nodes.length - 1;
      traversedNodes = [nodes[nodes.length - 1]];
      traversalOutput = 'Backward traversal started: ${nodes[traversalIndex]}';
      isForwardTraversal = false;
    });

    HapticFeedback.mediumImpact();

    Timer.periodic(Duration(seconds: 1), (timer) {
      if (traversalIndex > 0) {
        setState(() {
          traversalIndex--;
          traversedNodes.add(nodes[traversalIndex]);
          traversalOutput = 'Backward Traversing: ${nodes[traversalIndex]}';
        });
      } else {
        timer.cancel();
        setState(() {
          traversalIndex = -1;
          isTraversing = false;
          traversalOutput = 'Backward traversal completed.';
        });
      }
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
                          if (index > 0) _buildDoubleArrow(nodeSize),
                          if (index == 0) _buildLeftNullPointer(nodeSize),
                          _buildNode(value, nodeSize, index == traversalIndex),
                          if (index == nodes.length - 1) _buildNullPointer(nodeSize),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Elements: ${traversedNodes.join(', ')}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
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
              _startBackwardTraversal();
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
    );
  }

  Widget _buildNode(int value, double size, bool isHighlighted) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isHighlighted ? Colors.green : Color(0xFF255f38),
        borderRadius: BorderRadius.circular(size * 0.2),
        border: Border.all(color: isHighlighted ? Colors.white : Colors.white, width: 2),
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

  Widget _buildDoubleArrow(double size) {
    double arrowSize = size * 0.6;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(3.1416),
          child: Icon(
            Icons.arrow_right_alt,
            color: Colors.black,
            size: arrowSize,
          ),
        ),
        Icon(
          Icons.arrow_right_alt,
          color: Colors.black,
          size: arrowSize,
        ),
      ],
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

  Widget _buildLeftNullPointer(double size) {
    return Row(
      children: [
        Text(
          'NULL',
          style: TextStyle(
            fontSize: size * 0.25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(width: size * 0.1),
        Container(
          width: 3,
          height: size * 0.4,
          color: Colors.black,
          margin: EdgeInsets.only(right: 2),
        ),
        Container(width: size * 0.4, height: 3, color: Colors.black),
        SizedBox(width: size * 0.2),
      ],
    );
  }
}