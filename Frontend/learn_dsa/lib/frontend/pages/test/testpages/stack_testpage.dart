import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:learn_dsa/frontend/pages/test/testpages/stack/stack_tests_questions.dart';
import '../../../../backend/database/firestore_service.dart';
import '../../../helpers/essentials.dart';
import '../../../strings/firestore/firestore_docs.dart';
import '../tests_page.dart';

class StackTestPage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final String? userId;

  const StackTestPage({super.key, required this.toggleTheme, required this.userId});

  @override
  State<StackTestPage> createState() => _StackTestPageState();
}

class _StackTestPageState extends State<StackTestPage> with SingleTickerProviderStateMixin {
  bool showOverlay = false;
  bool showLockedDialog = false;
  bool showArrayInfo = false;

  @override
  void initState() {
    super.initState();
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
                      Essentials().createSlideRoute(TestsPage(
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
                title: Text(
                  AppLocalizations.of(context)!.stack_page_title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF255f38),
                  ),
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

              // Main Content
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      // exercises title and description
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme
                              .of(context)
                              .scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),

                        // buttons for starting
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context)!
                                .stack_page_tests_title,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              AppLocalizations.of(context)!
                                  .stack_page_tests_description_title,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.only(left: 24),
                              child: _buildCardItem(
                                AppLocalizations.of(context)!
                                    .start_exercise_button_text,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.answered_test_text_title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF255f38),
                              ),
                            ),
                            const SizedBox(height: 10),
                            FutureBuilder<List<Map<String, dynamic>>>(
                              future: FirestoreService().fetchAllAnswerStatsForCollection(
                                userId: widget.userId!,
                                questionCollection: FirestoreDocs.stack_tests_doc,
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(child: CircularProgressIndicator());
                                } else if (snapshot.hasError || snapshot.data == null || snapshot.data!.isEmpty) {
                                  return const Text("");
                                }

                                final data = snapshot.data!;
                                String monthName(BuildContext context, int month) {
                                  final locale = AppLocalizations.of(context)!.localeName;

                                  const monthsHu = [
                                    '', 'január', 'február', 'március', 'április', 'május', 'június',
                                    'július', 'augusztus', 'szeptember', 'október', 'november', 'december'
                                  ];
                                  const monthsEn = [
                                    '', 'January', 'February', 'March', 'April', 'May', 'June',
                                    'July', 'August', 'September', 'October', 'November', 'December'
                                  ];

                                  return locale == 'hu' ? monthsHu[month] : monthsEn[month];
                                }

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: data.map((stat) {
                                    final DateTime parsedDate = DateTime.tryParse(stat['timestamp']) ?? DateTime.now();
                                    final formattedDate = "${parsedDate.year}. ${monthName(context, parsedDate.month)} ${parsedDate.day}. ${parsedDate.hour}:${parsedDate.minute.toString().padLeft(2, '0')}";

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.check_circle_outline, color: Colors.green.shade700, size: 20),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  formattedDate,
                                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                ),
                                                Text(
                                                  "${stat['total']} / ${stat['correct']}",
                                                  style: const TextStyle(fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                );

                              },
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

  Widget _buildCardItem(String title) {
    return Container(
      width: AppLocalizations.of(context)!.play_animation_button_text.length * 10 + 20,
      height: 40,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF255f38), Color(0xFF27391c)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 4,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: RawMaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            Essentials().createSlideRoute(
              StackTestsQuestionsPage(
                toggleTheme: widget.toggleTheme,
                userId: widget.userId,
              ),
            ),
          );
          HapticFeedback.mediumImpact();
        },
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.play_arrow_rounded,
              color: Theme.of(context).scaffoldBackgroundColor,
              size: 22,
            ),
            Text(
              AppLocalizations.of(context)!.start_exercise_button_text,
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}