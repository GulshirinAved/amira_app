// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String topTitle;
  final String? iconTitle;
  final VoidCallback? onTap;
  final Color? favActiveColor;

  const CustomAppBar({
    required this.topTitle,
    Key? key,
    this.iconTitle,
    this.onTap,
    this.favActiveColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: SvgPicture.asset(
          arrowLeftIcon,
          fit: BoxFit.scaleDown,
        ),
      ),
      title: Text(
        topTitle,
        style: TextStyle(
          fontFamily: fontPeaceSans,
          fontWeight: FontWeight.w400,
          fontSize: AppFonts.fontSize18,
          color: AppColors.blackColor,
        ),
      ),
      actions: iconTitle == null
          ? []
          : [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: onTap,
                  child: SvgPicture.asset(
                    iconTitle!,
                    colorFilter: ColorFilter.mode(
                      favActiveColor ?? AppColors.greyColor,
                      BlendMode.srcIn,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
