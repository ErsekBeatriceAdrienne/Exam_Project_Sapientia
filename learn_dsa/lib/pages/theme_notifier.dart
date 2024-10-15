import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;
  Color _highlightColor = Colors.blue;

  bool get isDarkMode => _isDarkMode;
  Color get highlightColor => _highlightColor;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setHighlightColor(Color color) {
    _highlightColor = color;
    notifyListeners();
  }
}
