import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_dsa/pages/testDatastructure/tests.dart';
import '../algorithms/algorithms_page.dart';
import '../datastructures/datastructures_page.dart';
import '../home/home_page.dart';
import '../profile/profile_page.dart';
import '../profile/settings/settings_page.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final VoidCallback toggleTheme;
  final String? userId;

  const CustomBottomNavigationBar({Key? key, required this.toggleTheme, required this.userId}) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _currentIndex = 0;
  final List<Widget> _pages = [];
  String? _username; // Username variable to hold the username

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      HomePage(toggleTheme: widget.toggleTheme, userId: widget.userId),
      DataStructuresPage(),
      AlgorithmsPage(),
      TestsPage(),
      ProfilePage(toggleTheme: widget.toggleTheme),
    ]);
    _fetchUserData(); // Fetch user data on init
  }

  // Fetch the user's data, specifically the username
  Future<void> _fetchUserData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    // Fetch the user document from Firestore
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();

    // Extract the username from the document
    final userData = userDoc.data() as Map<String, dynamic>?;
    if (userData != null) {
      setState(() {
        _username = userData['username'];
      });
    }
  }

  // Handle the navigation bar item tap
  void _onTap(int index) {
    if (index != _currentIndex) {
      HapticFeedback.heavyImpact();
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: _currentIndex == 4 && _username != null
            ? Container(
          padding: const EdgeInsets.only(left: 16.0), // Add padding here
          child: Text(_username!),
        )
            : const Text(''),
        actions: _currentIndex == 4
            ? [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ]
            : null,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, 0),
            _buildNavItem(Icons.storage, 1),
            _buildNavItem(Icons.code, 2),
            _buildNavItem(Icons.text_snippet_outlined, 3),
            _buildNavItem(Icons.person, 4),
          ],
        ),
      ),
    );
  }

  // Helper method to build the navigation items
  Widget _buildNavItem(IconData icon, int index) {
    bool isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () => _onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.pink : Colors.black,
              size: 30.0,
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
