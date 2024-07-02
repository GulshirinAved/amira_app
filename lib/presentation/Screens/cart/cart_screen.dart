import 'package:amira_app/blocs/cart/cartButton/cart_button_bloc.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/data/models/cart_model.dart';
import 'package:amira_app/data/models/fav_model.dart';
import 'package:amira_app/presentation/CustomWidgets/button.dart';
import 'package:amira_app/presentation/Screens/cart/cartPayment_screen.dart';
import 'package:amira_app/presentation/Screens/cart/components/cartProduct_card.dart';
import 'package:amira_app/presentation/Screens/home/components/deliveryAddress_tile.dart';
import 'package:amira_app/presentation/Screens/home/components/gridviewProducts_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            //delivery location
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: const DeliveryAddressTile(),
            ),
            //cart product cards
            BlocBuilder<CartButtonBloc, CartButtonState>(
              builder: (context, state) {
                if (state is CartButtonInitial || state.cartList.isEmpty) {
                  return const Center(
                    child: const Text('There is no products'),
                  );
                }
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: AppBorders.borderRadius10,
                      ),
                      margin: EdgeInsets.symmetric(vertical: 6.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10.h,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: state.cartList.length,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => CartProductCard(
                          index: index,
                          favItem: FavItem(
                            id: state.cartList[index].id,
                            name: state.cartList[index].name,
                            desc: state.cartList[index].desc,
                            discount: state.cartList[index].discount,
                            image: state.cartList[index].image,
                            prevPrice: state.cartList[index].prevPrice,
                            price: state.cartList[index].price,
                          ),
                          cartItem: CartItem(
                            id: state.cartList[index].id,
                            name: state.cartList[index].name,
                            desc: state.cartList[index].desc,
                            discount: state.cartList[index].discount,
                            image: state.cartList[index].image,
                            prevPrice: state.cartList[index].prevPrice,
                            price: state.cartList[index].price,
                          ),
                        ),
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                          color: AppColors.lightGreyColor,
                          endIndent: 10,
                          indent: 10,
                        ),
                      ),
                    ),
                    //cart price card
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: AppBorders.borderRadius10,
                      ),
                      margin: EdgeInsets.symmetric(vertical: 6.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Корзина',
                            style: TextStyle(
                              fontFamily: fontPeaceSans,
                              fontWeight: FontWeight.w400,
                              fontSize: AppFonts.fontSize22,
                            ),
                          ),
                          BlocBuilder<CartButtonBloc, CartButtonState>(
                            builder: (context, state) {
                              return rowText(
                                  leftText: 'Товары',
                                  rightText: state.sum.toString());
                            },
                          ),
                          rowText(
                            leftText: 'Скидка',
                            rightText: '-12.00',
                            color: AppColors.redColor,
                          ),
                          rowText(
                            leftText: 'Итого',
                            rightText: '38.75',
                            color: AppColors.purpleColor,
                            fontSize: AppFonts.fontSize22,
                          ),
                          Button.textButton(
                            text: 'Оформить заказ',
                            onTap: () {
                              pushScreenWithNavBar(
                                context,
                                const CartPaymentScreen(),
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

            const GridviewProductsSlider(
              topTitle: 'Вы смотрели',
            ),
          ],
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
