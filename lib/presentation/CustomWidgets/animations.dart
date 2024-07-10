import 'package:amira_app/config/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class Animations {
  static Center loading = Center(
    child: LottieBuilder.asset(
      loadingAnimation,
      height: 75.h,
      width: 75.w,
    ),
  );
  static LottieBuilder empty = LottieBuilder.asset(emptyAnimation);
  static LottieBuilder nowifi = LottieBuilder.asset(
    nowifiAnimation,
    height: 95.h,
    width: 95.w,
  );
}
