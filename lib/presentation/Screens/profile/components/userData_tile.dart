import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/constants.dart';
import 'package:amira_app/presentation/Screens/auth/privateDetails_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class UserDataTile extends StatelessWidget {
  final String? title;
  final bool? isLast;
  final bool? isHintText;

  const UserDataTile({
    this.title,
    super.key,
    this.isLast = false,
    this.isHintText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushScreenWithoutNavBar(context, PrivateDetailsScreen());
      },
      child: SizedBox(
        height: 42.h,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title!,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: AppFonts.fontSize14,
                    color: isHintText == true
                        ? AppColors.greyColor
                        : AppColors.blackColor,
                  ),
                ),
                SvgPicture.asset(arrowRightIcon),
              ],
            ),
            isLast == true
                ? const SizedBox.shrink()
                : Divider(
                    color: AppColors.grey1Color,
                  ),
          ],
        ),
      ),
    );
  }
}
