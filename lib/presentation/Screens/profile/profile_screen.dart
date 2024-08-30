import 'package:amira_app/app_localization.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/constants.dart';
import 'package:amira_app/data/api_providers/auth_provider.dart';
import 'package:amira_app/presentation/CustomWidgets/customContainer_extension.dart';
import 'package:amira_app/presentation/Screens/auth/register_screen.dart';
import 'package:amira_app/presentation/Screens/favorite/favorite_screen.dart';
import 'package:amira_app/presentation/Screens/profile/components/beSeller_card.dart';
import 'package:amira_app/presentation/Screens/profile/components/profile_card.dart';
import 'package:amira_app/presentation/Screens/profile/shoppingHistory_screen.dart';
import 'package:amira_app/presentation/Screens/profile/myDetails_screen.dart';
import 'package:amira_app/presentation/Screens/profile/notification_screen.dart';
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
// Phone number
            GestureDetector(
              onTap: () {
                pushScreenWithNavBar(
                    context,
                    AuthProvider().getAccessToken() != null
                        ? const MyDetailsScreen()
                        : const RegisterScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      AuthProvider().getAccessToken() != null
                          ? AuthProvider().getUserData() != null
                              ? AuthProvider().getUserData()!.phone ?? ''
                              : AppLocalization.of(context)
                                      .getTransatedValues('register') ??
                                  ''
                          : '',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: AppFonts.fontSize14,
                      ),
                    ),
                    SvgPicture.asset(arrowRightIcon),
                  ],
                ),
              ),
            ),
// Profile cards
            CustomContainer.buildContainer(
              height: 108.h,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 6.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => pushScreenWithNavBar(
                    context,
                    index == 0
                        ? const FavoriteScreen()
                        : index == 1
                            ? const ShoppingHistoryScreen()
                            : const SettingsScreen(),
                  ),
                  child: ProfileCard(index: index),
                ),
              ),
            ),
// BeSeller card
            const BeSellerCard(),

// Notification
            CustomContainer.buildContainer(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 6.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //toptitle
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Text(
                      AppLocalization.of(context)
                              .getTransatedValues('followAndNotification') ??
                          '',
                      style: TextStyle(
                        fontFamily: fontPeaceSans,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w400,
                        fontSize: AppFonts.fontSize22,
                      ),
                    ),
                  ),
                  //text and arrow
                  GestureDetector(
                    onTap: () {
                      pushScreenWithNavBar(context, const NotificationScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalization.of(context)
                                  .getTransatedValues('notificationSettings') ??
                              '',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: AppFonts.fontSize14,
                          ),
                        ),
                        SvgPicture.asset(arrowRightIcon),
                      ],
                    ),
                  ),
                ],
              ),
            ),
// Help tiles
            CustomContainer.buildContainer(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 6.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //help tiles
                    Expanded(
                      child: Text(
                        maxLines: 2,
                        AppLocalization.of(context)
                                .getTransatedValues(helpTiles[index]) ??
                            '',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: AppFonts.fontSize14,
                        ),
                      ),
                    ),
                    SvgPicture.asset(arrowRightIcon),
                  ],
                ),
                separatorBuilder: (context, index) =>
                    Divider(color: AppColors.grey1Color),
                itemCount: helpTiles.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
