import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/datastructures/array/array_page.dart';
import '../pages/home/home_page.dart';
import '../pages/profile/login/login_page.dart';
import '../pages/profile/profile_page.dart';
import '../pages/profile/settings/theme_settings_page.dart';

// A.K.A. MENU BAR

class CustomScaffold extends StatelessWidget
{
  final Widget body;
  final VoidCallback toggleTheme;
  final String? userId;
  final AppBar? appBar;

  const CustomScaffold( {
    Key? key,
    required this.body,
    required this.toggleTheme,
    required this.userId,
    this.appBar
  }) : super(key: key);

  Future<void> _handleSignOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');

    // Navigate back to LoginPage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage(toggleTheme: toggleTheme)),
    );
  }

  @override
  Widget build(BuildContext context)
  {
    bool isDarkTheme = false;
    String currentLanguage = 'en';

    return Scaffold(
      appBar: appBar ?? AppBar(),
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
                    MaterialPageRoute(builder: (context) => HomePage(toggleTheme: toggleTheme, userId: userId)),
                  );
                },
              ),
              // Profile
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () async {
                  HapticFeedback.mediumImpact();
                  Navigator.pop(context);

                  //final userProfile = await fetchUserProfile();

                  if (userId != null) {
                    // Navigate to ProfilePage with userId
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(userId: userId, toggleTheme: toggleTheme),
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
                      Navigator.pop(context); // Close the drawer
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArrayPage(toggleTheme: () {  }, userId: 'n',),
                        ),
                      );
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
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ThemeSettingsPage(
                        isDarkTheme: isDarkTheme,
                        onThemeChanged: (newValue) {
                          // Handle theme change
                        },
                        currentLanguage: currentLanguage,
                        onLanguageChanged: (newLang) {
                          // Handle language change
                        },
                      ),
                    ),
                  );
                },
              ),
              // Logout
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () async {
                  HapticFeedback.mediumImpact();
                  _handleSignOut(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: body,
    );
  }
}
