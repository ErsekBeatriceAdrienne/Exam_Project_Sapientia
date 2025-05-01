import 'package:flutter/material.dart';

class SingleHashItemAnimation extends StatefulWidget {
  @override
  _SingleHashItemAnimationState createState() => _SingleHashItemAnimationState();
}

class _SingleHashItemAnimationState extends State<SingleHashItemAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _positionAnimation;

  final int hashIndex = 3;
  final int value = 23;
  final double cellWidth = 60;
  final double cellHeight = 40;

  bool _showValue = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    // Animate from top into target hash bucket
    _positionAnimation = Tween<Offset>(
      begin: Offset(0, -2),
      end: Offset((hashIndex + 1).toDouble(), 0), // Adjust to align with bucket
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward().then((_) {
      setState(() {
        _showValue = true;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildHashTable() {
    return Row(
      children: List.generate(5, (i) {
        return Container(
          width: cellWidth,
          height: cellHeight,
          margin: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.purple.shade500,
            border: Border.all(color: Colors.white),
          ),
          child: Center(child: Text(i.toString(), style: TextStyle(color: Colors.white))),
        );
      }),
    );
  }

  Widget _buildAnimatedItem() {
    return SlideTransition(
      position: _positionAnimation,
      child: Container(
        width: cellWidth,
        height: cellHeight,
        margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          color: Colors.purple.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: Text(value.toString(), style: TextStyle(color: Colors.white))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        _buildHashTable(),
        SizedBox(height: 80),
        Stack(
          children: [
            if (!_showValue) _buildAnimatedItem(),
            if (_showValue)
              Positioned(
                left: (hashIndex + 1) * (cellWidth + 10) - cellWidth,
                top: 20,
                child: Container(
                  width: cellWidth,
                  height: cellHeight,
                  decoration: BoxDecoration(
                    color: Colors.purple.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: Text(value.toString(), style: TextStyle(color: Colors.white))),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
