import 'package:elaser/utils/resources/app_size.dart';
import 'package:flutter/material.dart';
import 'package:elaser/utils/resources/color_manager.dart';
import 'package:elaser/utils/resources/app_font_family.dart';

class AppThemes {
  static ThemeData light = ThemeData(
    // material 3
    useMaterial3: true,

    /// main colors
    primaryColor: kMainColor,
    colorScheme: ColorScheme.fromSeed(seedColor: kMainColor),
    primarySwatch: kPrimarySwatch,
    scaffoldBackgroundColor: kScaffoldBG,

    /// font family
    fontFamily: FontFamily.main,

    // Add the line below to get horizontal sliding transitions for routes.
    // pageTransitionsTheme: const PageTransitionsTheme(
    //   builders: {
    //     TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    //   },
    // ),

    /// appBar theme
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: kPrimaryLightColor,
      elevation: 0,
    ),

    /// button theme
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      splashColor: kPrimaryLightColor,
    ),

    /// input decoration theme
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.radiusSmall)),
        borderSide: BorderSide(
          color: kPrimaryLightColor,
          width: 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.radiusSmall)),
        borderSide: BorderSide(
          color: kMainColor,
          width: 2,
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: kMainColor),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.radiusSmall)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.radiusSmall)),
        borderSide: BorderSide(
          color: kErrorColor,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.radiusSmall)),
        borderSide: BorderSide(
          color: kErrorColor,
          width: 1.5,
        ),
      ),
      filled: true,
      labelStyle: TextStyle(
        color: kMainColor,
      ),
      contentPadding: EdgeInsets.symmetric(
        vertical: AppSize.paddingDefault,
        horizontal: AppSize.paddingDefault,
      ),
    ),
  );
}
