import 'dart:ui';

import 'package:coffee_flutter_app/lang/translations.dart';
import 'package:flutter/material.dart';

class Translator {
  final Locale locale;

  Translator(this.locale);

  static const LocalizationsDelegate<Translator> delegate =
  _AppLocalizationsDelegate();

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static Translator of(BuildContext context) {
    return Localizations.of<Translator>(context, Translator);
  }

  // This method will be called from every widget which needs a localized text
  String trans(String key) {
    String translation = getTranslations(locale.languageCode)[key];

    if (translation == null) {
      return key;
    }

    return translation;
  }
}

// LocalizationsDelegate is a factory for a set of localized resources
// In this case, the localized strings will be gotten in an AppLocalizations object
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<Translator> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return ['ru', 'en'].contains(locale.languageCode);
  }

  @override
  Future<Translator> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    Translator localizations = new Translator(locale);
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}