import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_dsa/frontend/pages/test/tests_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ListExercisesPage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final String? userId;

  const ListExercisesPage({Key? key, required this.toggleTheme, required this.userId}) : super(key: key);

  @override
  State<ListExercisesPage> createState() => _ListExercisesPageState();
}

class _ListExercisesPageState extends State<ListExercisesPage> with SingleTickerProviderStateMixin {
  bool showOverlay = false;
  bool showLockedDialog = false;
  bool _isDropdownVisible = false;
  bool showArrayInfo = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // AppBar
              SliverAppBar(
                backgroundColor: Colors.transparent,
                pinned: true,
                floating: false,
                expandedHeight: 70,
                leadingWidth: 90,
                automaticallyImplyLeading: false,
                leading: TextButton.icon(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.green,
                    padding: const EdgeInsets.only(left: 8.0),
                  ),
                  onPressed: () {
                    Navigator.pop(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => TestsPage(
                          toggleTheme: widget.toggleTheme,
                          userId: widget.userId,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 20,
                  ),
                  label: const Text(
                    'Back',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 17,
                    ),
                  ),
                ),
                centerTitle: true,
                title: Text(AppLocalizations.of(context)!.list_page_title,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF255f38),
                  ),
                ),
                flexibleSpace: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
                    ),
                  ),
                ),
              ),

              // Main Content
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context)!.singly_linked_list_title,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2e7d32),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '\t\tA feladatok nehézségi sorrendben vannak rendezve. Válaszd ki, milyen szintű feladatokat szeretnél megoldani.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[800],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 12,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    // TODO: Könnyű feladatok kezelése
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF81c784), // Világoszöld
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(AppLocalizations.of(context)!.difficulty_easy),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // TODO: Közepes feladatok kezelése
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFFFB300), // Meleg sárga
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text('Közepes'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // TODO: Nehéz feladatok kezelése
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFEF5350), // Pirosas árnyalat
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text('Nehéz'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}