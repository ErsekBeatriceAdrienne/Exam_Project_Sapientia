import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LinkedListNewNodeAnimation extends StatefulWidget {
  @override
  _LinkedListNewNodeAnimationState createState() => _LinkedListNewNodeAnimationState();
}

class _LinkedListNewNodeAnimationState extends State<LinkedListNewNodeAnimation> {
  List<int> nodes = [];
  int currentIndex = 0;
  final List<int> values = [10];
  bool isAnimating = false;
  bool isPaused = false;
  bool showText = false;

  void _addNextNode() {
    if (currentIndex < values.length) {
      setState(() {
        showText = true;
        nodes.add(values[currentIndex]);
        currentIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double nodeSize = constraints.maxWidth / 8;
        nodeSize = nodeSize.clamp(25.0, 60.0);
        double fontSize = nodeSize * 0.4;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: EdgeInsets.all(16),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  runSpacing: 10,
                  children: nodes.asMap().entries.map((entry) {
                    int index = entry.key;
                    int value = entry.value;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildNode(value, nodeSize, fontSize),
                        if (nodes.length == 1 || index != nodes.length - 1)
                          _buildNullPointer(nodeSize),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 8),
            if (showText)
              Text(
                'newNode(10)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            SizedBox(height: 8),
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
                  _addNextNode();
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
      },
    );
  }

  Widget _buildNode(int value, double size, double fontSize) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Color(0xFF255f38),
        borderRadius: BorderRadius.circular(size * 0.35),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(4, 4),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        value.toString(),
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildNullPointer(double nodeSize) {
    return Row(
      children: [
        SizedBox(width: nodeSize * 0.15),
        Container(width: nodeSize * 0.4, height: 4, color: Colors.black),
        Container(
          width: 4,
          height: nodeSize * 0.4,
          color: Colors.black,
          margin: EdgeInsets.only(left: 2),
        ),
        SizedBox(width: nodeSize * 0.1),
        Text(
          'NULL',
          style: TextStyle(
            fontSize: nodeSize * 0.25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}



//----------------------------------------------------------------------------------------------------------------------------------

class DoublyLinkedListNewNodeAnimation extends StatefulWidget {
  @override
  _DoublyLinkedListNewNodeAnimationState createState() => _DoublyLinkedListNewNodeAnimationState();
}

class _DoublyLinkedListNewNodeAnimationState extends State<DoublyLinkedListNewNodeAnimation> {
  List<int> nodes = [];
  int currentIndex = 0;
  final List<int> values = [10];

  void _addNextNode() {
    if (currentIndex < values.length) {
      setState(() {
        nodes.add(values[currentIndex]);
        currentIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double nodeSize = constraints.maxWidth / 8;
        nodeSize = nodeSize.clamp(25.0, 60.0);
        double fontSize = nodeSize * 0.4;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: EdgeInsets.all(16),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  runSpacing: 10,
                  children: nodes.asMap().entries.map((entry) {
                    int index = entry.key;
                    int value = entry.value;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (index == 0) _buildLeftNullPointer(nodeSize),
                        _buildNode(value, nodeSize, fontSize),
                        if (index == 0) _buildNullPointer(nodeSize),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'newNode(10)',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
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
                  _addNextNode();
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
      },
    );
  }

  Widget _buildNode(int value, double size, double fontSize) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Color(0xFF255f38),
        borderRadius: BorderRadius.circular(size * 0.35),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(4, 4),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        value.toString(),
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildLeftNullPointer(double nodeSize) {
    return Row(
      children: [
        Text(
          'NULL',
          style: TextStyle(
            fontSize: nodeSize * 0.25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(width: nodeSize * 0.1),
        Container(
          width: 4,
          height: nodeSize * 0.4,
          color: Colors.black,
          margin: EdgeInsets.only(right: 2),
        ),
        Container(width: nodeSize * 0.4, height: 4, color: Colors.black),
        SizedBox(width: nodeSize * 0.15),
      ],
    );
  }

  Widget _buildNullPointer(double nodeSize) {
    return Row(
      children: [
        SizedBox(width: nodeSize * 0.15),
        Container(width: nodeSize * 0.4, height: 4, color: Colors.black),
        Container(
          width: 4,
          height: nodeSize * 0.4,
          color: Colors.black,
          margin: EdgeInsets.only(left: 2),
        ),
        SizedBox(width: nodeSize * 0.1),
        Text(
          'NULL',
          style: TextStyle(
            fontSize: nodeSize * 0.25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
