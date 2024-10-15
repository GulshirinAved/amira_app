// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/constants.dart';

class TopTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const TopTitle({
    required this.title,
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontFamily: fontPeaceSans,
                  fontSize: AppFonts.fontSize22,
                ),
              ),
            ),
            onTap == null
                ? const SizedBox.shrink()
                : SvgPicture.asset(arrowRightIcon),
          ],
        ),
      ),
    );
  }
}
