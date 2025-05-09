import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_dsa/frontend/helpers/essentials.dart';
import '../../../../../backend/database/firestore_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../strings/firestore/firestore_docs.dart';
import '../binarytree_exercises.dart';
import 'binarytree_easy_results.dart';

class BSTExercisesQuestionsPage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final String? userId;

  const BSTExercisesQuestionsPage({Key? key, required this.toggleTheme, required this.userId}) : super(key: key);

  @override
  State<BSTExercisesQuestionsPage> createState() => _BSTExercisesQuestionsPageState();
}

class _BSTExercisesQuestionsPageState extends State<BSTExercisesQuestionsPage> with SingleTickerProviderStateMixin {
  bool showOverlay = false;
  bool showLockedDialog = false;
  bool showArrayInfo = false;
  final FirestoreService _firestoreService = FirestoreService();
  late Future<List<Map<String, dynamic>>> _dataFuture;
  Map<int, String> selectedAnswers = {};
  Set<int> shownHints = {};


  @override
  void initState()
  {
    super.initState();
    // bst exercise question, and responses
    _dataFuture = _firestoreService.getAllExercisesFromDocument(FirestoreDocs.bt_exercises_easy_doc);
  }

  // Return the id of the correct id
  String? isAnswerCorrect(int index, String selectedAnswer, List<Map<String, dynamic>> exerciseData) {
    final questionList = exerciseData[index]['question'] as List<dynamic>;
    final answerItems = questionList.sublist(1);

    final correctAnswer = answerItems.firstWhere(
          (answer) => answer['isCorrect'] == 'true',
      orElse: () => null,
    );

    return correctAnswer?['id'];
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
                        builder: (_) => BSTExercisesPage(
                          toggleTheme: widget.toggleTheme,
                          userId: widget.userId,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
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
                      HapticFeedback.mediumImpact();
                      setState(() {
                        selectedAnswers = {};
                        _dataFuture = _firestoreService.getAllExercisesFromDocument(
                          FirestoreDocs.bt_exercises_easy_doc,
                        );
                      });
                    },
                  ),
                ],
                centerTitle: true,
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.bt_page_title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF255f38),
                      ),
                    ),
                  ],
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
                      future: _dataFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(
                            child: Text(AppLocalizations.of(context)!.error_fetching_data),
                          );
                        }

                        final exercises = snapshot.data!;
                        final locale = Localizations.localeOf(context).languageCode;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...exercises.asMap().entries.map((entry) {
                              final index = entry.key;
                              final exerciseData = entry.value;

                              final questionList = exerciseData['question'] as List<dynamic>;
                              final questionMap = questionList[0] as Map<String, dynamic>;
                              final questionText = questionMap[locale] as String;

                              String? hintText;
                              final lastElement = questionList.last;
                              if (lastElement is Map<String, dynamic> && lastElement.containsKey('hint')) {
                                final hintMap = lastElement['hint'] as Map<String, dynamic>?;
                                hintText = hintMap?[locale];
                              }

                              final isHintPresent = hintText != null;
                              final answerItems = isHintPresent
                                  ? questionList.sublist(1, questionList.length - 1)
                                  : questionList.sublist(1);

                              final answers = answerItems.map((answer) {
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
                                          style: const TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 10),

                                        ...answers.map((answer) {
                                          final answerId = answer['id'] as String;
                                          final answerText = answer['text'] as String;
                                          final isSelected = selectedAnswers[index] == answerId;

                                          return GestureDetector(
                                            onTap: () {
                                              HapticFeedback.mediumImpact();
                                              setState(() {
                                                selectedAnswers[index] = answerId;
                                              });
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              margin: const EdgeInsets.symmetric(vertical: 6),
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: isSelected
                                                    ? const Color(0xFFc8e6c9)
                                                    : Theme.of(context).scaffoldBackgroundColor,
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(
                                                  color: isSelected
                                                      ? const Color(0xFFc8e6c9)
                                                      : Theme.of(context).scaffoldBackgroundColor,
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

                                        const SizedBox(height: 10),

                                        if (hintText != null && hintText.isNotEmpty)
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(bottom: 3.0),
                                              child: TextButton.icon(
                                                onPressed: () {
                                                  setState(() {
                                                    shownHints.add(index);
                                                    HapticFeedback.mediumImpact();
                                                  });
                                                },
                                                icon: Icon(
                                                  shownHints.contains(index)
                                                      ? Icons.lightbulb
                                                      : Icons.lightbulb_outline_rounded,
                                                  color: Colors.green,
                                                ),
                                                label: Text(
                                                  shownHints.contains(index)
                                                      ? hintText
                                                      : AppLocalizations.of(context)!.hint_button_text,
                                                  style: const TextStyle(color: Colors.green),
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),

                            const SizedBox(height: 20),

                            // Checking if all questions were answered
                            Center(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF255f38),
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                onPressed: () async {
                                  final totalQuestions = exercises.length;
                                  final answeredCount = selectedAnswers.length;

                                  if (answeredCount < totalQuestions) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(AppLocalizations.of(context)!.not_all_answered_warning),
                                        backgroundColor: Colors.redAccent,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                      ),
                                    );
                                  }
                                  // If we answered all questions
                                  else {
                                    // Saving the responses
                                    await FirestoreService().saveUserAnswers(
                                      userId: widget.userId!,
                                      selectedAnswers: selectedAnswers,
                                      collectionName: FirestoreDocs.user_answers,
                                      questionCollectionName: FirestoreDocs.bt_exercises_easy_doc,
                                      getCorrectAnswerId: (int questionIndex) {
                                        return isAnswerCorrect(
                                          questionIndex,
                                          selectedAnswers[questionIndex]!,
                                          exercises,
                                        ) ?? '';
                                      },
                                    );

                                    Navigator.pushReplacement(
                                      context,
                                      Essentials().createSlideRoute(
                                          BSTExercisesEasyResultsPage(toggleTheme: widget.toggleTheme, userId: widget.userId, selectedAnswers: selectedAnswers)
                                      ),
                                    );
                                  }
                                },
                                icon: const Icon(Icons.check_circle_outline_rounded, color: Colors.white),
                                label: Text(
                                  AppLocalizations.of(context)!.check_answers_button_text,
                                  style: const TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
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

}