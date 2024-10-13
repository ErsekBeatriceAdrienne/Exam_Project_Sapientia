import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_dsa/pages/theme_settings_page.dart';

class HomePage extends StatelessWidget
{
  final VoidCallback toggleTheme;

  const HomePage({required this.toggleTheme, super.key});

  @override
  Widget build(BuildContext context)
  {
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
      ),
      drawer: Container(
        width: 250,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(height: 50),

              // Home
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage(toggleTheme: toggleTheme)),
                  );
                },
              ),
              // Profile
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Navigator.pop(context);
                  // Add navigation logic here
                },
              ),
              // Data Structures
              ExpansionTile(
                leading: const Icon(Icons.storage),
                title: const Text('Data Structures'),
                onExpansionChanged: (isExpanded) {
                  if (isExpanded) {
                    HapticFeedback.mediumImpact(); // Haptikus visszajelzés nyitáskor
                  }
                },
                children: [

                  ListTile(
                    title: const Text('Array'),
                    onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.pop(context);
                      // Add navigation logic here
                    },
                  ),
                  ListTile(
                    title: const Text('Stack'),
                    onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.pop(context);
                      // Add navigation logic here
                    },
                  ),
                  ExpansionTile(
                    title: const Text('Queue'),
                    onExpansionChanged: (isExpanded) {
                      if (isExpanded) {
                        HapticFeedback.mediumImpact();
                      }
                    },
                    children: [

                      ListTile(
                        title: const Text('Simple Queue'),
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.pop(context);
                          // Add navigation logic here
                        },
                      ),
                      ListTile(
                        title: const Text('Circular Queue'),
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.pop(context);
                          // Add navigation logic here
                        },
                      ),
                      ListTile(
                        title: const Text('Priority Queue'),
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.pop(context);
                          // Add navigation logic here
                        },
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: const Text('List'),
                    onExpansionChanged: (isExpanded) {
                      if (isExpanded) {
                        HapticFeedback.mediumImpact();
                      }
                    },
                    children: [

                      ListTile(
                        title: const Text('Single Linked List'),
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.pop(context);
                          // Add navigation logic here
                        },
                      ),
                      ListTile(
                        title: const Text('Double Linked List'),
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.pop(context);
                          // Add navigation logic here
                        },
                      ),
                      ListTile(
                        title: const Text('Sorted List'),
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.pop(context);
                          // Add navigation logic here
                        },
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: const Text('Tree'),
                    onExpansionChanged: (isExpanded) {
                      if (isExpanded) {
                        HapticFeedback.mediumImpact(); // Haptikus visszajelzés nyitáskor
                      }
                    },
                    children: [

                      ListTile(
                        title: const Text('Binary Search Tree'),
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.pop(context);
                          // Add navigation logic here
                        },
                      ),
                      ListTile(
                        title: const Text('Black and Red Tree'),
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.pop(context);
                          // Add navigation logic here
                        },
                      ),
                    ],
                  ),
                  ListTile(
                    title: const Text('Hash Set'),
                    onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.pop(context);
                      // Add navigation logic here
                    },
                  ),
                  ListTile(
                    title: const Text('Hash Table'),
                    onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.pop(context);
                      // Add navigation logic here
                    },
                  ),
                  ExpansionTile(
                    title: const Text('Graphs'),
                    onExpansionChanged: (isExpanded) {
                      if (isExpanded) {
                        HapticFeedback.mediumImpact();
                      }
                    },
                    children: [

                      ListTile(
                        title: const Text('Undirected Graph'),
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.pop(context);
                          // Add navigation logic here
                        },
                      ),
                      ListTile(
                        title: const Text('Directed Graph'),
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.pop(context);
                          // Add navigation logic here
                        },
                      ),
                      ListTile(
                        title: const Text('Even Graph'),
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.pop(context);
                          // Add navigation logic here
                        },
                      ),
                    ],
                  ),
                ],
              ),
              ExpansionTile(
                leading: const Icon(Icons.code),
                title: const Text('Algorithms'),
                onExpansionChanged: (isExpanded) {
                  if (isExpanded) {
                    HapticFeedback.mediumImpact();
                  }
                },
                children: [
                  ExpansionTile(
                    title: const Text('Sort'),
                    onExpansionChanged: (isExpanded) {
                      if (isExpanded) {
                        HapticFeedback.mediumImpact();
                      }
                    },
                    children: [

                      ListTile(
                        title: const Text('Quick Sort'),
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.pop(context);
                          // Add navigation logic here
                        },
                      ),
                      ListTile(
                        title: const Text('Bubble Sort'),
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.pop(context);
                          // Add navigation logic here
                        },
                      ),
                      ListTile(
                        title: const Text('Merge Sort'),
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.pop(context);
                          // Add navigation logic here
                        },
                      ),
                      ListTile(
                        title: const Text('Insertion Sort'),
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.pop(context);
                          // Add navigation logic here
                        },
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: const Text('Search'),
                    onExpansionChanged: (isExpanded) {
                      if (isExpanded) {
                        HapticFeedback.mediumImpact();
                      }
                    },
                    children: [

                      ListTile(
                        title: const Text('Linear Search'),
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.pop(context);
                          // Add navigation logic here
                        },
                      ),
                      ListTile(
                        title: const Text('Binary Search'),
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.pop(context);
                          // Add navigation logic here
                        },
                      ),
                      ListTile(
                        title: const Text('Hash Table'),
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.pop(context);
                          // Add navigation logic here
                        },
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: const Text('Graph Algorithms'),
                    onExpansionChanged: (isExpanded) {
                      if (isExpanded) {
                        HapticFeedback.mediumImpact();
                      }
                    },
                    children: [
                      ListTile(
                        title: const Text('Breadth First Search'),
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.pop(context);
                          // Add navigation logic here
                        },
                      ),
                      ListTile(
                        title: const Text('Depth First Search'),
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.pop(context);
                          // Add navigation logic here
                        },
                      ),
                      ListTile(
                        title: const Text('Dijkstra'),
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.pop(context);
                          // Add navigation logic here
                        },
                      ),
                      ListTile(
                        title: const Text('Kruskal'),
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.pop(context);
                          // Add navigation logic here
                        },
                      ),
                    ],
                  ),
                ],
              ),
              // Theme
              ListTile(
                leading: const Icon(Icons.color_lens),
                title: const Text('Theme Settings'),
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ThemeSettingsPage()),
                  );
                },
              ),
              // Logout
              ListTile(
                leading: const Icon(Icons.logout), // Logout ikon hozzáadása
                title: const Text('Logout'),
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Navigator.pop(context);
                  // Add navigation logic here (például kijelentkezés logika)
                },
              ),
            ],
          ),
        ),
      ),
      body: const Center(),
    );
  }
}


