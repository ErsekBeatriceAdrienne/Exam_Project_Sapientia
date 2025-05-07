import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../strings/exercises/bst_ex.dart';
import '../test/tests_page.dart';

class BSTExercisesPage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final String? userId;

  const BSTExercisesPage({Key? key, required this.toggleTheme, required this.userId}) : super(key: key);

  @override
  State<BSTExercisesPage> createState() => _BSTExercisesPageState();
}

class _BSTExercisesPageState extends State<BSTExercisesPage> with SingleTickerProviderStateMixin {
  bool showOverlay = false;
  bool showLockedDialog = false;
  bool _isDropdownVisible = false;
  bool showArrayInfo = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // AppBar
              SliverAppBar(
                backgroundColor: Colors.transparent,
                pinned: true,
                floating: false,
                expandedHeight: 70,
                leadingWidth: 90,
                automaticallyImplyLeading: false,
                leading: TextButton.icon(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.green,
                    padding: const EdgeInsets.only(left: 8.0),
                  ),
                  onPressed: () {
                    Navigator.pop(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => TestsPage(
                          toggleTheme: widget.toggleTheme,
                          userId: widget.userId,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 20,
                  ),
                  label: const Text(
                    'Back',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 17,
                    ),
                  ),
                ),
                centerTitle: true,
                title: Text(
                  BSTExercises.title,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF255f38),
                  ),
                ),
                flexibleSpace: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
                    ),
                  ),
                ),
              ),

              // Main Content
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const SizedBox(height: 20),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}