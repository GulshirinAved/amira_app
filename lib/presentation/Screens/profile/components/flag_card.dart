import 'package:amira_app/config/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FlagCard extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;
  final Color? borderColor;
  const FlagCard(
      {super.key,
      required this.image,
      required this.title,
      required this.onTap,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.lightGreyColor,
          borderRadius: AppBorders.borderRadius10,
          border: Border.all(color: borderColor ?? AppColors.lightGreyColor),
        ),
        child: Column(
          children: [
            Image.asset(
              image,
              height: 50.h,
              width: 75.w,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}
