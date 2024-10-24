import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeSettingsPage extends StatefulWidget {
  final bool isDarkTheme;
  final ValueChanged<bool> onThemeChanged;
  final String currentLanguage;
  final ValueChanged<String> onLanguageChanged;

  const ThemeSettingsPage({
    Key? key,
    required this.isDarkTheme,
    required this.onThemeChanged,
    required this.currentLanguage,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  _ThemeSettingsPageState createState() => _ThemeSettingsPageState();
}

class _ThemeSettingsPageState extends State<ThemeSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Settings'),
      ),
      body: Column(
        children: [
          const Text('Select Theme:'),
          SwitchListTile(
            title: const Text('Dark Theme'),
            value: widget.isDarkTheme,
            onChanged: (bool value) {
              widget.onThemeChanged(value);
              HapticFeedback.mediumImpact();
            },
          ),
          const Divider(),
          const Text('Select Language:'),
          ListTile(
            title: const Text('English'),
            leading: Radio<String>(
              value: 'en',
              groupValue: widget.currentLanguage,
              onChanged: (value) {
                widget.onLanguageChanged(value!);
                HapticFeedback.mediumImpact();
              },
            ),
          ),
          ListTile(
            title: const Text('Hungarian'),
            leading: Radio<String>(
              value: 'hu',
              groupValue: widget.currentLanguage,
              onChanged: (value) {
                widget.onLanguageChanged(value!);
                HapticFeedback.mediumImpact();
              },
            ),
          ),
        ],
      ),
    );
  }
}
