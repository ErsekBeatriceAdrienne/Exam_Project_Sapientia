import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AnimatedQueueDequeueWidget extends StatefulWidget {
  const AnimatedQueueDequeueWidget({super.key});

  @override
  _AnimatedQueueDequeueWidgetState createState() => _AnimatedQueueDequeueWidgetState();
}

class _AnimatedQueueDequeueWidgetState extends State<AnimatedQueueDequeueWidget> with TickerProviderStateMixin {
  List<int> queue = [3, 5, 7, 4];
  final int capacity = 5;
  final List<int> values = [8, 1, 7, 2, 9];
  int index = 0;
  int front = 0;
  int rear = 3;

  late AnimationController _dequeueController;
  late Animation<double> _dequeueScale;

  int? dequeueIndex;

  @override
  void initState() {
    super.initState();

    _dequeueController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );

    _dequeueScale = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _dequeueController, curve: Curves.easeIn),
    );
  }

  void _dequeue() {
    if (queue.isEmpty) {
      // Queue is empty, refill it
      setState(() {
        queue = [
          values[index % values.length],
          values[(index + 1) % values.length],
          values[(index + 2) % values.length],
          values[(index + 3) % values.length],
          values[(index + 4) % values.length],
        ];
        index = (index + 5) % values.length;
        front = 0;
        rear = queue.length - 1;
      });
      return;
    }

    setState(() {
      dequeueIndex = 0;
    });

    _dequeueController.forward(from: 0).then((_) {
      setState(() {
        queue.removeAt(0);
        dequeueIndex = null;

        if (queue.isEmpty) {
          front = -1;
          rear = -1;
        } else {
          front = 0;
          rear = queue.length - 1;
        }
      });
    });
  }

  @override
  void dispose() {
    _dequeueController.dispose();
    super.dispose();
  }

  Widget _buildQueueBox(int i) {
    bool isActive = i < queue.length;
    bool isRemoving = dequeueIndex == i;

    return AnimatedBuilder(
      animation: _dequeueController,
      builder: (context, child) {
        double scale = (isRemoving && _dequeueController.isAnimating) ? _dequeueScale.value : 1.0;

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
          '${AppLocalizations.of(context)!.front_text}: ${front == -1 ? "-1" : front} | '
              '${AppLocalizations.of(context)!.rear_text}: ${rear == -1 ? "-1" : rear} | '
              '${AppLocalizations.of(context)!.capacity_text}: 5',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 20),

        // Dequeue button
        Container(
          width: (queue.isEmpty ? AppLocalizations.of(context)!.start_exercise_button_text : 'dequeue(q)').length * 12 + 40,
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
              _dequeue();
              HapticFeedback.mediumImpact();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (queue.isEmpty)
                  Icon(
                    Icons.play_arrow_rounded,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                if (queue.isEmpty)
                  SizedBox(width: 6),
                Text(
                  queue.isEmpty ? AppLocalizations.of(context)!.start_exercise_button_text : 'dequeue(q)',
                  style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
