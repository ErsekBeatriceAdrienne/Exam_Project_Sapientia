import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ArrayAllocationWidget extends StatefulWidget {
  @override
  _ArrayAllocationWidgetState createState() => _ArrayAllocationWidgetState();
}

class _ArrayAllocationWidgetState extends State<ArrayAllocationWidget> {
  List<int?> array = [];
  int size = 0;
  final int capacity = 5;
  int index = 0;
  bool showArray = false;
  bool isAnimating = false;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    _createEmptyArray();
  }

  void _createEmptyArray() {
    setState(() {
      array = List.filled(capacity, null);
      size = 0;
      index = 0;
      showArray = true;
      isAnimating = false;
      isPaused = false;
    });
  }

  @override
  void dispose() {
    isAnimating = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showArray) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                capacity,
                    (i) {
                  BorderRadius borderRadius;

                  if (i == 0)
                    borderRadius = BorderRadius.horizontal(left: Radius.circular(12));
                  else if (i == capacity - 1)
                    borderRadius = BorderRadius.horizontal(right: Radius.circular(12));
                  else
                    borderRadius = BorderRadius.zero;

                  return Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: array[i] != null ? Color(0xFF006a42) : Colors.grey.shade300,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 8,
                          offset: Offset(4, 4),
                        ),
                      ],
                      borderRadius: borderRadius,
                      border: Border(
                        top: BorderSide(color: Colors.white, width: 1.5),
                        bottom: BorderSide(color: Colors.white, width: 1.5),
                        left: i == 0 ? BorderSide(color: Colors.white, width: 1.5) : BorderSide.none,
                        right: BorderSide(color: Colors.white, width: 1.5),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      array[i]?.toString() ?? '',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 10),
            Text(
              '${AppLocalizations.of(context)!.size_text}: $size | ${AppLocalizations.of(context)!.capacity_text}: $capacity',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                AppLocalizations.of(context)!.array_allocate_function_call,
                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1f7d53)),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
