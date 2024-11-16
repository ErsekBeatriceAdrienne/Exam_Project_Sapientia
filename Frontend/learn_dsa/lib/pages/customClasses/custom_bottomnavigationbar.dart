import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../algorithms/algorithms_page.dart';
import '../datastructures/datastructures_page.dart';
import '../home/home_page.dart';
import '../profile/profile_page.dart';
import '../profile/settings/settings_page.dart';
import '../testDatastructure/tests.dart';

class CustomBottomNavigationBar extends StatefulWidget
{
  final VoidCallback toggleTheme;
  final String? userId;

  const CustomBottomNavigationBar({
    Key? key,
    required this.toggleTheme,
    required this.userId,
  }) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
{
  int _currentIndex = 0;
  final List<Widget> _pages = [];
  String _username = 'Loading...';

  @override
  void initState()
  {
    super.initState();
    _pages.addAll([
      HomePage(toggleTheme: widget.toggleTheme, userId: widget.userId),
      DataStructuresPage(toggleTheme: widget.toggleTheme, userId: widget.userId),
      AlgorithmsPage(),
      TestsPage(),
      ProfilePage(toggleTheme: widget.toggleTheme),
    ]);
    _preloadUserName();
  }

  Future<void> _preloadUserName() async
  {
    try
    {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get(const GetOptions(source: Source.cache));

      if (!snapshot.exists)
      {
        snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userId)
            .get();
      }

      var userData = snapshot.data() as Map<String, dynamic>? ?? {};
      String username = userData['username'] ?? 'Unknown user';

      setState(() {
        _username = username;
      });
    } catch (e) {
      setState(() {
        _username = 'Error';
      });
    }
  }

  void _onTap(int index)
  {
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
      /*appBar: AppBar(
        // Profile Page appbar
        title: _currentIndex == 4 && _username != null ? Container(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(_username!))
            : _currentIndex == 1 ? Container(
            padding: const EdgeInsets.only(left: 16.0),
            child: const Text(
              "Data Structures",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
            ))
            : const Text(''),

        // Profile Page appbar action
        actions: _currentIndex == 4 ? [
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            color: Colors.white,
            onSelected: (String value) async {
              if (value == 'settings') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(),
                  ),
                );
              } else if (value == 'logout') {
                await (_pages[_currentIndex] as ProfilePage).signOut(context);
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'settings',
                child: Row(
                  children: const [
                    Icon(Icons.settings, color: Colors.pink),
                    SizedBox(width: 8),
                    Text('Settings', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'logout',
                child: Row(
                  children: const [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Logout', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
        ] : null,

      ),*/
      body: _pages[_currentIndex],

      // Bottom nav bar settings
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, 0),
            _buildNavItem(Icons.storage, 1),
            _buildNavItem(Icons.code, 2),
            _buildNavItem(Icons.terminal_rounded, 3),
            _buildNavItem(Icons.person, 4),
          ],
        ),
      ),

    );
  }

  Widget _buildNavItem(IconData icon, int index)
  {
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
              size: 31.0,
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
