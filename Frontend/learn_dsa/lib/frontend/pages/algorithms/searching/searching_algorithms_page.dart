import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:learn_dsa/frontend/pages/algorithms/algorithms_page.dart';
import 'package:learn_dsa/frontend/strings/algorithms/searching_strings.dart';
import '../../../../backend/compiler/c_compiler.dart';
import '../../../helpers/essentials.dart';
import '../../../strings/algorithms/sorting_strings.dart';
import 'animation/binary_search.dart';
import 'animation/linear_search.dart';


class SearchingAlgorithmsPage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final String? userId;

  const SearchingAlgorithmsPage({super.key, required this.toggleTheme, required this.userId});

  @override
  State<SearchingAlgorithmsPage> createState() => _SearchingAlgorithmsPageState();
}

class _SearchingAlgorithmsPageState extends State<SearchingAlgorithmsPage> with SingleTickerProviderStateMixin {
  bool showOverlay = false;
  bool showLockedDialog = false;
  bool _isDropdownVisible = false;
  bool showArrayInfo = false;


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
                      Essentials().createSlideRoute(AlgorithmsPage(
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
                  // Button back
                  label: Text(
                    AppLocalizations.of(context)!.back_button_text,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 17,
                    ),
                  ),
                ),
                centerTitle: true,
                title: Text(
                  AppLocalizations.of(context)!.searching_algorithms_title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF255f38),
                  ),
                ),
                /*actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isDropdownVisible = !_isDropdownVisible;
                        });
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          //color: Color(0xFF255f38),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(
                          _isDropdownVisible ? Icons.pending_rounded : Icons
                              .pending_outlined,
                          color: const Color(0xFF255f38),
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],*/
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

              // Body
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      // Searching question
                      Container(
                        decoration: BoxDecoration(
                          color: Theme
                              .of(context)
                              .scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .searching_algorithms_question,
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),

                            Text(
                              AppLocalizations.of(context)!
                                  .searching_algorithms_description,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(AppLocalizations.of(context)!.linear_searching_title,
                        style: TextStyle(
                          color: Color(0xFF1f7d53),
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Calling
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context)!
                                .linear_searching_definition,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                              ),
                              softWrap: true,
                            ),

                            const SizedBox(height: 10),

                            Center(
                              child: Stack(
                                children: [

                                  Essentials()
                                      .buildHighlightedCodeLines(
                                      SearchingStrings
                                          .linear_code),

                                  // Copy button on right up corner
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.copy,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        Clipboard.setData(
                                            ClipboardData(
                                                text: SearchingStrings
                                                    .linear_code));
                                        HapticFeedback.mediumImpact();
                                        ScaffoldMessenger
                                            .of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                AppLocalizations.of(
                                                    context)!
                                                    .code_copied_text),
                                            behavior: SnackBarBehavior
                                                .floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius
                                                  .circular(12),
                                            ),
                                            margin: EdgeInsets.all(16),
                                            elevation: 6,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(AppLocalizations.of(context)!
                                .linear_searching_param_1,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                              softWrap: true,
                            ),
                            Text(AppLocalizations.of(context)!
                                .linear_searching_param_2,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                              softWrap: true,
                            ),
                            Text(AppLocalizations.of(context)!
                                .linear_searching_param_3,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                              softWrap: true,
                            ),

                            const SizedBox(height: 10),

                            LinearSearchAnimationWidget(),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      CodeCompiler( initialText: SearchingStrings.linear_declaration, title: AppLocalizations.of(context)!.linear_searching_example),

                      const SizedBox(height: 20),

                      Text(AppLocalizations.of(context)!.non_linear_searching_title,
                        style: TextStyle(
                          color: Color(0xFF1f7d53),
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Calling
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context)!
                                .non_linear_searching_definition,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                              ),
                              softWrap: true,
                            ),

                            const SizedBox(height: 10),

                            Center(
                              child: Stack(
                                children: [

                                  Essentials()
                                      .buildHighlightedCodeLines(
                                      SearchingStrings
                                          .binary_declaration),

                                  // Copy button on right up corner
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.copy,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        Clipboard.setData(
                                            ClipboardData(
                                                text: SearchingStrings
                                                    .binary_declaration));
                                        HapticFeedback.mediumImpact();
                                        ScaffoldMessenger
                                            .of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                AppLocalizations.of(
                                                    context)!
                                                    .code_copied_text),
                                            behavior: SnackBarBehavior
                                                .floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius
                                                  .circular(12),
                                            ),
                                            margin: EdgeInsets.all(16),
                                            elevation: 6,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(AppLocalizations.of(context)!
                                .linear_searching_param_1,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                              softWrap: true,
                            ),
                            Text(AppLocalizations.of(context)!
                                .non_linear_searching_param_2,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                              softWrap: true,
                            ),
                            Text(AppLocalizations.of(context)!
                                .non_linear_searching_param_3,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                              softWrap: true,
                            ),
                            Text(AppLocalizations.of(context)!
                                .linear_searching_param_3,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                              softWrap: true,
                            ),

                            const SizedBox(height: 10),

                            BinarySearchAnimationWidget(),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      CodeCompiler( initialText: SearchingStrings.binary_code, title: AppLocalizations.of(context)!.non_linear_searching_example),

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
