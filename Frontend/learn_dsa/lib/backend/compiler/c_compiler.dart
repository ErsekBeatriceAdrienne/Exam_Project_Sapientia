import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'c_compiler_strings.dart';

class CodeCompilerPage extends StatefulWidget {
  @override
  _CodeCompilerPageState createState() => _CodeCompilerPageState();
}

class _CodeCompilerPageState extends State<CodeCompilerPage> {
  TextEditingController _controller = TextEditingController();
  List<String> _lines = [];
  Map<int, String> _errorLines = {};
  String output = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateLines);
  }

  void _updateLines() {
    setState(() {
      _lines = _controller.text.split("\n");
    });
  }

  Future<void> _compileCode() async {
    setState(() {
      isLoading = true;
      output = "";
      _errorLines.clear();
    });

    final url = Uri.parse("http://${Compiler.COMPILER_ADDRESS}:${Compiler.PRIVATE_DOMAIN}/compile");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"code": _controller.text}),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("C Compiler"),
        actions: [
          IconButton(
            onPressed: isLoading ? null : _compileCode,
            icon: Icon(
              Icons.play_arrow_rounded,
              color: Colors.greenAccent,
              size: 30,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: _buildCodeEditor()),
            SizedBox(height: 20),
            _buildOutputBox(),
          ],
        ),
      ),
    );
  }

  /*Widget _buildCodeEditor() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400),
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(_lines.length, (index) {
              return Padding(
                padding: EdgeInsets.only(top: 0.5),
                child: Text(
                  "${index + 1}",
                  style: TextStyle(
                    color: _errorLines.containsKey(index + 1) ? Colors.red : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(_lines.length, (index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        _lines[index],
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 14,
                          decoration: _errorLines.containsKey(index + 1)
                              ? TextDecoration.underline
                              : TextDecoration.none,
                          decorationColor: Colors.red,
                          decorationStyle: TextDecorationStyle.wavy,
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }*/
  Widget _buildCodeEditor() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400),
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(_lines.length, (index) {
              return Padding(
                padding: EdgeInsets.only(top: 0.5),
                child: Text(
                  "${index + 1}",
                  style: TextStyle(
                    color: _errorLines.containsKey(index + 1) ? Colors.red : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }),
          ),
          SizedBox(width: 10),

          /// Szerkeszthető szövegmező (TextField)
          Expanded(
            child: TextField(
              controller: _controller,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              onChanged: (text) {
                _updateLines();

                /// Ha egy sor szerkesztés alatt van, vegyük ki az error listából
                _errorLines.removeWhere((line, _) => line <= _lines.length);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutputBox() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Result:", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          output.isEmpty
              ? Text("No output.", style: TextStyle(color: Colors.white54))
              : SingleChildScrollView(
            child: Text(
              output,
              style: TextStyle(color: Colors.white, fontFamily: "monospace"),
            ),
          ),
        ],
      ),
    );
  }
}
