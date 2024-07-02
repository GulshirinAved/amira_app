import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/presentation/Screens/home/components/listviewProducts_slider.dart';
import 'package:amira_app/presentation/Screens/profile/components/profile_card.dart';
import 'package:amira_app/presentation/Screens/profile/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            //phone number
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(
                    '+993 61 31 24 54',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: AppFonts.fontSize14,
                    ),
                  ),
                  SvgPicture.asset(arrowRightIcon),
                ],
              ),
            ),
            //profile cards
            Container(
              height: 106.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r),
                ),
              ),
              margin: EdgeInsets.symmetric(vertical: 6.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              alignment: Alignment.center,
              child: ListView.builder(
                itemCount: profileCardName.length,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => index == 2
                      ? pushScreenWithNavBar(context, const SettingsScreen())
                      : null,
                  child: ProfileCard(
                    index: index,
                  ),
                ),
              ),
            ),
            //you saw products
            ListviewProductsSlider(
              topTitle: 'Вы смотрели',
              productsList: saleProducts,
            ),
            //help tiles
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r),
                ),
              ),
              margin: EdgeInsets.symmetric(vertical: 6.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              alignment: Alignment.center,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      helpTiles[index],
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: AppFonts.fontSize14,
                      ),
                    ),
                    SvgPicture.asset(arrowRightIcon),
                  ],
                ),
                separatorBuilder: (context, index) => Divider(
                  color: AppColors.greyColor,
                ),
                itemCount: helpTiles.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
