import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../strings/img_strings/array_images.dart';
import '../../../themes/app_colors.dart';
import '../../../strings/datastructure_strings/array_strings.dart';

class ArrayPage extends StatelessWidget
{
  final VoidCallback toggleTheme;
  final String? userId;

  const ArrayPage({Key? key, required this.toggleTheme, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(

        backgroundColor: isDarkTheme ? AppColors.backgroundAppBarDarkCP : AppColors.backgroundAppBarLightCP,
        title: Text(
          ArrayStrings.title,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 23,
            color: isDarkTheme ? AppColors.appBarTextDarkCP : AppColors.appBarTextLightCP,
          ),
        ),
        centerTitle: false,
        toolbarHeight: kToolbarHeight,
      ),

      body: Container(
        color: isDarkTheme ? AppColors.backgroundDarkCP : AppColors.backgroundLightCP,

        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox( height: 15),

              // what is an array?
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDarkTheme ? AppColors.answerColorDarkCP : AppColors.answerColorLightCP,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // Text description
                        Text(
                          ArrayStrings.definition,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: isDarkTheme ? AppColors.textAnswerDarkCP : AppColors.textAnswerLightCP,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Code array
                        Align(
                          alignment: Alignment.center,
                          child: Stack(
                            children: [

                              Container(
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: isDarkTheme ? AppColors.backgroundDarkCodeBoxCP : AppColors.backgroundLightCodeBoxCP,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.15),
                                      offset: const Offset(2, 2),
                                      blurRadius: 6,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),

                                child: SelectableText(
                                  ArrayStrings.array_empty_inicialization,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'monospace',
                                    color: isDarkTheme ? AppColors.textCodeDarkCP : AppColors.textCodeLightCP,
                                  ),
                                ),
                              ),

                              // Copy button on right up corner
                              Positioned(
                                top: 8,
                                right: 8,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.copy,
                                    color: isDarkTheme ? Colors.white : Colors.black87,
                                  ),
                                  onPressed: ()
                                  {
                                    Clipboard.setData(ClipboardData(
                                      text: ArrayStrings.array_empty_inicialization,
                                    ));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Code copied!')),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 10),

                        Text(
                          ArrayStrings.array_empty_explanation,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: isDarkTheme ? AppColors.textAnswerDarkCP : AppColors.textAnswerLightCP,
                          ),
                        ),

                        SizedBox(height: 10),

                        Image.asset(
                          ArrayImage.array_explanation,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),

                  // What is an array
                  Positioned(
                    top: -23,
                    left: 16,
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDarkTheme ? AppColors.questionColorDarkCP : AppColors.questionColorLightCP,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                      child: Text(
                        ArrayStrings.question,
                        style: TextStyle(
                          color: isDarkTheme ? AppColors.textQuestionDarkCP : AppColors.textQuestionLightCP,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 20),

            // In real life example drop down
            Container(
              decoration: BoxDecoration(
                color: isDarkTheme ? AppColors.questionColorDarkCP : AppColors.questionColorLightCP,
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
                      color: isDarkTheme ? AppColors.textQuestionDarkCP : AppColors.textQuestionLightCP,
                    ),
                  ),
                  initiallyExpanded: false,
                  tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDarkTheme ? AppColors.answerColorDarkCP : AppColors.answerColorLightCP,
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
                                color: isDarkTheme ? AppColors.textAnswerDarkCP : AppColors.textAnswerLightCP,
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

            const SizedBox( height:  10),

            // Introduction drop down
            Container(
              decoration: BoxDecoration(
                color: isDarkTheme ? AppColors.questionColorDarkCP : AppColors.questionColorLightCP,
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
                      color: isDarkTheme ? AppColors.textQuestionDarkCP : AppColors.textQuestionLightCP,
                    ),
                  ),
                  initiallyExpanded: false,
                  tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDarkTheme ? AppColors.menuBackgroundDarkCP : AppColors.menuBackgroundLightCP,
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
                                  color: isDarkTheme ? AppColors.textAnswerDarkCP : AppColors.textAnswerLightCP,
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
                                      color: isDarkTheme ? AppColors.textAnswerDarkCP : AppColors.textAnswerLightCP,
                                    ),
                                  ),
                                ),

                                // Floating label container
                                Positioned(
                                  top: -10,
                                  left: 16,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: isDarkTheme ? AppColors.questionColorDarkCP : AppColors.questionColorLightCP,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                    child: Text(
                                      ArrayStrings.regular_array_initialization_question,
                                      style: TextStyle(
                                        color: isDarkTheme ? AppColors.textQuestionDarkCP : AppColors.textQuestionLightCP,
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
                                      color: isDarkTheme ? AppColors.textAnswerDarkCP : AppColors.textAnswerLightCP,
                                    ),
                                  ),
                                ),

                                // Floating label container
                                Positioned(
                                  top: -10,
                                  left: 16,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: isDarkTheme ? AppColors.questionColorDarkCP : AppColors.questionColorLightCP,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                    child: Text(
                                      ArrayStrings.reg_array_final,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: isDarkTheme ? AppColors.textQuestionDarkCP : AppColors.textQuestionLightCP,
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

            // Functions
            Container(
              decoration: BoxDecoration(
                color: isDarkTheme ? AppColors.questionColorDarkCP : AppColors.questionColorLightCP,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                ),
                child: ExpansionTile(
                  title: Text(
                    "Functions",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDarkTheme ? AppColors.textQuestionDarkCP : AppColors.textQuestionLightCP,
                    ),
                  ),
                  initiallyExpanded: false,
                  tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDarkTheme ? AppColors.answerColorDarkCP : AppColors.answerColorLightCP,
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
                                color: isDarkTheme ? AppColors.textAnswerDarkCP : AppColors.textAnswerLightCP,
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

            const SizedBox(height: 10),

            // Strict Rules
            Container(
              decoration: BoxDecoration(
                color: isDarkTheme ? AppColors.questionColorDarkCP : AppColors.questionColorLightCP,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                ),
                child: ExpansionTile(
                  title: Text(
                    "Rules",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDarkTheme ? AppColors.textQuestionDarkCP : AppColors.textQuestionLightCP,
                    ),
                  ),
                  initiallyExpanded: false,
                  tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDarkTheme ? AppColors.answerColorDarkCP : AppColors.answerColorLightCP,
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
                                color: isDarkTheme ? AppColors.textAnswerDarkCP : AppColors.textAnswerLightCP,
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