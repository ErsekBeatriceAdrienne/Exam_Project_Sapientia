import 'package:flutter/material.dart';
import '../home_page.dart';

class CustomBottomNavigationBar extends StatefulWidget
{
  final int currentIndex;
  final Function(int) onTap;
  final Widget body;
  final VoidCallback toggleTheme;
  final String? userId;
  final AppBar? appBar;

  const CustomBottomNavigationBar( {
    Key? key,
    required this.body,
    required this.toggleTheme,
    required this.userId,
    this.appBar,
    required this.currentIndex,
    required this.onTap
  }) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
{
  void _onItemTapped(int index)
  {
    if (index == 0) {
      // Navigate to HomePage when "Home" is tapped
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage(toggleTheme: () {}, userId: "your_user_id_here")),
      );
    } else {
      // Call the parent's onTap callback for other items
      widget.onTap(index);
    }
  }
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
    );
  }
}
