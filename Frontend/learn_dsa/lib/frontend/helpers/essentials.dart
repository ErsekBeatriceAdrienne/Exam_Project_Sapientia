import 'dart:io';

import 'package:flutter/material.dart';

class Essentials {

  Route createSlideRoute(Widget page) {
    final isWindows = Platform.isWindows;

    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: isWindows ? 10 : 10000),
      reverseTransitionDuration: Duration(milliseconds: isWindows ? 10 : 10000),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Widget _infoRow(IconData icon, Color iconColor, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 20),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHighlightedCodeLines(String code) {
    final lines = code.split('\n');

    final spans = <TextSpan>[];

    for (var i = 0; i < lines.length; i++) {
      final lineNumber = '${i + 1}'.padLeft(3);
      final lineText = lines[i];

      spans.add(
        TextSpan(
          children: [
            TextSpan(
              text: '$lineNumber  ',
              style: const TextStyle(
                fontFamily: 'Courier',
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            ..._getHighlightedSpans(lineText),
            const TextSpan(text: '\n'),
          ],
        ),
      );
    }

    return SelectableText.rich(
      TextSpan(children: spans),
      style: const TextStyle(
        fontFamily: 'Courier',
        fontSize: 15,
        color: Colors.black,
        fontWeight: FontWeight.bold
      ),
    );
  }

  Widget buildHighlightedCodeLinesNormal(String code) {
    final lines = code.split('\n');

    final spans = <TextSpan>[];

    for (var i = 0; i < lines.length; i++) {
      final lineNumber = '${i + 1}'.padLeft(3);
      final lineText = lines[i];

      spans.add(
        TextSpan(
          children: [
            TextSpan(
              text: '$lineNumber  ',
              style: const TextStyle(
                fontFamily: 'Courier',
                fontSize: 13,
                color: Colors.grey,
                fontWeight: FontWeight.bold
              ),
            ),
            ..._getHighlightedSpans(lineText),
            const TextSpan(text: '\n'),
          ],
        ),
      );
    }

    return SelectableText.rich(
      TextSpan(children: spans),
      style: const TextStyle(
        fontFamily: 'Courier',
        fontSize: 13,
        color: Colors.black,

      ),
    );
  }

  List<TextSpan> _getHighlightedSpans(String line) {
    final spans = <TextSpan>[];
    final pattern = RegExp(r'(#include|typedef|struct|int|bool|void|return|if|else|true|false|//.*|\*|\w+|[{}();,<>])');
    final matches = pattern.allMatches(line);

    int lastMatchEnd = 0;

    for (final match in matches) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(text: line.substring(lastMatchEnd, match.start)));
      }

      final matchText = match.group(0)!;
      Color color;

      switch (matchText) {
        case '#include':
        case 'typedef':
        case 'struct':
        case 'void':
        case 'return':
        case 'if':
        case 'else':
          color = Colors.green.shade700;
          break;
        case 'int':
        case 'bool':
          color = Colors.lightGreen.shade800;
          break;
        case 'true':
        case 'false':
          color = Colors.orange;
          break;
        default:
          if (matchText.startsWith('//')) {
            color = Colors.green;
          } else if (matchText == '*' || matchText == '&') {
            color = Colors.teal;
          } else {
            color = Colors.black;
          }
          break;
      }

      spans.add(TextSpan(text: matchText, style: TextStyle(color: color)));
      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < line.length) {
      spans.add(TextSpan(text: line.substring(lastMatchEnd)));
    }

    return spans;
  }
}