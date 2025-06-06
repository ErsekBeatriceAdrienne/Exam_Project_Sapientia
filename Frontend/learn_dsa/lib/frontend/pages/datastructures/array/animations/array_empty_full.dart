import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ArrayAllocationEmptyWidget extends StatefulWidget {
  const ArrayAllocationEmptyWidget({super.key});

  @override
  _ArrayAllocationEmptyWidgetState createState() => _ArrayAllocationEmptyWidgetState();
}

class _ArrayAllocationEmptyWidgetState extends State<ArrayAllocationEmptyWidget> {
  List<int?> array = [];
  int size = 0;
  final int capacity = 5;
  int index = 0;
  bool showArray = false;
  bool isAnimating = false;
  bool isPaused = false;
  bool? isEmptyResult;

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
      isEmptyResult = null;
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

                  if (i == 0) {
                    borderRadius = BorderRadius.horizontal(left: Radius.circular(12));
                  } else if (i == capacity - 1) {
                    borderRadius =
                        BorderRadius.horizontal(right: Radius.circular(12));
                  }
                  else {
                    borderRadius = BorderRadius.zero;
                  }

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

            if (isEmptyResult != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'return ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      isEmptyResult.toString(),
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

            SizedBox(height: 10),

            Container(
              width: AppLocalizations.of(context)!.play_animation_button_text.length * 20 + 20,
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
                  final result = array.every((e) => e == null);
                  setState(() {
                    isEmptyResult = result;
                  });
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
        ],
      ),
    );
  }
}

//--------------------------------------------------------------------------------------------------------------------------------------------------------

class AnimatedArrayFullWidget extends StatefulWidget {
  const AnimatedArrayFullWidget({super.key});

  @override
  _AnimatedArrayFullWidgetState createState() => _AnimatedArrayFullWidgetState();
}

class _AnimatedArrayFullWidgetState extends State<AnimatedArrayFullWidget> {
  List<int?> array = List.filled(4, null);
  int size = 4;
  final int capacity = 5;
  final List<int> values = [3, 5, 8, 4];
  bool? isFullResult;
  bool isAnimating = false;
  bool isPaused = false;

  @override
  Widget build(BuildContext context) {
    BorderSide side = BorderSide(color: Colors.white, width: 1.5);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              capacity,
                  (i) {
                BorderRadius borderRadius;

                if (i == 0) {
                  borderRadius = BorderRadius.horizontal(left: Radius.circular(12));
                } else if (i == capacity - 1)
                  borderRadius = BorderRadius.horizontal(right: Radius.circular(12));
                else
                  borderRadius = BorderRadius.zero;

                final bool isFilled = i < values.length;

                return Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: isFilled ? Color(0xFF255f38) : Colors.grey.shade300,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 8,
                        offset: Offset(4, 4),
                      ),
                    ],
                    borderRadius: borderRadius,
                    border: Border(
                      top: side,
                      bottom: side,
                      left: i == 0 ? side : BorderSide.none,
                      right: side,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    isFilled ? values[i].toString() : '',
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

          if (isFullResult != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'return ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    isFullResult.toString(),
                    style: TextStyle(
                      color: isFullResult! ? Colors.green : Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

          Container(
            width: AppLocalizations.of(context)!.play_animation_button_text.length * 20 + 20,
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
                final full = array.length == capacity && array.every((e) => e != null);
                setState(() {
                  isFullResult = full;
                });
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
      ),
    );
  }
}


