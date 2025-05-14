import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AnimatedQueueDequeueWidget extends StatefulWidget {
  @override
  _AnimatedQueueDequeueWidgetState createState() => _AnimatedQueueDequeueWidgetState();
}

class _AnimatedQueueDequeueWidgetState extends State<AnimatedQueueDequeueWidget> with TickerProviderStateMixin {
  List<int> queue = [3, 5, 7, 4];
  final int capacity = 5;
  final List<int> values = [8, 1, 7, 2, 9];
  int index = 0;
  int front = 0;
  int rear = 4;

  late AnimationController _enqueueController;
  late AnimationController _dequeueController;
  late Animation<double> _enqueueScale;
  late Animation<double> _dequeueScale;

  int? dequeueIndex;

  @override
  void initState() {
    super.initState();

    _enqueueController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );

    _dequeueController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );

    _enqueueScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _enqueueController, curve: Curves.easeOutBack),
    );

    _dequeueScale = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _dequeueController, curve: Curves.easeIn),
    );

    _enqueueController.forward();
  }

  void _enqueue() {
    if (queue.length >= capacity) return;

    setState(() {
      queue.add(values[index % values.length]);
      rear = (rear + 1) % capacity;
      index++;
    });

    _enqueueController.forward(from: 0);
  }

  void _dequeue() {
    if (queue.isEmpty) return;

    setState(() {
      dequeueIndex = 0;
    });

    _dequeueController.forward(from: 0).then((_) {
      setState(() {
        queue.removeAt(0);
        dequeueIndex = null;

        if (queue.isEmpty) {
          front = rear = -1;
        } else {
          --rear;
        }
      });
    });
  }

  @override
  void dispose() {
    _enqueueController.dispose();
    _dequeueController.dispose();
    super.dispose();
  }

  Widget _buildQueueBox(int i) {
    bool isActive = i < queue.length;
    bool isNew = i == queue.length - 1;
    bool isRemoving = dequeueIndex == i;

    return AnimatedBuilder(
      animation: isRemoving ? _dequeueController : _enqueueController,
      builder: (context, child) {
        double scale = 1.0;
        if (isNew && _enqueueController.isAnimating) {
          scale = _enqueueScale.value;
        }
        if (isRemoving && _dequeueController.isAnimating) {
          scale = _dequeueScale.value;
        }

        return Transform.scale(
          scale: scale,
          child: Container(
            width: 50,
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              color: isActive ? Color(0xFFDFAEE8) : Colors.grey.shade300,
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(5),
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
    int nextValue = values[index % values.length];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Queue visualization
        Container(
          width: 300,
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(capacity, (i) => _buildQueueBox(i)),
          ),
        ),

        SizedBox(height: 10),

        // Front/Rear info
        Text(
          '${AppLocalizations.of(context)!.front_text}: ${front == -1 ? "-1" : front} | ${AppLocalizations.of(context)!.rear_text}: ${rear == -1 ? "-1" : rear} | ${AppLocalizations.of(context)!.capacity_text}: 5',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 20),

        // Enqueue and Dequeue buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: queue.isNotEmpty ? _dequeue : null,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              child: Text('dequeue(q)'),
            ),
          ],
        ),
      ],
    );
  }
}
