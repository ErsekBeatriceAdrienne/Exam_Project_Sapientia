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
  final List<Widget> _compilerWidgets = [];
  String _mainCompilerText = Compiler.main;
  final Map<String, String> _fileContents = {
    'main.c': Compiler.main,
  };

  void _addNewCompilerWidget(String title) {
    setState(() {
      if (!_fileContents.containsKey(title)) {
        _fileContents[title] = '';
      }

      if (title.endsWith('.h')) {
        final includeLine = '#include "$title"';
        if (!_mainCompilerText.contains(includeLine)) {
          final lines = _mainCompilerText.split('\n');
          int insertIndex = lines.lastIndexWhere((line) => line.startsWith('#include')) + 1;
          if (insertIndex == 0) insertIndex = 0;
          lines.insert(insertIndex, includeLine);
          _mainCompilerText = lines.join('\n');
        }
      }

      _compilerWidgets.addAll([
        CodeCompilerWithoutRunWidget(
          title: title,
          initialText: _fileContents[title] ?? '',
          onChanged: (text) {
            setState(() {
              _mainCompilerText = text;
              _fileContents[title] = text;
            });
          },
        ),
        const SizedBox(height: 20),
      ]);
    });
  }

  String getFullSourceCode() {
    String content = _fileContents['main.c'] ?? '';

    final includeRegex = RegExp(r'#include\s+"(.+\.h)"');

    content = content.replaceAllMapped(includeRegex, (match) {
      final filename = match.group(1);
      if (filename != null && _fileContents.containsKey(filename)) {
        return _fileContents[filename]!;
      } else {
        return '// Error: $filename not found';
      }
    });

    return content;
  }

  void _showAddCompilerDialog() {
    final TextEditingController _titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.enter_compiler_title),
          content: TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'File name (.c or .h)',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final input = _titleController.text.trim();
                final startsWithUppercase = input.isNotEmpty &&
                    input[0] == input[0].toUpperCase();
                final isMainC = input.toLowerCase() == 'main.c';

                if (input.isNotEmpty &&
                    (input.endsWith('.c') || input.endsWith('.h')) &&
                    !startsWithUppercase &&
                    !isMainC) {
                  _addNewCompilerWidget(input);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'File name must:\n'
                            '- end with .c or .h\n'
                            '- not start with an uppercase letter\n'
                            '- not be "main.c"',
                      ),
                    ),
                  );
                }
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _mainCompilerText = _fileContents['main.c']!;
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

          // Main Content
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  CodeCompilerWidget(
                    key: ValueKey(_mainCompilerText),
                    title: AppLocalizations.of(context)!.compilet_box_title,
                    initialText: _mainCompilerText,
                    onChanged: (text) {
                      setState(() {
                        _mainCompilerText = text;
                        _fileContents['main.c'] = text;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  // Added files
                  ..._compilerWidgets,

                  const SizedBox(height: 20),

                  // Add file
                  Center(
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: ElevatedButton(
                        onPressed: _showAddCompilerDialog,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: const Color(0xFF255f38),
                          elevation: 6,
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 36),
                      ),
                    ),
                  ),

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
  final ValueChanged<String> onChanged;

  const CodeCompilerWidget({super.key, required this.title, required this.initialText, required this.onChanged});

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
    _controller.addListener(() {
      _updateLines();
      widget.onChanged(_controller.text);
    });
    _codeController = CodeController(
      text: widget.initialText,
      language: cpp,
    );
    _currentTheme = vsTheme;
  }

  @override
  void dispose() {
    _codeController.dispose();
    _controller.dispose();
    super.dispose();
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 15),


          /// Output box with padding
          output.isEmpty ? Essentials().buildHighlightedCodeLines(AppLocalizations.of(context)!.no_output_text_compiler) :
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Essentials().buildHighlightedCodeLines(output),
          ),

        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------


class CodeCompilerWithoutRunWidget extends StatefulWidget {
  final String initialText;
  final String title;
  final ValueChanged<String> onChanged;

  const CodeCompilerWithoutRunWidget({super.key, required this.title, required this.initialText, required this.onChanged});

  @override
  _CodeCompilerWithoutRunWidgetState createState() => _CodeCompilerWithoutRunWidgetState();
}

class _CodeCompilerWithoutRunWidgetState extends State<CodeCompilerWithoutRunWidget>
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
    _controller.addListener(() {
      _updateLines();
      widget.onChanged(_controller.text);
    });
    _codeController = CodeController(
      text: widget.initialText,
      language: cpp,
    );
    _currentTheme = vsTheme;
  }

  @override
  void dispose() {
    _codeController.dispose();
    _controller.dispose();
    super.dispose();
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

  void _updateLines() {
    setState(() {
      _lines = _controller.text.split("\n");
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 15),


          /// Output box with padding
          output.isEmpty ? Essentials().buildHighlightedCodeLines(AppLocalizations.of(context)!.no_output_text_compiler) :
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Essentials().buildHighlightedCodeLines(output),
          ),

        ],
      ),
    );
  }
}