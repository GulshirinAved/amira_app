import 'package:amira_app/app_localization.dart';
import 'package:amira_app/blocs/language/language_bloc.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/presentation/Screens/profile/components/flag_card.dart';
import 'package:amira_app/presentation/Screens/profile/components/setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: AppBorders.borderRadius10,
          ),
          margin: EdgeInsets.symmetric(vertical: 20.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalization.of(context).getTransatedValues('settings') ??
                    '',
                style: TextStyle(
                  fontFamily: fontPeaceSans,
                  fontWeight: FontWeight.w400,
                  fontSize: AppFonts.fontSize22,
                ),
              ),
              BlocBuilder<LanguageBloc, LanguageState>(
                builder: (context, state) {
                  return SettingTile(
                    iconTitle: languageList[
                        (state as ChangeLanguageState).languageCode == 'tr'
                            ? 0
                            : 1]['image'],
                    title: languageList[
                        (state as ChangeLanguageState).languageCode == 'tr'
                            ? 0
                            : 1]['title'],
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Dilini saylan",
                                    style: TextStyle(
                                      fontFamily: fontPeaceSans,
                                      fontWeight: FontWeight.w400,
                                      fontSize: AppFonts.fontSize18,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      FlagCard(
                                        borderColor:
                                            (state as ChangeLanguageState)
                                                        .languageCode ==
                                                    'tr'
                                                ? AppColors.purpleColor
                                                : AppColors.lightGreyColor,
                                        image: languageList[0]['image'],
                                        title: languageList[0]['title'],
                                        onTap: () {
                                          context
                                              .read<LanguageBloc>()
                                              .add(TurkmenLanguageEvent());
                                          Navigator.pop(context);
                                        },
                                      ),
                                      FlagCard(
                                        borderColor:
                                            (state as ChangeLanguageState)
                                                        .languageCode ==
                                                    'ru'
                                                ? AppColors.purpleColor
                                                : AppColors.lightGreyColor,
                                        image: languageList[1]['image'],
                                        title: languageList[1]['title'],
                                        onTap: () {
                                          context
                                              .read<LanguageBloc>()
                                              .add(RussianLanguageEvent());
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
              Divider(),
              SettingTile(
                isIcon: true,
                iconTitle: loginIcon,
                title: 'Login',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
