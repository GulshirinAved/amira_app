import 'package:amira_app/config/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension CustomContainer on Container {
  static Container buildContainer({
    required double width,
    EdgeInsetsGeometry? margin,
    required Widget child,
    double? height,
    EdgeInsetsGeometry? padding,
    Alignment? alignment,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: AppBorders.borderRadius10,
      ),
      margin: margin,
      padding: padding,
      alignment: alignment ?? Alignment.center,
      child: child,
    );
  }
}
