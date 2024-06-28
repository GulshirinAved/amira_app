import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Button extends StatelessWidget {
  final double width;
  const Button({
    required this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: width.w,
      onPressed: () {},
      shape: RoundedRectangleBorder(
        borderRadius: AppBorders.borderRadius10,
      ),
      color: AppColors.purpleColor,
      child: SvgPicture.asset(
        shopIcon,
        colorFilter: ColorFilter.mode(
          AppColors.whiteColor,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
