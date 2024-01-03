import 'package:elaser/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elaser/view/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:elaser/utils/resources/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppThemes.light,
      // localization
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const SplashScreen(),
    );
  }
}