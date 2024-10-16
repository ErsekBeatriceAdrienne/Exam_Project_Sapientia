import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_dsa/pages/profile_page.dart';
import 'package:learn_dsa/pages/theme_settings_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget
{
  final VoidCallback toggleTheme;
  final String? userId;

  const HomePage({Key? key, required this.toggleTheme, required this.userId}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  bool isDarkMode = false; // This is the theme mode state
  ThemeMode _themeMode = ThemeMode.light; // Initial theme mode
  Color _highlightColor = Colors.blue; // Default highlight color

  void _toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
    widget.toggleTheme(); // Call the external toggle
  }

  void _changeSeedColor(Color newColor) {
    setState(() {
      _highlightColor = newColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 50),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                HapticFeedback.mediumImpact();
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage(toggleTheme: widget.toggleTheme, userId: widget.userId)),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                HapticFeedback.mediumImpact();
                Navigator.pop(context);
                if (widget.userId != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(userId: widget.userId),
                    ),
                  );
                }
              },
            ),
            // Data Structures
            ExpansionTile(
              leading: const Icon(Icons.storage),
              title: const Text('Data Structures'),
              onExpansionChanged: (isExpanded) {
                if (isExpanded) {
                  HapticFeedback.mediumImpact();
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
                      HapticFeedback.mediumImpact();
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
            ListTile(
              leading: const Icon(Icons.color_lens),
              title: const Text('Theme Settings'),
              onTap: () {
                HapticFeedback.mediumImpact();
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ThemeSettingsPage(
                      isDarkMode: _themeMode == ThemeMode.dark,
                      onThemeChanged: _toggleTheme,
                      onHighlightColorChanged: _changeSeedColor,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                HapticFeedback.mediumImpact();
                await Supabase.instance.client.auth.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(toggleTheme: widget.toggleTheme),
                  ),
                      (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(),
    );
  }
}
