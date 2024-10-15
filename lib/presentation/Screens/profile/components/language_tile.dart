import 'package:amira_app/app_localization.dart';
import 'package:amira_app/blocs/profile/expandDropDown/expand_drop_down_cubit.dart';
import 'package:amira_app/blocs/profile/language/language_bloc.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalization.of(context).getTransatedValues('interface') ?? '',
          style: TextStyle(
            fontFamily: fontPeaceSans,
            color: AppColors.blackColor,
            fontWeight: FontWeight.w400,
            fontSize: AppFonts.fontSize22,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 6.h),
                child: Text(
                  AppLocalization.of(context).getTransatedValues('lang') ?? '',
                  style: TextStyle(
                    fontFamily: fontPeaceSans,
                    fontWeight: FontWeight.w400,
                    fontSize: AppFonts.fontSize14,
                  ),
                ),
              ),
              BlocBuilder<ExpandDropDownCubit, bool>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      context.read<ExpandDropDownCubit>().tapDropDown();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 126.w,
                          child: Row(
                            children: [
                              BlocBuilder<LanguageBloc, LanguageState>(
                                builder: (context, state) {
                                  return Text(
                                    languageList[(state as ChangeLanguageState)
                                                .languageCode ==
                                            'tr'
                                        ? 0
                                        : 1]['title'],
                                    style: TextStyle(
                                      fontSize: AppFonts.fontSize14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                width: 12.w,
                              ),
                              SvgPicture.asset(
                                state == false ? arrowDownIcon : arrowUpIcon,
                                colorFilter: ColorFilter.mode(
                                  AppColors.blackColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ],
                          ),
                        ),
                        state == true
                            ? AnimatedSize(
                                alignment: Alignment.topLeft,
                                curve: Curves.fastOutSlowIn,
                                duration: const Duration(milliseconds: 500),
                                child: Container(
                                  width: 126.w,
                                  margin: const EdgeInsets.only(top: 10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    border: Border.all(
                                      color: AppColors.grey1Color,
                                    ),
                                    borderRadius: AppBorders.borderRadius10,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: List.generate(
                                      2,
                                      (index) => GestureDetector(
                                        onTap: () {
                                          index == 0
                                              ? context
                                                  .read<LanguageBloc>()
                                                  .add(
                                                    TurkmenLanguageEvent(),
                                                  )
                                              : context
                                                  .read<LanguageBloc>()
                                                  .add(
                                                    RussianLanguageEvent(),
                                                  );

                                          Phoenix.rebirth(context);
                                        },
                                        child: Container(
                                          width: 126.w,
                                          margin: const EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: AppColors.grey1Color,
                                              ),
                                            ),
                                          ),
                                          child: BlocBuilder<LanguageBloc,
                                              LanguageState>(
                                            builder: (context, state) {
                                              return Text(
                                                languageList[index]['title'],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: (state as ChangeLanguageState)
                                                                  .languageCode ==
                                                              'tr' &&
                                                          index == 0
                                                      ? AppColors.purple1Color
                                                      : state.languageCode ==
                                                                  'ru' &&
                                                              index == 1
                                                          ? AppColors
                                                              .purple1Color
                                                          : AppColors
                                                              .blackColor,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
