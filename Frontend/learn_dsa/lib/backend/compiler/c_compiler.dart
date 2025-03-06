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

  Future<void> _compileCode() async {
    final url = Uri.parse("http://${Compiler.COMPILER_ADDRESS}:${Compiler.PRIVATE_DOMAIN}/compile");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"code": _controller.text}),
    );

    if (response.statusCode == 200) {
      setState(() {
        output = jsonDecode(response.body)["output"];
      });
    } else {
      setState(() {
        output = "Hiba: ${jsonDecode(response.body)["error"]}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("C Compiler in Flutter")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 10,
              decoration: InputDecoration(
                hintText: "Írd be a C kódot...",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _compileCode,
              child: Text("Futtatás"),
            ),
            SizedBox(height: 20),
            Text("Eredmény:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(output),
          ],
        ),
      ),
    );
  }
}