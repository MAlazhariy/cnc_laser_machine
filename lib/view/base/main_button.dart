import 'package:elaser/utils/resources/app_size.dart';
import 'package:elaser/utils/resources/app_text_styles.dart';
import 'package:elaser/utils/resources/color_manager.dart';
import 'package:elaser/view/base/main_circular_progress_adaptive.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.fontSize = AppSize.fontDefault,
    this.horizontalContentPadding = AppSize.paddingDefault,
    this.verticalContentPadding = AppSize.paddingDefault,
    this.fit = true,
    this.outlined = false,
    this.loading = false,
    this.strokeAlign = BorderSide.strokeAlignInside,
    this.color = kMainColor,
    this.stadiumBorder = false,
  });

  final void Function()? onPressed;
  final String title;
  final double fontSize;
  final bool fit;
  final bool outlined;
  final bool loading;
  final double strokeAlign;
  final double horizontalContentPadding;
  final double verticalContentPadding;
  final Color color;
  final bool stadiumBorder;

  bool get _activated => onPressed != null;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.center,
      child: MaterialButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        shape: stadiumBorder
            ? const StadiumBorder()
            : RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.radiusDefault),
        ),
        highlightElevation: 5,
        child: Ink(
          decoration: BoxDecoration(
            color: outlined
                ? null
                : _activated
                ? color
                : Colors.grey[400],
            borderRadius: BorderRadius.circular(stadiumBorder ? 100 : AppSize.radiusDefault),
            border: outlined
                ? Border.all(
              color: _activated ? color : Colors.grey.shade400,
              width: 2,
              strokeAlign: strokeAlign,
            )
                : null,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalContentPadding,
              vertical: verticalContentPadding,
            ),
            width: fit ? double.maxFinite : null,
            child: loading
                ? Center(
              child: MainCircularProgress(
                color: outlined ? color : Colors.white,
                size: 20,
                strokeWidth: 3,
              ),
            )
                : Text(
              title,
              textAlign: TextAlign.center,
              style: kBoldFontStyle.copyWith(
                color: outlined ? color : Colors.white,
                fontSize: fontSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
