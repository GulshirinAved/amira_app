import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/presentation/Screens/bottomNavBar/bottomNavBar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      ensureScreenSize: true,
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Amira app',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.whiteColor),
          scaffoldBackgroundColor: AppColors.lightGreyColor,
          fontFamily: fontGilroy,
          useMaterial3: true,
        ),
        home: const BottomNavBar(),
      ),
    ),
  );
}
