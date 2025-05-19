import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../frontend/helpers/essentials.dart';
import 'c_compiler_strings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:highlight/languages/cpp.dart';
import 'package:flutter_highlight/themes/vs.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter_highlight/themes/dracula.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_highlight/themes/solarized-light.dart';
import 'package:flutter_highlight/themes/solarized-dark.dart';
import 'package:flutter_highlight/themes/tomorrow-night.dart';
import 'package:flutter_highlight/themes/xcode.dart';
import 'package:flutter_highlight/themes/androidstudio.dart';
import 'package:flutter_highlight/themes/agate.dart';

class CCompilerPage extends StatefulWidget  {
  final VoidCallback toggleTheme;
  final String? userId;

  const CCompilerPage({
    super.key,
    required this.toggleTheme,
    required this.userId,
  });

  @override
  _CCompilerPageState createState() => _CCompilerPageState();
}

class _CCompilerPageState extends State<CCompilerPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme
        .of(context)
        .brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            pinned: true,
            floating: false,
            expandedHeight: 70,
            flexibleSpace: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  color: Theme
                      .of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.2),
                  child: FlexibleSpaceBar(
                    titlePadding: EdgeInsets.only(left: 16, bottom: 16),
                    title: Text(AppLocalizations.of(context)!.compiler_page_title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF255f38),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Main Content as a SliverList
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  CodeCompilerWidget(title: AppLocalizations.of(context)!.compilet_box_title, initialText: Compiler.main),

                  const SizedBox(height: 40),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///----------------------------------------------------------------------------------------------------------------------------------------------

class CodeCompilerWidget extends StatefulWidget {
  final String initialText;
  final String title;

  const CodeCompilerWidget({super.key, required this.title, required this.initialText});

  @override
  _CodeCompilerWidgetState createState() => _CodeCompilerWidgetState();
}

class _CodeCompilerWidgetState extends State<CodeCompilerWidget>
{
  TextEditingController _controller = TextEditingController();
  List<String> _lines = [];
  Map<int, String> _errorLines = {};
  String output = "";
  bool isLoading = false;
  late CodeController _codeController;
  String _selectedThemeName = 'VS';
  late SharedPreferences _prefs;

  late Map<String, TextStyle> _currentTheme;
  final Map<String, Map<String, TextStyle>> _availableThemes = {
    'VS': vsTheme,
    'Monokai': monokaiSublimeTheme,
    'GitHub': githubTheme,
    'Dracula': draculaTheme,
    'Atom One Dark': atomOneDarkTheme,
    'Solarized Light': solarizedLightTheme,
    'Solarized Dark': solarizedDarkTheme,
    'Tomorrow Night': tomorrowNightTheme,
    'Xcode': xcodeTheme,
    'Android Studio': androidstudioTheme,
    'Agate': agateTheme,
  };

  @override
  void initState() {
    super.initState();
    _loadTheme();
    _controller = TextEditingController(text: widget.initialText);
    _lines = widget.initialText.split("\n");
    _controller.addListener(_updateLines);
    _codeController = CodeController(
      text: widget.initialText,
      language: cpp,
    );
    _currentTheme = vsTheme;
  }

  Future<void> _loadTheme() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedThemeName = _prefs.getString('selectedTheme') ?? 'VS';
    });
  }

  Future<void> _saveTheme(String themeName) async {
    await _prefs.setString('selectedTheme', themeName);
    setState(() {
      _selectedThemeName = themeName;
    });
  }

  void _showThemePicker() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return ListView(
          padding: EdgeInsets.all(16),
          children: _availableThemes.keys.map((themeName) {
            return ListTile(
              title: Text(themeName),
              onTap: () {
                setState(() {
                  _currentTheme = _availableThemes[themeName]!;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  void _updateLines() {
    setState(() {
      _lines = _controller.text.split("\n");
    });
  }

  Future<void> _compileCode() async {
    HapticFeedback.mediumImpact();
    setState(() {
      isLoading = true;
      output = "";
      _errorLines.clear();
    });

    final url = Uri.parse("http://${Compiler.COMPILER_ADDRESS}:${Compiler.PRIVATE_DOMAIN}/compile");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"code": _codeController.text}),
    );

    setState(() {
      isLoading = false;
      if (response.statusCode == 200) {
        output = jsonDecode(response.body)["output"];
      } else {
        var responseData = jsonDecode(response.body);
        if (responseData.containsKey("errors")) {
          List<dynamic> errors = responseData["errors"];
          output = errors.join("\n");

          for (var error in errors) {
            RegExp errorPattern = RegExp(r"Sor (\d+): (.+)");
            Match? match = errorPattern.firstMatch(error);

            if (match != null) {
              int lineNumber = int.parse(match.group(1)!);
              String message = match.group(2)!;
              _errorLines[lineNumber] = message;
            }
          }
        } else if (responseData.containsKey("error")) {
          output = responseData["error"];
        }
      }
    });
  }

  void _copyCodeToClipboard() {
    HapticFeedback.mediumImpact();
    Clipboard.setData(ClipboardData(text: _controller.text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.code_copied_text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildCodeEditor(),
      ],
    );
  }

  Widget _buildCodeEditor() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).scaffoldBackgroundColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  PopupMenuButton<String>(
                    tooltip: AppLocalizations.of(context)!.theme_choise,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
                    elevation: 8,
                    icon: Icon(Icons.brush, color: Colors.black),
                    onSelected: (value) => _saveTheme(value),
                    itemBuilder: (context) {
                      return _availableThemes.keys.map((themeName) {
                        bool isSelected = themeName == _selectedThemeName;
                        return PopupMenuItem<String>(
                          value: themeName,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                themeName,
                                style: TextStyle(
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  color: isSelected ? Theme.of(context).primaryColor : Colors.black87,
                                ),
                              ),
                              if (isSelected)
                                Icon(Icons.check, color: Theme.of(context).primaryColor, size: 18),
                            ],
                          ),
                        );
                      }).toList();
                    },
                  ),
                  IconButton(
                    onPressed: isLoading ? null : _copyCodeToClipboard,
                    icon: Icon(
                      Icons.copy,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: isLoading ? null : _compileCode,
                    icon: Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.green,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ],
          ),
          /// Editable Text Area with padding
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CodeTheme(
              data: CodeThemeData(styles: _availableThemes[_selectedThemeName]!),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CodeField(
                  controller: _codeController,
                  textStyle: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 15),

          /// Output title
          Text(
            AppLocalizations.of(context)!.results_title,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 5),

          /// Output box with padding
          output.isEmpty ? Text(AppLocalizations.of(context)!.no_output_text_compiler, style: TextStyle(color: Colors.black)) :
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Essentials().buildHighlightedCodeLines(output),
          ),

        ],
      ),
    );
  }
}