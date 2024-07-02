// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';

class ProfileCard extends StatelessWidget {
  final int index;
  const ProfileCard({
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 105.w,
      margin: EdgeInsets.only(right: 6.w),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.lightPurpleColor,
        borderRadius: AppBorders.borderRadius10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            profileCardName[index]['icon'],
            height: 16.h,
            width: 16.h,
            colorFilter: ColorFilter.mode(
              AppColors.purple2Color,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          Text(
            profileCardName[index]['name'],
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: AppFonts.fontSize14,
            ),
          ),
          Text(
            profileCardName[index]['amount'] ?? '',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: AppFonts.fontSize12,
              color: AppColors.greyColor,
            ),
          ),
        ],
      ),
    );
  }
}
