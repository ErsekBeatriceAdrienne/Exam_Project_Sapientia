import 'package:flutter/material.dart';

class ThemeSettingsPage extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<Color> onHighlightColorChanged; // New callback for highlight color

  const ThemeSettingsPage({
    Key? key,
    required this.isDarkMode,
    required this.onThemeChanged,
    required this.onHighlightColorChanged, // Add the new parameter
  }) : super(key: key);

  @override
  _ThemeSettingsPageState createState() => _ThemeSettingsPageState();
}

class _ThemeSettingsPageState extends State<ThemeSettingsPage> {
  late bool _isDarkMode;
  Color _highlightColor = Colors.blue; // Default highlight color

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
  }

  void _changeHighlightColor(Color color) {
    setState(() {
      _highlightColor = color;
    });
    widget.onHighlightColorChanged(color); // Notify parent about the color change
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Choose light or dark theme'),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.light_mode,
                        color: !_isDarkMode ? Colors.yellow : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isDarkMode = false;
                        });
                        widget.onThemeChanged(false);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.dark_mode,
                        color: _isDarkMode ? Colors.blueGrey : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isDarkMode = true;
                        });
                        widget.onThemeChanged(true);
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20), // Add some spacing
            //const Text('Choose Highlight Color'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildColorOption(Colors.red),
                _buildColorOption(Colors.green),
                _buildColorOption(Colors.blue),
                _buildColorOption(Colors.orange),
                _buildColorOption(Colors.purple),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorOption(Color color) {
    return GestureDetector(
      onTap: () => _changeHighlightColor(color),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: _highlightColor == color ? Colors.black : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }
}
