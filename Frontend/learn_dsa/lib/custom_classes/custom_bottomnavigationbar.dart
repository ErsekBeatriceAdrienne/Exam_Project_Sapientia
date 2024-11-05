import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../pages/algorithms/algorithms_page.dart';
import '../pages/datastructures/datastructures_page.dart';
import '../pages/home/home_page.dart';
import '../pages/profile/profile_page.dart';
import '../pages/settings/settings_page.dart';

class CustomBottomNavigationBar extends StatefulWidget
{
  final VoidCallback toggleTheme;
  final String? userId;

  const CustomBottomNavigationBar({Key? key, required this.toggleTheme, required this.userId}) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
{
  int _currentIndex = 0;
  final List<Widget> _pages = [];

  @override
  void initState()
  {
    super.initState();
    _pages.addAll([
      HomePage(toggleTheme: widget.toggleTheme, userId: widget.userId),
      DataStructuresPage(),
      AlgorithmsPage(),
      SettingsPage(),
      ProfilePage(toggleTheme: widget.toggleTheme),
    ]);
  }

  void _onTap(int index)
  {
    if (index != _currentIndex)
    {
      HapticFeedback.heavyImpact();
      setState(() {
        _currentIndex = index;
      });
    }
  }

  Future<String> _fetchUserName() async
  {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(widget.userId).get();

    if (!snapshot.exists) return 'User does not exist.';

    var userData = snapshot.data() as Map<String, dynamic>;
    String firstName = userData['firstName'] ?? 'FirstName';
    String lastName = userData['lastName'] ?? 'LastName';

    return '$firstName $lastName';
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(

        // Profile Page appbar
        title: _currentIndex == 4 ? FutureBuilder<String>(
          future: _fetchUserName(),
          builder: (context, snapshot)
          {
            if (snapshot.connectionState == ConnectionState.waiting) return const Text('Loading...');
            if (snapshot.hasError) return const Text('Error fetching user data.');
            return Text(snapshot.data ?? '', style: const TextStyle(fontSize: 24));
          },
        )
            : const Text(''), // Placeholder title for other pages

        // Profile Page appbar action
        actions: _currentIndex == 4 ?
        [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              (_pages[_currentIndex] as ProfilePage).signOut(context);
            },
          ),
        ] : null,
      ),

      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        color: Colors.white, // Set the background color
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, 0),
            _buildNavItem(Icons.storage, 1),
            _buildNavItem(Icons.code, 2),
            _buildNavItem(Icons.settings, 3),
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
              size: 30.0,
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
