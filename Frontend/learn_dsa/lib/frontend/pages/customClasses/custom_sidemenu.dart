import 'package:flutter/material.dart';
import '../../../backend/compiler/c_compiler_page.dart';
import '../algorithms/algorithms_page.dart';
import '../datastructures/datastructures_page.dart';
import '../profile/profile_page.dart';
import '../test/tests_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WindowsMenu extends StatefulWidget {
  final VoidCallback toggleTheme;
  final String userId;

  const WindowsMenu({super.key, required this.toggleTheme, required this.userId});

  @override
  _WindowsMenuState createState() => _WindowsMenuState();
}

class _WindowsMenuState extends State<WindowsMenu> {
  int _currentIndex = 0; // Keep track of the selected page index

  // Function to update the pages list with the latest toggleTheme and userId
  List<Widget> _getPages() {
    return [
      DataStructuresPage(toggleTheme: widget.toggleTheme, userId: widget.userId),
      AlgorithmsPage(toggleTheme: widget.toggleTheme, userId: widget.userId),
      CCompilerPage(toggleTheme: widget.toggleTheme, userId: widget.userId),
      TestsPage(toggleTheme: widget.toggleTheme, userId: widget.userId),
      ProfilePage(toggleTheme: widget.toggleTheme, userId: widget.userId),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            //DrawerHeader(child: Text('Welcome, Guest')),
            ListTile(
              title: Text(AppLocalizations.of(context)!
                  .data_structures_menu),
              onTap: () {
                setState(() {
                  _currentIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!
                  .algorithms_menu),
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!
                  .compiler_menu),
              onTap: () {
                setState(() {
                  _currentIndex = 2;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!
                  .test_menu),
              onTap: () {
                setState(() {
                  _currentIndex = 3;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!
                  .profile_menu),
              onTap: () {
                setState(() {
                  _currentIndex = 4;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _getPages()[_currentIndex],
    );
  }
}
