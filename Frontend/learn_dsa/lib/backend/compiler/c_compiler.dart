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
  String output = "";
  bool isLoading = false;

  Future<void> _compileCode() async {
    setState(() {
      isLoading = true;
      output = "";
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
        List<String> errors = List<String>.from(jsonDecode(response.body)["errors"]);
        output = errors.join("\n");
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
              color: Colors.greenAccent,//Color(0xFFDFAEE8),
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
            _buildCodeEditor(),
            SizedBox(height: 20),
            _buildOutputBox(),
          ],
        ),
      ),
    );
  }

  Widget _buildCodeEditor() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400),
      ),
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: _controller,
        maxLines: 10,
        style: TextStyle(fontFamily: 'monospace', fontSize: 14),
        decoration: InputDecoration(
          hintText: "Write code here...",
          border: InputBorder.none,
        ),
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
