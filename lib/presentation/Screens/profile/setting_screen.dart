import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/presentation/CustomWidgets/button.dart';
import 'package:amira_app/presentation/CustomWidgets/custom_textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            //textfields
            Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: AppBorders.borderRadius10,
              ),
              margin: EdgeInsets.symmetric(vertical: 20.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Настройки',
                    style: TextStyle(
                      fontFamily: fontPeaceSans,
                      fontWeight: FontWeight.w400,
                      fontSize: AppFonts.fontSize22,
                    ),
                  ),
                  Column(
                    children: List.generate(
                      settingHinTexts.length,
                      (index) => Row(
                        children: [
                          Expanded(
                            child: CustomTextField.withUnderLine(
                              hintText: settingHinTexts[index],
                            ),
                          ),
                          SvgPicture.asset(arrowRightIcon),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //signout button
            Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: AppBorders.borderRadius10,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Button.textButton(
                backColor: AppColors.redColor,
                onTap: () {},
                text: 'Выйти из аккаунта',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
