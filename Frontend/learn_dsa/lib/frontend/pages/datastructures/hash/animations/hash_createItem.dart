import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../strings/datastructure_strings/hashtable_strings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SingleHashItemAnimation extends StatefulWidget {
  const SingleHashItemAnimation({super.key});

  @override
  _SingleHashItemAnimationState createState() =>
      _SingleHashItemAnimationState();
}

class _SingleHashItemAnimationState extends State<SingleHashItemAnimation> {
  final int key = 0;
  final int value = 23;
  final double cellWidth = 80;
  final double cellHeight = 50;

  bool _showValue = false;

  void _showItem() {
    setState(() {
      _showValue = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (_showValue)
          Center(
            child: Container(
              width: cellWidth,
              height: cellHeight,
              decoration: BoxDecoration(
                color: Color(0xFF1f7d53),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.white, // White border around the whole cell
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4.0,
                    offset: Offset(4, 4), // Shadow position
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Key
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF1f7d53),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          key.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // White line between Key and Value
                  Container(
                    width: 2,
                    height: cellHeight * 0.7, // Shortened height of the line
                    color: Colors.white,
                  ),
                  // Value
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF1f7d53),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          value.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

        SizedBox(height: 10),

        Text(
          'createItem(0, 23)',
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
              _showValue ? null : _showItem();
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
}
