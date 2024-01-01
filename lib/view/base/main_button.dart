import 'package:elaser/utils/resources/app_size.dart';
import 'package:elaser/utils/resources/color_manager.dart';
import 'package:elaser/utils/resources/app_text_styles.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.fontSize = AppSize.fontDefault+2,
    this.fit = true,
    this.outlined = false,
    this.strokeAlign = BorderSide.strokeAlignInside,
  });

  final void Function()? onPressed;
  final String title;
  final double fontSize;
  final bool fit;
  final bool outlined;
  final double strokeAlign;

  bool get _activated => onPressed != null;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.center,
      child: MaterialButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.radiusSmall),
        ),
        highlightElevation: 5,
        child: Ink(
          decoration: BoxDecoration(
            color: outlined
                ? null
                : _activated
                    ? kMainColor
                    : Colors.grey[400],
            borderRadius: BorderRadius.circular(AppSize.radiusSmall),
            border: outlined
                ? Border.all(
                    color: _activated ? kMainColor : Colors.grey.shade400,
                    width: 2,
                    strokeAlign: strokeAlign,
                  )
                : null,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 70,
              vertical: 15,
            ),
            width: fit ? double.infinity : null,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: kBoldFontStyle.copyWith(
                color: outlined ? kMainColor : kWhiteColor,
                fontSize: fontSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
