import 'package:flutter/material.dart';
import 'package:learn_dsa/images/array_images.dart';
import '../../../styles/app_colors.dart';
import '../../custom_scaffold.dart';
import '../../../strings/array_strings.dart';

class ArrayPage extends StatelessWidget
{
  final VoidCallback toggleTheme;
  final String? userId;

  const ArrayPage({Key? key, required this.toggleTheme, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return CustomScaffold(
      toggleTheme: toggleTheme,
      userId: userId,
      appBar: AppBar(

        backgroundColor: isDarkTheme ? AppColors.backgroundAppBarDarkBAW : AppColors.backgroundAppBarLightBAW,
        title: Text(
          ArrayStrings.title,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 23,
            color: isDarkTheme ? AppColors.appBarTextDarkBAW : AppColors.appBarTextLightBAW,
          ),
        ),
        centerTitle: false,
        toolbarHeight: kToolbarHeight,
      ),

      body: Container(
        color: isDarkTheme ? AppColors.backgroundDarkBAW : AppColors.backgroundLightBAW,

        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox( height: 20),

              // what is an array?
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDarkTheme ? AppColors.answerColorDarkBAW : AppColors.answerColorLightBAW,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    // An array...
                    child: Text(
                      ArrayStrings.definition,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: isDarkTheme ? AppColors.textAnswerDarkBAW : AppColors.textAnswerLightBAW,
                      ),
                    ),
                  ),

                  Positioned(
                    top: -10,
                    left: 16,
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDarkTheme ? AppColors.questionColorDarkBAW : AppColors.questionColorLightBAW,
                        borderRadius: BorderRadius.circular(8), // Add rounded corners
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        ArrayStrings.question,
                        style: TextStyle(
                          color: isDarkTheme ? AppColors.textQuestionDarkBAW : AppColors.textQuestionLightBAW,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // array with explanation
              Image.asset(
                ArrayImage.array_explanation,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 20),

              // Introduction drop down
              Container(
                decoration: BoxDecoration(
                  color: isDarkTheme ? AppColors.questionColorDarkBAW : AppColors.questionColorLightBAW,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),

                  child: ExpansionTile(
                    title: Text(
                      ArrayStrings.introduction,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDarkTheme ? AppColors.textQuestionDarkBAW : AppColors.textQuestionLightBAW,
                      ),
                    ),
                    initiallyExpanded: false,
                    tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isDarkTheme ? AppColors.menuBackgroundDarkBAW : AppColors.menuBackgroundLightBAW,
                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              // Explanation of int array
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: isDarkTheme ? AppColors.menuAnswerBackgroundDarkBAW : AppColors.menuAnswerBackgroundLightBAW,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  ArrayStrings.example_image_explanation,
                                  style: TextStyle(
                                    color: isDarkTheme ? AppColors.textAnswerDarkBAW : AppColors.textAnswerLightBAW,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 10),

                              // Array image
                              Center(
                                child: SizedBox(
                                  width: 320,
                                  child: Image.asset(
                                    ArrayImage.array_example_pink,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Question
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  // Main rounded rectangle container
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: isDarkTheme ? AppColors.menuAnswerBackgroundDarkBAW : AppColors.menuAnswerBackgroundLightBAW,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      ArrayStrings.reg_array_explanations,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: isDarkTheme ? AppColors.textAnswerDarkBAW : AppColors.textAnswerLightBAW,
                                      ),
                                    ),
                                  ),

                                  // Floating label container
                                  Positioned(
                                    top: -10,
                                    left: 16,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: isDarkTheme ? AppColors.questionColorDarkBAW : AppColors.questionColorLightBAW,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Text(
                                        ArrayStrings.regular_array_initialization_question,
                                        style: TextStyle(
                                          color: isDarkTheme ? AppColors.textQuestionDarkBAW : AppColors.textQuestionLightBAW,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  // Main rounded rectangle container
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: isDarkTheme ? AppColors.menuAnswerBackgroundDarkBAW : AppColors.menuAnswerBackgroundLightBAW,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      ArrayStrings.initialization_done,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: isDarkTheme ? AppColors.textAnswerDarkBAW : AppColors.textAnswerLightBAW,
                                      ),
                                    ),
                                  ),

                                  // Floating label container
                                  Positioned(
                                    top: -10,
                                    left: 16,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: isDarkTheme ? AppColors.questionColorDarkBAW : AppColors.questionColorLightBAW,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Text(
                                        ArrayStrings.reg_array_final,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: isDarkTheme ? AppColors.textQuestionDarkBAW : AppColors.textQuestionLightBAW,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // In real life example drop down
              Container(
                decoration: BoxDecoration(
                  color: isDarkTheme ? AppColors.questionColorDarkBAW : AppColors.questionColorLightBAW,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    title: Text(
                      "In Real Life Example",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDarkTheme
                            ? AppColors.textQuestionDarkPink
                            : AppColors.textQuestionLightPink,
                      ),
                    ),
                    initiallyExpanded: false,
                    tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isDarkTheme ? AppColors.answerColorDarkBAW : AppColors.answerColorLightBAW,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Add your real-life example content here
                              Text(
                                "In real life, arrays can be used to store a list of student names in a classroom.",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: isDarkTheme ? AppColors.textAnswerDarkBAW : AppColors.textAnswerLightBAW,
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Additional content can be added here
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}