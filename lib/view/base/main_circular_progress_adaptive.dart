import 'dart:io';

import 'package:elaser/utils/resources/color_manager.dart';
import 'package:flutter/material.dart';

class MainCircularProgress extends StatelessWidget {
  const MainCircularProgress({
    super.key,
    this.color = kMainColor,
    this.strokeWidth = 4,
    this.size,
  });

  final Color color;
  final double strokeWidth;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation<Color>(color),
        backgroundColor: Platform.isIOS ? color : null,
        strokeWidth: strokeWidth,
      ),
    );
  }
}
