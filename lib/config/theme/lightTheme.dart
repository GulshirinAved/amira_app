import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/constants.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.whiteColor),
    scaffoldBackgroundColor: AppColors.lightGreyColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.whiteColor,
      surfaceTintColor: AppColors.whiteColor,
    ),
    bottomSheetTheme:
        BottomSheetThemeData(backgroundColor: AppColors.whiteColor),
    radioTheme: RadioThemeData(
      fillColor: WidgetStatePropertyAll(
        AppColors.purpleColor,
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStatePropertyAll(AppColors.whiteColor),
      overlayColor: WidgetStatePropertyAll(
        AppColors.purpleColor,
      ),
    ),
    tabBarTheme: TabBarTheme(
      indicatorColor: AppColors.purpleColor,
      labelColor: AppColors.purpleColor,
    ),
    fontFamily: fontGilroy,
    useMaterial3: true,
  );
}
