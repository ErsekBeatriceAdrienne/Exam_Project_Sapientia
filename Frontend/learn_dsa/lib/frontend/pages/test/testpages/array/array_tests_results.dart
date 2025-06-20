import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../backend/database/firestore_service.dart';
import '../../../../strings/firestore/firestore_docs.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../bst_testpage.dart';

class ArrayTestEasyResultsPage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final String? userId;
  final Map<int, String>? selectedAnswers;

  const ArrayTestEasyResultsPage({super.key, required this.toggleTheme, required this.userId, required this.selectedAnswers});

  @override
  State<ArrayTestEasyResultsPage> createState() => _ArrayTestEasyResultsPageState();
}

class _ArrayTestEasyResultsPageState extends State<ArrayTestEasyResultsPage> with SingleTickerProviderStateMixin {
  final FirestoreService _firestoreService = FirestoreService();
  late Future<List<Map<String, dynamic>>> _dataFuture;
  late Map<int, String> selectedAnswers;

  @override
  void initState() {
    super.initState();
    _dataFuture = _firestoreService.getAllExercisesFromDocument(FirestoreDocs.array_tests_doc);
  }

  bool isAnswerCorrect(int index, String selectedAnswer, List<Map<String, dynamic>> exerciseData) {
    final questionList = exerciseData[index]['question'] as List<dynamic>;
    final answerItems = questionList.sublist(1);

    final correctAnswer = answerItems.firstWhere((answer) => answer['isCorrect'] == 'true', orElse: () => null);

    if (correctAnswer != null) {
      return correctAnswer['id'] == selectedAnswer;
    } else return false;

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
                        builder: (_) =>
                            BSTTestPage(
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
                centerTitle: true,
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.results_title,
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
                      color: Theme
                          .of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(0.2),
                    ),
                  ),
                ),
              ),

              // Main content
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

                              // Safe access for 'question' and 'answer'
                              final questionList = exerciseData['question'] as List<dynamic>?;
                              if (questionList == null || questionList.isEmpty) {
                                return Container(); // Handle null or empty question
                              }

                              final questionMap = questionList[0] as Map<String, dynamic>?;
                              if (questionMap == null) {
                                return Container(); // Handle null question
                              }

                              final questionText = questionMap[locale] as String? ?? "Unknown question text";

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
                                final answerMap = answer as Map<String, dynamic>?;
                                if (answerMap == null) return {}; // Skip null answers

                                final textMap = answerMap['text'] as Map<String, dynamic>?;
                                return {
                                  'id': answerMap['id'],
                                  'text': textMap?[locale] ?? "Unknown answer text",
                                  'isCorrect': answerMap['isCorrect'] == 'true',
                                };
                              }).toList();

                              // Check the selected answer for this question
                              final selectedAnswer = widget.selectedAnswers?[index] ?? "";
                              final isCorrect = isAnswerCorrect(index, selectedAnswer, exercises);

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
                                          final isSelected = selectedAnswer == answerId;
                                          //final isAnswerCorrectOne = answer['isCorrect'] == true;

                                          // Design
                                          Color? backgroundColor;
                                          Color borderColor = Theme.of(context).scaffoldBackgroundColor;
                                          Color textColor = Colors.black;

                                          if (isSelected && !isCorrect) {
                                            backgroundColor = Colors.red[100];
                                            borderColor = Colors.red[100]!;
                                            textColor = Colors.red[900]!;
                                          } else if (isSelected && isCorrect) {
                                            backgroundColor = const Color(0xFFc8e6c9);
                                            borderColor = const Color(0xFFc8e6c9);
                                            textColor = Colors.green[900]!;
                                          }

                                          return Container(
                                            width: double.infinity,
                                            margin: const EdgeInsets.symmetric(vertical: 6),
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
                                              borderRadius: BorderRadius.circular(12),
                                              border: Border.all(
                                                color: borderColor,
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
                                                color: textColor,
                                              ),
                                            ),
                                          );
                                        }).toList(),

                                        if (!isCorrect)
                                          Padding(
                                            padding: const EdgeInsets.only(top: 6.0),
                                            child: Text(
                                              '${AppLocalizations.of(context)!.correct_answer_test_exercises_text} ${answers.firstWhere((a) => a['isCorrect'] == true)['id']}) ${answers.firstWhere((a) => a['isCorrect'] == true)['text']}',
                                              style: TextStyle(
                                                color: Colors.green[800],
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
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
