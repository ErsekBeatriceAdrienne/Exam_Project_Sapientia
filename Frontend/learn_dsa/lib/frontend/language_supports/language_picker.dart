import 'package:flutter/material.dart';
import 'package:learn_dsa/frontend/language_supports/provider_local.dart';
import 'package:provider/provider.dart';

class LanguagePicker extends StatelessWidget {
  const LanguagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final supportedLocales = L10n.all;

    return DropdownButtonHideUnderline(
      child: DropdownButton<Locale>(
        icon: const Icon(Icons.language, color: Colors.black),
        borderRadius: BorderRadius.circular(12),
        onChanged: (Locale? newLocale) {
          if (newLocale != null) {
            provider.setLocale(newLocale);
          }
        },
        items: supportedLocales.map((locale) {
          final name = L10n.getLanguageName(locale.languageCode);
          return DropdownMenuItem(
            value: locale,
            child: Text(
              name,
              style: const TextStyle(fontSize: 16),
            ),
          );
        }).toList(),
        isExpanded: false,
        dropdownColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
      ),
    );
  }
}
