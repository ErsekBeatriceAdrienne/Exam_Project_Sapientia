import 'package:flutter/material.dart';
import 'package:learn_dsa/frontend/language_supports/provider_local.dart';
import 'package:provider/provider.dart';

class LanguagePicker extends StatelessWidget {
  const LanguagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final supportedLocales = L10n.all;
    final locale = provider.locale ?? Localizations.localeOf(context);
    final currentLocale = supportedLocales.contains(locale) ? locale : supportedLocales.first;

    return DropdownButton<Locale>(
      value: currentLocale,
      icon: const Icon(Icons.language),
      underline: const SizedBox(),
      onChanged: (Locale? newLocale) {
        if (newLocale != null) {
          provider.setLocale(newLocale);
        }
      },
      items: L10n.all.map((locale) {
        final flag = {
          'en': '🇬🇧',
          'hu': '🇭🇺',
          //'ro': '🇷🇴',
        }[locale.languageCode] ?? '';
        final name = L10n.getLanguageName(locale.languageCode);

        return DropdownMenuItem(
          value: locale,
          child: Text('$flag $name'),
        );
      }).toList(),
      isExpanded: false,
    );
  }
}
