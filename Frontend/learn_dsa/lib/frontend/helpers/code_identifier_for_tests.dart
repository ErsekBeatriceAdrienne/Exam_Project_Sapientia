import 'package:flutter/material.dart';

class TextFormatter {
  static final List<RegExp> codePatterns = [
    RegExp(r'typedef\s+struct[\s\S]+?\}\s*\w*;', multiLine: true, dotAll: true),
    RegExp(r'(?:int|float|char|struct)\s+\**\w+\s*(=[^;]+)?;', multiLine: true),
    RegExp(r'void\s+main\s*\([^)]*\)\s*\{[\s\S]*?\}', multiLine: true, dotAll: true),
    RegExp(r'printf\s*\(.*?\)\s*;', multiLine: true),
    RegExp(r'scanf\s*\(.*?\)\s*;', multiLine: true),
    RegExp(r'(if|while|for)\s*\(.*?\)\s*\{[\s\S]*?\}', multiLine: true, dotAll: true),
    RegExp(r'(if|while|for)\s*\(.*?\)\s*[^{;\n]+\s*;', multiLine: true),
    RegExp(r'\b\w+\s*=\s*[^;]+;', multiLine: true),
  ];

  static List<InlineSpan> formatTextWithCodeBlocks(String text) {
    text = _preprocessInlineStatements(text);

    final List<InlineSpan> spans = [];
    final matches = <Match>[];

    for (final pattern in codePatterns) {
      matches.addAll(pattern.allMatches(text));
    }

    matches.sort((a, b) => a.start.compareTo(b.start));
    final filteredMatches = <Match>[];
    int lastEnd = -1;

    for (final match in matches) {
      if (match.start >= lastEnd) {
        filteredMatches.add(match);
        lastEnd = match.end;
      }
    }

    if (filteredMatches.isEmpty) {
      return [TextSpan(text: text)];
    }

    int lastIndex = 0;

    for (final match in filteredMatches) {
      if (match.start > lastIndex) {
        spans.add(TextSpan(
          text: text.substring(lastIndex, match.start),
        ));
      }

      final rawCode = text.substring(match.start, match.end);
      final formattedCode = _formatCodeWithIndentation(rawCode);

      spans.add(
        TextSpan(
          text: '\n${formattedCode.trimRight()}',
          style: const TextStyle(
            fontFamily: 'Courier',
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.bold
          ),
        ),
      );

      lastIndex = match.end;
    }

    if (lastIndex < text.length) {
      spans.add(TextSpan(text: text.substring(lastIndex)));
    }

    return spans;
  }

  static String _preprocessInlineStatements(String code) {
    final buffer = StringBuffer();
    final lines = code.split('\n');

    for (var line in lines) {
      var parts = line.split(';');
      var rebuiltLine = <String>[];

      for (int i = 0; i < parts.length; i++) {
        var part = parts[i].trim();
        if (part.isEmpty) continue;

        if (!part.endsWith(';') &&
            !part.endsWith('}') &&
            !part.endsWith('?') &&
            !part.endsWith('!') &&
            !part.endsWith('.')) {
          part = '$part;';
        }

        if (RegExp(r'^(if|while|for)\s*\(.*\)$').hasMatch(part) &&
            i + 1 < parts.length &&
            parts[i + 1].trim().isNotEmpty) {
          var nextPart = parts[i + 1].trim();

          part = '$part $nextPart;';
          i++;
        }

        rebuiltLine.add(part);
      }

      buffer.writeln(rebuiltLine.join(' '));
    }

    return buffer.toString();
  }

  static String _formatCodeWithIndentation(String code) {

    final buffer = StringBuffer();
    var tempCode = code.replaceAll('{', '{\n').replaceAll('}', '\n}');
    List<String> tempLines = [];
    Set<String> addedLines = {};

    for (var part in tempCode.split('\n')) {
      part = part.trim();
      if (part.isEmpty) continue;

      if (part.contains('{') && part.contains('}')) {
        if (!addedLines.contains(part)) {
          tempLines.add(part);
          addedLines.add(part);
        }
      } else if (part.contains(';')) {
        final segments = part.split(';');
        for (int i = 0; i < segments.length; i++) {
          var seg = segments[i].trim();
          if (seg.isEmpty) continue;

          String lineToAdd;

          if (RegExp(r'^(if|while|for)\s*\(.*\)$').hasMatch(seg) &&
              i + 1 < segments.length &&
              segments[i + 1].trim().isNotEmpty) {
            lineToAdd = '$seg ${segments[i + 1].trim()}';
            i++;
          } else {
            lineToAdd = '$seg;';
          }

          if (!addedLines.contains(lineToAdd)) {
            tempLines.add(lineToAdd);
            addedLines.add(lineToAdd);
          }
        }
      } else {
        if (!addedLines.contains(part)) {
          tempLines.add(part);
          addedLines.add(part);
        }
      }
    }

    int indentLevel = 0;
    int i = 0;
    while (i < tempLines.length) {
      var line = tempLines[i];

      bool isLastLine = (i == tempLines.length - 1);
      bool isClosingBraceOnly = (line == '}');

      if (isLastLine && isClosingBraceOnly) {
        buffer.writeln(line);
      } else {
        buffer.writeln('${'\t' * indentLevel}$line');
      }

      if (line.endsWith('{')) {
        indentLevel++;
      }

      i++;
    }

    final formattedLines = buffer.toString().split('\n');
    final cleanedLines = <String>[];
    bool lastLineWasEmpty = false;

    for (var l in formattedLines) {
      if (l.trim().isEmpty) {
        if (!lastLineWasEmpty) {
          cleanedLines.add('');
          lastLineWasEmpty = true;
        }
      } else {
        cleanedLines.add(l);
        lastLineWasEmpty = false;
      }
    }

    return cleanedLines.join('\n');
  }
}

