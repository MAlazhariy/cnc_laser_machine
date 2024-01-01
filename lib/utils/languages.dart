
import 'package:elaser/data/data_source/remote/dio/dio_client.dart';
import 'package:elaser/data/model/language_model.dart';
import 'package:elaser/utils/di_container.dart';
import 'package:elaser/utils/resources/app_images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class Language {
  static final List<LanguageModel> _languages = [
    LanguageModel(imagePath: AppImages.arabicFlag, languageName: 'العربية', languageCode: 'ar'),
    LanguageModel(imagePath: AppImages.englishFlag, languageName: 'English', languageCode: 'en'),
  ];

  static List<LanguageModel> get languages => _languages;

  static List<Locale> locales = _languages.map((e) => e.locale).toList();

  static Locale getCurrentLocale(BuildContext context) {
    return context.locale;
  }

  static Future<void> changeLanguage(
    BuildContext context, {
    required Locale locale,
  }) async {
    // change language locale
    await context.setLocale(locale);
    // update locale on dio
    final dioClient = Di.sl<DioClient>();
    dioClient.locale = locale.languageCode;
    dioClient.dio.options.headers.update('X-localization', (value) => locale.languageCode);
    return;
  }
}
