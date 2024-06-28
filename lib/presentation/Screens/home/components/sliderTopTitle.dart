import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TopTitle extends StatelessWidget {
  final String title;
  const TopTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.blackColor,
              fontFamily: fontPeaceSans,
              fontSize: AppFonts.fontSize22,
            ),
          ),
          SvgPicture.asset(arrowRightIcon),
        ],
      ),
    );
  }
}
