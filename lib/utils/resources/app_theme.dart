import 'package:elaser/utils/resources/app_size.dart';
import 'package:flutter/material.dart';
import 'package:elaser/utils/resources/color_manager.dart';
import 'package:elaser/utils/resources/app_font_family.dart';
import 'package:elaser/utils/resources/app_text_styles.dart';

class ThemeManager {
  static ThemeData light = ThemeData(
    // material 3
    useMaterial3: true,

    /// main colors
    primaryColor: kMainColor,
    colorSchemeSeed: kMainColor,
    primarySwatch: kPrimarySwatch,
    scaffoldBackgroundColor: kScaffoldBG,

    /// font family
    fontFamily: FontFamily.main,

    // Add the line below to get horizontal sliding transitions for routes.
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      },
    ),

    /// appBar theme
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: kPrimaryLightColor,
      elevation: 0,
    ),

    /// button theme
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.radiusExtraSmall),
      ),
      buttonColor: kMainColor,
      padding: const EdgeInsets.symmetric(
        vertical: AppSize.paddingDefault,
        horizontal: AppSize.paddingLarge - 2,
      ),
      minWidth: double.infinity,
    ),

    /// elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: kMediumFontStyle.copyWith(
          fontSize: AppSize.fontDefault,
          color: Colors.white,
        ),
        backgroundColor: kMainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.radiusExtraSmall),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: AppSize.paddingDefault,
          horizontal: AppSize.paddingLarge - 2,
        ),
      ),
    ),

    /// text theme
    // textTheme: TextTheme(
    //   displayLarge: kBoldFontStyle.copyWith(
    //     color: ColorManager.kWhite,
    //     fontSize: AppSize.kLarge,
    //   ),
    //   headlineMedium: kBoldFontStyle.copyWith(
    //     color: ColorManager.kDarkGray,
    //     fontSize: AppSize.kDefault,
    //   ),
    //   labelMedium: kBoldFontStyle.copyWith(
    //     color: ColorManager.kLightGray,
    //     fontSize: AppSize.kDefault,
    //   ),
    //   titleMedium: kBoldFontStyle.copyWith(
    //     color: ColorManager.kGray1,
    //   ),
    //   bodyMedium: kBoldFontStyle.copyWith(
    //     color: ColorManager.kGray,
    //   ),
    // ),

    /// input decoration theme
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(
          color: kPrimaryLightColor,
          width: 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(
          color: kMainColor,
          width: 2,
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: kMainColor),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(
          color: kErrorColor,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(
          color: kErrorColor,
          width: 1.5,
        ),
      ),
      filled: false,
      hintStyle: TextStyle(
        color: kPrimaryLightColor,
      ),
      labelStyle: TextStyle(
        color: kMainColor,
      ),
      contentPadding: EdgeInsets.symmetric(
        vertical: AppSize.paddingDefault,
        horizontal: AppSize.paddingDefault,
      ),
      suffixIconColor: kPrimaryLightColor,
    ),
  );

  static ThemeData dark = ThemeData();
}
