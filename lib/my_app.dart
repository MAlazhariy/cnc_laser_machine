import 'package:elaser/utils/constants.dart';
import 'package:elaser/utils/resources/app_images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:elaser/helper/router_helper.dart';
import 'package:elaser/utils/resources/app_theme.dart';
import 'package:elaser/utils/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage(AppImages.logo), context);

    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.light,
      // localization
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: Routes.splashScreen,
      onGenerateRoute: RouterHelper.router.generator,
    );
  }
}