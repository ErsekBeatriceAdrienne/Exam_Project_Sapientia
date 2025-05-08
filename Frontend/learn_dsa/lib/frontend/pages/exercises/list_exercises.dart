import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_dsa/frontend/pages/test/tests_page.dart';
import 'package:learn_dsa/frontend/strings/firestore/firestore_docs.dart';
import '../../../backend/database/firestore_service.dart';
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
  bool showArrayInfo = false;
  final FirestoreService _firestoreService = FirestoreService();
  late Future<List<Map<String, dynamic>>> _dataFutureSinglyListExercises;
  final Map<int, String> selectedAnswers = {};

  @override
  void initState()
  {
    super.initState();
    // singly linked list exercise question, and responses
    _dataFutureSinglyListExercises = _firestoreService.getAllSinglyLinkedListExercises(FirestoreDocs.singlyLinkedListExercisesEasy_doc);
  }

  @override
  Widget build(BuildContext context) {
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
                  label: Text(
                    AppLocalizations.of(context)!.back_button_text,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 17,
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.refresh_rounded, color: Color(0xFF255f38)),
                    onPressed: () {
                      setState(() {
                        _dataFutureSinglyListExercises = _firestoreService.getAllSinglyLinkedListExercises(FirestoreDocs.singlyLinkedListExercisesEasy_doc);
                      });
                    },
                  ),
                ],
                centerTitle: true,
                title: Text(
                  AppLocalizations.of(context)!.list_page_title,
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
                  delegate: SliverChildListDelegate([
                    FutureBuilder<List<Map<String, dynamic>>>(
                      future: _dataFutureSinglyListExercises,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(child: Text(AppLocalizations.of(context)!.error_fetching_data));
                        }

                        final exercises = snapshot.data!;
                        final locale = Localizations.localeOf(context).languageCode;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: exercises.asMap().entries.map((entry) {
                            final index = entry.key;
                            final exerciseData = entry.value;

                            final questionList = exerciseData['question'] as List<dynamic>;
                            final questionMap = questionList[0] as Map<String, dynamic>;
                            final questionText = questionMap[locale] as String;

                            final answers = questionList.sublist(1).map((answer) {
                              final answerMap = answer as Map<String, dynamic>;
                              final textMap = answerMap['text'] as Map<String, dynamic>;
                              return {
                                'id': answerMap['id'],
                                'text': textMap[locale],
                                'isCorrect': answerMap['isCorrect'] == 'true',
                              };
                            }).toList();

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Question, and responses
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 8),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.4),
                                        spreadRadius: 1,
                                        blurRadius: 6,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        questionText,
                                        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 10),
                                      ...answers.map((answer) {
                                        final answerId = answer['id'] as String;
                                        final answerText = answer['text'] as String;
                                        final isSelected = selectedAnswers[index] == answerId;

                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedAnswers[index] = answerId;
                                            });
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(vertical: 6),
                                            padding: const EdgeInsets.all(12),
                                            // Responses background
                                            decoration: BoxDecoration(
                                              color: isSelected
                                                  ? const Color(0xFFc8e6c9)
                                                  : Theme
                                                  .of(context)
                                                  .scaffoldBackgroundColor,
                                              borderRadius: BorderRadius.circular(12),
                                              // Responses borders
                                              border: Border.all(
                                                color: isSelected ? Color(0xFFc8e6c9) : Theme
                                                    .of(context)
                                                    .scaffoldBackgroundColor,
                                                width: 2,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.4),
                                                  blurRadius: 4,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            // Response text
                                            child: Text(
                                              '$answerId) $answerText',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: isSelected ? Colors.green[900] : Colors.black,
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        );

                      },
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }



  Widget _buildCardItem(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF255f38),
              Color(0xFF27391c),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 6,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).scaffoldBackgroundColor),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            const Spacer(),
            Icon(Icons.chevron_right, color: Theme.of(context).scaffoldBackgroundColor),
          ],
        ),
      ),
    );
  }
}