import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscountCard extends StatelessWidget {
  final String title;
  final Color? backColor;
  const DiscountCard({
    required this.title,
    super.key,
    this.backColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backColor ?? AppColors.redColor,
        borderRadius: AppBorders.borderRadius10,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.whiteColor,
          fontFamily: fontPeaceSans,
          fontWeight: FontWeight.w400,
          fontSize: AppFonts.fontSize12,
        ),
      ),
    );
  }
}
