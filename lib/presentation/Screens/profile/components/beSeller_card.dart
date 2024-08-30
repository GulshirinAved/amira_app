import 'package:amira_app/app_localization.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/constants.dart';
import 'package:amira_app/presentation/CustomWidgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BeSellerCard extends StatelessWidget {
  const BeSellerCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
        ),
      ),
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //title
          Text(
            AppLocalization.of(context).getTransatedValues('sellerInAmira') ??
                '',
            style: TextStyle(
              fontFamily: fontPeaceSans,
              color: AppColors.blackColor,
              fontWeight: FontWeight.w400,
              fontSize: AppFonts.fontSize22,
            ),
          ),
          //desc
          Text(
            AppLocalization.of(context)
                    .getTransatedValues('descForBeingSeller') ??
                '',
            style: TextStyle(
              color: AppColors.greyColor,
              fontWeight: FontWeight.w500,
              fontSize: AppFonts.fontSize12,
            ),
          ),
          // be seller button
          Button.textButton(
            text: 'Стать продавцом',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
