// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amira_app/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/constants.dart';

class ProfileCard extends StatelessWidget {
  final int index;
  const ProfileCard({
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cardData = getCardData(context, index);
    return Container(
      width: 105.w,
      margin: EdgeInsets.only(right: 6.w),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.lightPurpleColor,
        borderRadius: AppBorders.borderRadius10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            cardData['icon'],
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
            cardData['name'],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: AppFonts.fontSize14,
            ),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> getCardData(BuildContext context, int index) {
    return index == 0
        ? {
            'name': AppLocalization.of(context).getTransatedValues('favorites'),
            'icon': heartBoldIcon,
          }
        : index == 1
            ? {
                'name':
                    AppLocalization.of(context).getTransatedValues('history'),
                'icon': shopBoldIcon,
              }
            : {
                'name':
                    AppLocalization.of(context).getTransatedValues('settings'),
                'icon': settingsIcon,
              };
  }
}
