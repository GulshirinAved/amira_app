import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterChipCard extends StatelessWidget {
  final int index;
  const FilterChipCard({
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38.h,
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 8.h,
      ),
      margin: const EdgeInsets.all(
        3,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: AppBorders.borderRadius10,
        color: index == 0 ? AppColors.blackColor : AppColors.lightGreyColor,
      ),
      child: Text(
        filtername[index],
        style: TextStyle(
          color: index == 0 ? AppColors.whiteColor : AppColors.blackColor,
          fontWeight: FontWeight.w500,
          fontSize: AppFonts.fontSize14,
        ),
      ),
    );
  }
}