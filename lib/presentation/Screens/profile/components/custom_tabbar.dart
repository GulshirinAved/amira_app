import 'package:amira_app/app_localization.dart';
import 'package:amira_app/blocs/profile/tabBar/tab_bar_cubit.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTabbar extends StatelessWidget {
  const CustomTabbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      onTap: (index) => context.read<TabCubit>().changeTab(index),
      labelStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: AppFonts.fontSize14,
      ),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: AppFonts.fontSize14,
        color: AppColors.greyColor,
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: Colors.transparent,
      tabs: [
        Tab(
          text: AppLocalization.of(context).getTransatedValues(tabbarList[0]) ??
              '',
        ),
        Tab(
          text: AppLocalization.of(context).getTransatedValues(tabbarList[1]) ??
              '',
        ),
      ],
    );
  }
}
