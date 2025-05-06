import 'package:flutter/material.dart';

class Essentials {

  Route createSlideRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 10000),
      reverseTransitionDuration: const Duration(milliseconds: 10000),
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

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: lines.length,
      itemBuilder: (context, index) {
        final line = lines[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row number
            Container(
              width: 30,
              alignment: Alignment.topRight,
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontFamily: 'Courier',
                ),
              ),
            ),
            // Colored row
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'Courier',
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: _getHighlightedSpans(line),
                ),
              ),
            ),
          ],
        );
      },
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
          color = Colors.green;
          break;
        case 'int':
        case 'bool':
          color = Colors.lightGreen;
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