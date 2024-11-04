import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget
{
  final int currentIndex;
  final Function(int) onTap;
  final Widget body;
  final VoidCallback toggleTheme;
  final String? userId;
  final AppBar? appBar;

  const CustomBottomNavigationBar(
      {
    Key? key,
    required this.body,
    required this.toggleTheme,
    required this.userId,
    this.appBar,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State < CustomBottomNavigationBar>
{
  void _onItemTapped(int index) { widget.onTap(index); }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: widget.appBar,
      body: widget.body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storage),
            label: 'Data Structures',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.code),
            label: 'Algorithms',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        iconSize: 30.0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
