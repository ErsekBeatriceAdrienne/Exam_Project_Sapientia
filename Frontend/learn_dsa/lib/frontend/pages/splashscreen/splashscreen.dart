import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final String? userId;

  const SplashScreen({
    super.key,
    required this.toggleTheme,
    required this.userId,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final String title = "DSA";
  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _animations;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(title.length, (index) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      );
    });

    _animations = _controllers.map((controller) {
      return Tween<Offset>(
        begin: const Offset(0, 2),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutBack,
      ));
    }).toList();

    _startStaggeredAnimations();
  }

  Future<void> _startStaggeredAnimations() async {
    const totalSplashDuration = Duration(seconds: 9);
    const perLetterDelay = Duration(milliseconds: 200);

    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].forward();
      await Future.delayed(perLetterDelay);
    }

    final int animationTimeMs = title.length * perLetterDelay.inMilliseconds;
    final remainingTime = totalSplashDuration - Duration(milliseconds: animationTimeMs);
    await Future.delayed(remainingTime);
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(title.length, (index) {
                return SlideTransition(
                  position: _animations[index],
                  child: Text(
                    title[index],
                    style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      letterSpacing: 4,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
