import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SettingTile extends StatelessWidget {
  final String iconTitle;
  final String title;
  final VoidCallback onTap;
  final bool isIcon;
  const SettingTile({
    required this.iconTitle,
    required this.title,
    required this.onTap,
    this.isIcon = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: isIcon == false
          ? ClipRRect(
              borderRadius: AppBorders.borderRadius10,
              child: Image.asset(
                iconTitle,
                width: 50.w,
              ),
            )
          : Container(width: 50.w, child: SvgPicture.asset(iconTitle)),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
      trailing: SvgPicture.asset(arrowRightIcon),
      onTap: onTap,
    );
  }
}
