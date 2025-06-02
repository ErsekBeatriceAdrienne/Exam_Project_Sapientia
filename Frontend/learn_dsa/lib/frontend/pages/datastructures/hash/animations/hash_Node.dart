import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HashNewNodeAnimation extends StatefulWidget {
  const HashNewNodeAnimation({super.key});

  @override
  _HashNewNodeAnimationState createState() =>
      _HashNewNodeAnimationState();
}

class _HashNewNodeAnimationState
    extends State<HashNewNodeAnimation> {
  List<MapEntry<int, int>> nodes = [];
  int currentIndex = 0;
  final List<MapEntry<int, int>> values = [MapEntry(0, 23)];

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
        double fontSize = nodeSize * 0.25;

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
                    MapEntry<int, int> pair = entry.value;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildNode(pair, nodeSize, fontSize),
                        if (nodes.length == 1 || index != nodes.length - 1)
                          _buildNullPointer(nodeSize),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 10),

            Text(
              'newNode(item)',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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

  Widget _buildNode(MapEntry<int, int> pair, double size, double fontSize) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: 80,
      height: 50,
      decoration: BoxDecoration(
        color:  Color(0xFF1f7d53),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Key
          Positioned(
            left: 0,
            top: 0,
            width: 80 * 0.4 - 1,
            height: 50,
            child: Center(
              child: Text(
                '${pair.key}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Value
          Positioned(
            left: 80 * 0.4 + 1,
            top: 0,
            width: 80 * 0.6 - 1,
            height: 50,
            child: Center(
              child: Text(
                '${pair.value}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // White line
          Positioned(
            left: 80 * 0.4 - 1, // 40%
            top: 50 * 0.15,
            child: Container(
              width: 2,
              height: 50 * 0.7,
              color: Colors.white,
            ),
          ),
        ],
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
