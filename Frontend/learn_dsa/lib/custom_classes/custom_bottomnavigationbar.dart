import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

class _CustomBottomNavigationBarState extends State <CustomBottomNavigationBar>
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
    setState(() {
      _currentIndex = index;
    });
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
        title: _currentIndex == 4 ? FutureBuilder<String> (
          future: _fetchUserName(),
          builder: (context, snapshot)
          {
            if (snapshot.connectionState == ConnectionState.waiting) return const Text('Loading...');
            if (snapshot.hasError) return const Text('Error fetching user data.');
            return Text(snapshot.data ?? '', style: const TextStyle(fontSize: 24));
          },
        )
            : const Text(''), // Placeholder title for other pages

        // Profile page action
        actions: _currentIndex == 4 ? [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              (_pages[_currentIndex] as ProfilePage).signOut(context);
            },
          ),
        ]
            : null,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
        items: const [
          // Home
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          // Data Structures
          BottomNavigationBarItem(
            icon: Icon(Icons.storage),
            label: 'Data Structures',
          ),
          // Algorithms
          BottomNavigationBarItem(
            icon: Icon(Icons.code),
            label: 'Algorithms',
          ),
          // Settings
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          // Profile
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        iconSize: 30.0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
