import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        stateManagement: true,
        tabs: List.generate(
          bottomNavBarItems.length,
          (index) => PersistentTabConfig(
            screen: getScreenForIndex(index),
            item: ItemConfig(
              inactiveIcon: SvgPicture.asset(bottomNavBarItems[index]['icon']),
              icon: SvgPicture.asset(
                bottomNavBarItems[index]['iconBold'],
                colorFilter:
                    ColorFilter.mode(AppColors.purpleColor, BlendMode.srcIn),
              ),
              activeColorSecondary: AppColors.purpleColor,
            ),
          ),
        ),
        navBarBuilder: (navBarConfig) =>
            Style11BottomNavBar(navBarConfig: navBarConfig),
      ),
    );
  }

  Widget getScreenForIndex(int index) {
    switch (index) {
      case 0:
        return Container();
      case 1:
        return Container();
      case 2:
        return Container();
      case 3:
        return Container();
      default:
        return Container();
    }
  }
}
