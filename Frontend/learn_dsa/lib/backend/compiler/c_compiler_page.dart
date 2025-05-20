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

class CCompilerPage extends StatefulWidget {
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
  final Map<String, String> _fileContents = {
    'main.c': Compiler.main,
  };
  String _mainCompilerText = Compiler.main;
  final List<String> _compilerFilenames = [];

  // For the refresh of main
  int _mainCompilerVersion = 0;

  @override
  void initState() {
    super.initState();
    _mainCompilerText = _fileContents['main.c']!;
  }

  void _addNewCompilerWidget(String title) {
    setState(() {
      if (!_fileContents.containsKey(title)) {
        if (title.endsWith('.c')) {
          final headerName = '${title.substring(0, title.length - 2)}.h';
          _fileContents[title] = '#include "$headerName"\n\n';
        } else {
          _fileContents[title] = '';
        }
      }

      if (title.endsWith('.h')) {
        final includeLine = '#include "$title"';
        final mainLines = _fileContents['main.c']!.split('\n');
        if (!mainLines.contains(includeLine)) {
          int insertIndex = mainLines.lastIndexWhere((line) => line.startsWith('#include')) + 1;
          if (insertIndex <= 0) insertIndex = 0;
          mainLines.insert(insertIndex, includeLine);
          _fileContents['main.c'] = mainLines.join('\n');
          _mainCompilerText = _fileContents['main.c']!;
          _mainCompilerVersion++;
        }
      }

      if (!_compilerFilenames.contains(title)) {
        _compilerFilenames.add(title);
      }
    });
  }

  void _removeCompilerWidget(String filename) {
    setState(() {
      _compilerFilenames.remove(filename);
      _fileContents.remove(filename);
    });
  }


  void _showAddCompilerDialog() {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(AppLocalizations.of(context)!.enter_compiler_title),
        content: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.filename_criteria,
              labelStyle: const TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
          ),
        ),

        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFF255f38),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              AppLocalizations.of(context)!.cancel_button_text,
              style: TextStyle(color: Colors.white),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final input = controller.text.trim();
              final startsWithUpper = input.isNotEmpty && input[0] == input[0].toUpperCase();
              final isMainC = input.toLowerCase() == 'main.c';

              if (input.isNotEmpty &&
                  (input.endsWith('.c') || input.endsWith('.h')) &&
                  !startsWithUpper &&
                  !isMainC) {
                _addNewCompilerWidget(input);
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      AppLocalizations.of(context)!.new_file_criteria,
                    ),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF27391c),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              AppLocalizations.of(context)!.create_text,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

  }

  String getFullSourceCode() {
    String content = _fileContents['main.c'] ?? '';

    final includeRegex = RegExp(r'#include\s+"(.+\.h)"');

    content = content.replaceAllMapped(includeRegex, (match) {
      final filename = match.group(1);
      return _fileContents[filename] ?? '// Error: $filename not found';
    });

    return content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Appbar
          SliverAppBar(
            backgroundColor: Colors.transparent,
            pinned: true,
            expandedHeight: 70,
            flexibleSpace: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
                  child: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                    title: Text(
                      AppLocalizations.of(context)!.compiler_page_title,
                      style: const TextStyle(
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
                  // main
                  CodeCompilerWidget(
                    key: ValueKey(_mainCompilerVersion),
                    title: AppLocalizations.of(context)!.compilet_box_title,
                    fileContents: _fileContents,
                    initialText: _mainCompilerText,
                    onChanged: (text) {
                      setState(() {
                        _mainCompilerText = text;
                        _fileContents['main.c'] = text;
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  ..._compilerFilenames.map((filename) {
                    return Column(
                      children: [
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            CodeCompilerWithoutRunWidget(
                              title: filename,
                              initialText: _fileContents[filename] ?? '',
                              onChanged: (text) {
                                setState(() {
                                  _fileContents[filename] = text;
                                });
                              },
                              onDelete: () => _removeCompilerWidget(filename),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  }),

                  const SizedBox(height: 20),

                  // Add button
                  Center(
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              blurRadius: 4,
                              offset: Offset(4, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: _showAddCompilerDialog,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: const Color(0xFF255f38),
                            elevation: 0,
                          ),
                          child: const Icon(Icons.add, color: Colors.white, size: 36),
                        ),
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
  final Map<String, String> fileContents;
  final ValueChanged<String> onChanged;

  const CodeCompilerWidget({super.key, required this.title, required this.initialText, required this.onChanged, required this.fileContents});

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
    _codeController = CodeController(
      text: widget.initialText,
      language: cpp,
    );
    _lines = widget.initialText.split("\n");
    _codeController.addListener(() {
      _updateLines();
      widget.onChanged(_codeController.text);
    });
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
      _lines = _codeController.text.split("\n");
    });
  }

  Future<void> _compileCode() async {
    HapticFeedback.mediumImpact();
    setState(() {
      isLoading = true;
      output = "";
      _errorLines.clear();
    });

    Map<String, String> codeToSend = Map.from(widget.fileContents);
    codeToSend[Compiler.MAIN] = _codeController.text;

    final url = Uri.parse("http://${Compiler.COMPILER_ADDRESS}:${Compiler.PRIVATE_DOMAIN}/compile");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        Compiler.DIRECTORY: codeToSend,
      }),
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
  final VoidCallback? onDelete;

  const CodeCompilerWithoutRunWidget({super.key, required this.title, required this.initialText, required this.onChanged, this.onDelete});

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
    _codeController = CodeController(
      text: widget.initialText,
      language: cpp,
    );
    _lines = widget.initialText.split("\n");
    _codeController.addListener(() {
      _updateLines();
      widget.onChanged(_codeController.text);
    });
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
      _lines = _codeController.text.split("\n");
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
                    icon: Icon(Icons.delete_outline, color: Colors.black),
                    onPressed: widget.onDelete,
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
        ],
      ),
    );
  }
}