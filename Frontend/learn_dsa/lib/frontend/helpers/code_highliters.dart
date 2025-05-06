import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CodeSnippet extends StatelessWidget {
  final String codeContent;

  // Constructor to pass code content to the widget
  const CodeSnippet({Key? key, required this.codeContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final code = codeContent.split('\n'); // Split code into lines

    return ListView.builder(
      itemCount: code.length,
      itemBuilder: (context, index) {
        final line = code[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Line number
              Container(
                width: 30,
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
              // Code line
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Copy line to clipboard
                    Clipboard.setData(ClipboardData(text: line));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Code copied to clipboard!')),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'Courier',
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      children: _getHighlightedText(line),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Syntax highlighting
  List<TextSpan> _getHighlightedText(String line) {
    List<TextSpan> spans = [];
    RegExp regex = RegExp(r'(#include|typedef|struct|int|bool|void|\w+|//.*)');
    Iterable<Match> matches = regex.allMatches(line);

    int lastMatchEnd = 0;
    for (Match match in matches) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(text: line.substring(lastMatchEnd, match.start)));
      }

      // Highlighted texts
      if (match.group(0) == '#include') {
        spans.add(TextSpan(text: match.group(0), style: TextStyle(color: Colors.green)));
      } else if (match.group(0) == 'typedef' || match.group(0) == 'struct' || match.group(0) == 'void') {
        spans.add(TextSpan(text: match.group(0), style: TextStyle(color: Colors.blue)));
      } else if (match.group(0) == 'int' || match.group(0) == 'bool') {
        spans.add(TextSpan(text: match.group(0), style: TextStyle(color: Colors.orange)));
      } else if (match.group(0) == '//.*') {
        spans.add(TextSpan(text: match.group(0), style: TextStyle(color: Colors.grey))); // Comments in gray
      } else {
        spans.add(TextSpan(text: match.group(0), style: TextStyle(color: Colors.black)));
      }

      lastMatchEnd = match.end;
    }

    // If there's remaining text in the line after the last match
    if (lastMatchEnd < line.length) {
      spans.add(TextSpan(text: line.substring(lastMatchEnd)));
    }

    return spans;
  }
}
