// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amira_app/app_localization.dart';
import 'package:amira_app/blocs/cart/cartButton/cart_button_bloc.dart';
import 'package:amira_app/blocs/favButton/favbutton_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';

class ProfileCard extends StatelessWidget {
  final int index;
  const ProfileCard({
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cardData = getCardData(context, index);
    return Container(
      width: 105.w,
      margin: EdgeInsets.only(right: 6.w),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.lightPurpleColor,
        borderRadius: AppBorders.borderRadius10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            cardData['icon'],
            height: 16.h,
            width: 16.h,
            colorFilter: ColorFilter.mode(
              AppColors.purple2Color,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          Text(
            cardData['name'],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: AppFonts.fontSize14,
            ),
          ),
          BlocBuilder<FavButtonBloc, FavButtonState>(
            builder: (context, favstate) {
              return BlocBuilder<CartButtonBloc, CartButtonState>(
                builder: (context, state) {
                  return Text(
                    index == 2
                        ? ''
                        : '${index == 0 ? favstate.favList.length : state.cartList.length} ${AppLocalization.of(context).getTransatedValues('products')}  ',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: AppFonts.fontSize12,
                      color: AppColors.greyColor,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> getCardData(BuildContext context, int index) {
    return index == 0
        ? {
            'name': AppLocalization.of(context).getTransatedValues('favorites'),
            'icon': heartBoldIcon,
          }
        : index == 1
            ? {
                'name': AppLocalization.of(context).getTransatedValues('buy'),
                'icon': shopBoldIcon,
              }
            : {
                'name':
                    AppLocalization.of(context).getTransatedValues('settings'),
                'icon': settingsIcon,
              };
  }
}
