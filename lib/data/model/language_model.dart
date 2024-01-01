import 'dart:ui';

class LanguageModel {
  late final String imagePath;
  late final String languageName;
  late final String languageCode;

  Locale get locale => Locale(languageCode);

  LanguageModel({
    required this.imagePath,
    required this.languageName,
    required this.languageCode,
  });
}
