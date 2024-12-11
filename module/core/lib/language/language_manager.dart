import 'package:flutter/material.dart';
import 'language_model.dart';

class LanguageManager {
  static LanguageManager? _instance;
  static LanguageManager get instance {
    _instance ??= LanguageManager._init();
    return _instance!;
  }

  LanguageManager._init();

  final enLocale = const Locale('en');
  final trLocale = const Locale('tr');
  final deLocale = const Locale('de');

  List<Locale> get supportedLocales => [trLocale, enLocale];
  List<LanguageModel> get languages => [
        LanguageModel(language: "English", languageLocal: LanguageManager._instance!.enLocale),
        LanguageModel(language: "Türkçe", languageLocal: LanguageManager._instance!.trLocale),
        LanguageModel(language: "Deutsch", languageLocal: LanguageManager._instance!.deLocale)
      ];
}
