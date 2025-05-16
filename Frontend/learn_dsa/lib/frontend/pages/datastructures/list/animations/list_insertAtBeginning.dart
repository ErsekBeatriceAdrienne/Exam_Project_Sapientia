import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LinkedListInsertAtBeginning extends StatefulWidget {
  @override
  State<LinkedListInsertAtBeginning> createState() => _LinkedListInsertAtBeginningState();
}

class _LinkedListInsertAtBeginningState extends State<LinkedListInsertAtBeginning> {
  List<int> nodes = [20, 40, 30];
  bool isInserting = false;

  void _insertNodeAtBeginning() async {
    if (isInserting) return;

    setState(() {
      isInserting = true;
    });

    await Future.delayed(Duration(milliseconds: 800));

    setState(() {
      nodes.insert(0, 10);
      isInserting = false;
    });
    isInserting = true;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double nodeSize = constraints.maxWidth / 8;
        nodeSize = nodeSize.clamp(25.0, 60.0);
        double fontSize = nodeSize * 0.4;

        return Column(
          children: [
            Expanded(
              child: Center(
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 800),
                  child: Row(
                    key: ValueKey(nodes.toString()), // Key ensures proper animation
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: nodes.asMap().entries.expand((entry) {
                      int index = entry.key;
                      int value = entry.value;
                      return [
                        _buildNode(value, nodeSize, fontSize),
                        if (index < nodes.length - 1)
                          _buildArrow(nodeSize)
                        else
                          _buildNullPointer(nodeSize),
                      ];
                    }).toList(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'insertAtBeginning(head, 10)',
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
                  isInserting ? null : _insertNodeAtBeginning();
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

  // Builds a single node for the linked list
  Widget _buildNode(int value, double size, double fontSize) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Color(0xFF255f38),
        borderRadius: BorderRadius.circular(size * 0.2),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(2, 2),
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

  // Creates an arrow between nodes to represent a linked connection
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

// --------------------------------------------------------------------------------------------

class DoublyLinkedListInsertAtBeginning extends StatefulWidget {
  @override
  State<DoublyLinkedListInsertAtBeginning> createState() => _DoublyLinkedListInsertAtBeginningState();
}

class _DoublyLinkedListInsertAtBeginningState extends State<DoublyLinkedListInsertAtBeginning> {
  List<int> nodes = [20, 40, 30];
  bool isInserting = false;

  void _insertNodeAtBeginning() async {
    if (isInserting) return;

    setState(() {
      isInserting = true;
    });

    await Future.delayed(Duration(milliseconds: 800));

    setState(() {
      nodes.insert(0, 10);
      isInserting = false;
    });
    isInserting = true;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double nodeSize = constraints.maxWidth / 10;
        nodeSize = nodeSize.clamp(30.0, 60.0);
        double fontSize = nodeSize * 0.4;

        return Column(
          children: [
            Expanded(
              child: Center(
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 800),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      key: ValueKey(nodes.toString()),
                      children: nodes.asMap().entries.map((entry) {
                        int index = entry.key;
                        int value = entry.value;
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (index == 0) _buildLeftNullPointer(nodeSize),
                            _buildNode(value, nodeSize, fontSize),
                            if (index < nodes.length - 1)
                              _buildDoubleArrow(nodeSize)
                            else
                              _buildNullPointer(nodeSize),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'insertAtBeginning(head, 10)',
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
                  isInserting ? null : _insertNodeAtBeginning();
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
        borderRadius: BorderRadius.circular(size * 0.2),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(2, 2),
          ),
        ],
      ),
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 4),
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

  Widget _buildDoubleArrow(double size) {
    double arrowSize = size * 0.6;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(3.1416),
          child: Icon(Icons.arrow_right_alt, size: arrowSize, color: Colors.black),
        ),
        Icon(Icons.arrow_right_alt, size: arrowSize, color: Colors.black),
      ],
    );
  }

  Widget _buildNullPointer(double size) {
    return Row(
      children: [
        SizedBox(width: size * 0.2),
        Container(width: size * 0.4, height: 3, color: Colors.black),
        Container(width: 3, height: size * 0.4, color: Colors.black, margin: EdgeInsets.only(left: 2)),
        SizedBox(width: size * 0.1),
        Text(
          'NULL',
          style: TextStyle(
            fontSize: size * 0.25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(width: size * 0.3),
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
        Container(width: 3, height: size * 0.4, color: Colors.black, margin: EdgeInsets.only(right: 2)),
        Container(width: size * 0.4, height: 3, color: Colors.black),
        SizedBox(width: size * 0.3),
      ],
    );
  }
}