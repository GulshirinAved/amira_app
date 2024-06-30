import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/presentation/Screens/bottomNavBar/bottomNavBar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('addressBox');

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
        builder: (context, child) => MediaQuery(
          data:
              MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
          child: child!,
        ),
      ),
    ),
  );
}
