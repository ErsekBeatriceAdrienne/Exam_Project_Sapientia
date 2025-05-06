import 'package:flutter/material.dart';
import '../algorithms/algorithms_page.dart';
import '../datastructures/datastructures_page.dart';
import '../home/home_page.dart';
import '../profile/profile_page.dart';
import '../test/tests_page.dart';

class WindowsMenu extends StatefulWidget {
  final VoidCallback toggleTheme;
  final String userId;

  const WindowsMenu({Key? key, required this.toggleTheme, required this.userId}) : super(key: key);

  @override
  _WindowsMenuState createState() => _WindowsMenuState();
}

class _WindowsMenuState extends State<WindowsMenu> {
  int _currentIndex = 0; // Keep track of the selected page index

  // Function to update the pages list with the latest toggleTheme and userId
  List<Widget> _getPages() {
    return [
      HomePage(toggleTheme: widget.toggleTheme, userId: widget.userId),
      DataStructuresPage(toggleTheme: widget.toggleTheme, userId: widget.userId),
      AlgorithmsPage(toggleTheme: widget.toggleTheme, userId: widget.userId),
      TestsPage(toggleTheme: widget.toggleTheme, userId: widget.userId),
      ProfilePage(toggleTheme: widget.toggleTheme),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(child: Text('Welcome, Guest')),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                setState(() {
                  _currentIndex = 0; // Set index to HomePage
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text('Data Structures'),
              onTap: () {
                setState(() {
                  _currentIndex = 1; // Set index to DataStructuresPage
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text('Algorithms'),
              onTap: () {
                setState(() {
                  _currentIndex = 2; // Set index to AlgorithmsPage
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text('Tests'),
              onTap: () {
                setState(() {
                  _currentIndex = 3; // Set index to TestsPage
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                setState(() {
                  _currentIndex = 4; // Set index to ProfilePage
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
      body: _getPages()[_currentIndex], // Display the current page
    );
  }
}
