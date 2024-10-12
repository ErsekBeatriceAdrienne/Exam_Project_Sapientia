import 'package:flutter/material.dart';

class HomePage extends StatelessWidget
{
  final VoidCallback toggleTheme;

  const HomePage({required this.toggleTheme, super.key});

  @override
  Widget build(BuildContext context) {
    // Determine if the current theme is dark mode
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                // Open the drawer when the menu button is pressed
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
              color: isDarkMode ? Colors.yellow : Colors.blue,
            ),
            onPressed: () {
              toggleTheme(); // Toggle the theme
            },
          ),
        ],
      ),
      drawer: Container(
        width: 200, 
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(height: 50),
              ListTile(
                title: const Text('Array'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  // Add your navigation logic here
                },
              ),
              const SizedBox(height: 0), // Minimal space between items
              ListTile(
                title: const Text('Stack'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  // Add your navigation logic here
                },
              ),
              const SizedBox(height: 0), // Minimal space between items
              ListTile(
                title: const Text('Queue'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  // Add your navigation logic here
                },
              ),
              const SizedBox(height: 0), // Minimal space between items
              ListTile(
                title: const Text('List'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  // Add your navigation logic here
                },
              ),
              const SizedBox(height: 0), // Minimal space between items
              ListTile(
                title: const Text('Binary Tree'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  // Add your navigation logic here
                },
              ),
            ],
          ),
        ),
      ),
      body: const Center(

      ),
    );
  }
}
