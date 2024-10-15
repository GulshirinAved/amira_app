import 'dart:developer';

import 'package:amira_app/app_localization.dart';
import 'package:amira_app/blocs/auth/userProfile/user_profile_bloc.dart';
import 'package:amira_app/blocs/cart/cartButton/cart_button_bloc.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/constants.dart';
import 'package:amira_app/data/api_providers/auth_provider.dart';
import 'package:amira_app/data/models/cart_model.dart';
import 'package:amira_app/data/models/fav_model.dart';
import 'package:amira_app/presentation/CustomWidgets/animations.dart';
import 'package:amira_app/presentation/CustomWidgets/button.dart';
import 'package:amira_app/presentation/CustomWidgets/customContainer_extension.dart';
import 'package:amira_app/presentation/Screens/auth/register_screen.dart';
import 'package:amira_app/presentation/Screens/cart/cartPayment_screen.dart';
import 'package:amira_app/presentation/Screens/cart/components/cartProduct_card.dart';
import 'package:amira_app/presentation/Screens/home/components/deliveryAddress_tile.dart';
import 'package:amira_app/presentation/Screens/home/components/gridviewProducts_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late UserProfileBloc _userProfileBloc;

  @override
  void initState() {
    super.initState();
    _userProfileBloc = UserProfileBloc()..add(GetUserData());
  }

  @override
  void dispose() {
    _userProfileBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _userProfileBloc,
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<UserProfileBloc, UserProfileState>(
            builder: (context, userState) {
              log(userState.toString());
              if (userState is UserProfileError) {
                return const SizedBox.shrink();
              } else if (userState is UserProfileInitial) {
                return Center(
                  child: Animations.loading,
                );
              } else if (userState is UserProfileLoaded) {
                return ListView(
                  children: [
                    //delivery location
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: const DeliveryAddressTile(),
                    ),
                    //cart product cards
                    BlocBuilder<CartButtonBloc, CartButtonState>(
                      builder: (context, state) {
                        if (state is CartButtonInitial ||
                            state.cartList.isEmpty) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height / 1.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Animations.empty,
                                Text(
                                  AppLocalization.of(context)
                                          .getTransatedValues('cartEmpty') ??
                                      '',
                                  style: TextStyle(
                                    fontFamily: fontPeaceSans,
                                    fontSize: AppFonts.fontSize18,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return Column(
                          children: [
                            CustomContainer.buildContainer(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(vertical: 6.h),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 10.h,
                              ),
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: state.cartList.length,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    CartProductCard(
                                  index: index,
                                  favItem: FavItem(
                                    id: state.cartList[index].id,
                                    name: state.cartList[index].name,
                                    desc: state.cartList[index].desc,
                                    discount: state.cartList[index].discount,
                                    image: state.cartList[index].image,
                                    price: state.cartList[index].price,
                                    shopid: state.cartList[index].shopid,
                                    coin: state.cartList[index].coin,
                                  ),
                                  cartItem: CartItem(
                                    id: state.cartList[index].id,
                                    name: state.cartList[index].name,
                                    desc: state.cartList[index].desc,
                                    discount: state.cartList[index].discount,
                                    image: state.cartList[index].image,
                                    price: state.cartList[index].price,
                                    shopid: state.cartList[index].shopid,
                                    coin: state.cartList[index].coin,
                                  ),
                                ),
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        Divider(
                                  color: AppColors.lightGreyColor,
                                  endIndent: 10,
                                  indent: 10,
                                ),
                              ),
                            ),
                            //cart price card
                            CustomContainer.buildContainer(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(vertical: 6.h),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 10.h,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalization.of(context)
                                            .getTransatedValues('cart') ??
                                        '',
                                    style: TextStyle(
                                      fontFamily: fontPeaceSans,
                                      fontWeight: FontWeight.w400,
                                      fontSize: AppFonts.fontSize22,
                                    ),
                                  ),
                                  BlocBuilder<CartButtonBloc, CartButtonState>(
                                    builder: (context, state) {
                                      return Column(
                                        children: [
                                          rowText(
                                            leftText:
                                                AppLocalization.of(context)
                                                        .getTransatedValues(
                                                      'products',
                                                    ) ??
                                                    '',
                                            rightText: state.sum.toString(),
                                          ),
                                          rowText(
                                            leftText:
                                                AppLocalization.of(context)
                                                        .getTransatedValues(
                                                      'sale',
                                                    ) ??
                                                    '',
                                            rightText:
                                                state.salePrice.toString(),
                                            color: AppColors.redColor,
                                          ),
                                          rowText(
                                            leftText:
                                                AppLocalization.of(context)
                                                        .getTransatedValues(
                                                      'sum',
                                                    ) ??
                                                    '',
                                            rightText:
                                                '${(state.sum ?? 0) - (state.salePrice ?? 0)}',
                                            color: AppColors.purpleColor,
                                            fontSize: AppFonts.fontSize22,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  Button.textButton(
                                    text: AppLocalization.of(context)
                                            .getTransatedValues('toOrder') ??
                                        '',
                                    onTap: () {
                                      AuthProvider().getAccessToken() == null
                                          ? pushScreenWithoutNavBar(
                                              context,
                                              const RegisterScreen(),
                                            )
                                          : pushScreenWithNavBar(
                                              context,
                                              BlocBuilder<CartButtonBloc,
                                                  CartButtonState>(
                                                builder: (context, state) {
                                                  return BlocProvider.value(
                                                    value: _userProfileBloc,
                                                    child: CartPaymentScreen(
                                                      productsSumPrice:
                                                          state.sum!,
                                                      discountPrice:
                                                          state.salePrice ?? 0,
                                                      totalPrice: double.parse(
                                                        '${(state.sum ?? 0) - (state.salePrice ?? 0)}',
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    userState.userData?.viewedProduct != null &&
                            userState.userData != null &&
                            userState.userData!.viewedProduct!.isNotEmpty
                        ? GridviewProductsSlider(
                            topTitle: AppLocalization.of(context)
                                    .getTransatedValues('youWatched') ??
                                '',
                            productList: userState.userData!.viewedProduct!,
                          )
                        : const SizedBox.shrink(),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

Row rowText({
  String? leftText,
  String? rightText,
  Color? color,
  double? fontSize,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        leftText!,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: AppFonts.fontSize14,
        ),
      ),
      Text(
        rightText!,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: fontSize ?? AppFonts.fontSize14,
          color: color ?? AppColors.blackColor,
        ),
      ),
    ],
  );
}
