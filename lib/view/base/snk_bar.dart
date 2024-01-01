import 'package:elaser/utils/resources/app_size.dart';
import 'package:elaser/utils/resources/color_manager.dart';
import 'package:flutter/material.dart';

class SnkBar {
  static void showSuccess(
    BuildContext context,
    String msg, {
    int milliseconds = 1500,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: const TextStyle(
            fontSize: AppSize.fontDefault,
            color: Colors.white,
          ),
        ),
        backgroundColor: kSuccessColor,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.paddingLarge,
          vertical: AppSize.paddingSmall+2,
        ),
        duration: Duration(milliseconds: milliseconds),
      ),
    );
  }

  static void showError(
    BuildContext context,
    String msg, {
    int milliseconds = 2500,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: const TextStyle(
            fontSize: AppSize.fontDefault,
            color: Colors.white,
          ),
        ),
        backgroundColor: kErrorColor,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.paddingLarge,
          vertical: AppSize.paddingSmall+2,
        ),
        duration: Duration(milliseconds: milliseconds),
      ),
    );
  }

  static void showCustom(
      BuildContext context,
      String msg, {
        int milliseconds = 1500,
        Color? backgroundColor = kPrimaryLightColor,
        Color? textColor = kTitleColor,
      }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: TextStyle(
            fontSize: AppSize.fontDefault,
            color: textColor,
          ),
        ),
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.paddingLarge,
          vertical: AppSize.paddingSmall+2,
        ),
        duration: Duration(milliseconds: milliseconds),
      ),
    );
  }
}
