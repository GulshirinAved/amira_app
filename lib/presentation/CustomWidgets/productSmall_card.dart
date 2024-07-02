// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amira_app/blocs/cart/cartButton/cart_button_bloc.dart';
import 'package:amira_app/data/models/cart_model.dart';
import 'package:amira_app/data/models/fav_model.dart';
import 'package:amira_app/presentation/CustomWidgets/cartAmount_button.dart';
import 'package:amira_app/presentation/Screens/home/productProfile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/presentation/CustomWidgets/button.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class ProductSmallCard extends StatelessWidget {
  final int index;
  final FavItem favItem;
  final CartItem cartItem;

  const ProductSmallCard({
    required this.index,
    required this.favItem,
    required this.cartItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => pushScreenWithNavBar(
          context,
          ProductProfileScreen(
            favItem: favItem,
          )),
      child: Container(
        width: 120.w,
        margin: EdgeInsets.only(right: 6.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //image
            Container(
              height: 120.h,
              width: 120.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.lightPurpleColor,
                borderRadius: AppBorders.borderRadius10,
              ),
              child: Image.asset(favItem.image!),
            ),
            Text(
              favItem.price!,
              style: TextStyle(
                fontFamily: fontPeaceSans,
                fontWeight: FontWeight.w500,
                fontSize: AppFonts.fontSize14,
              ),
            ),
            //  previous price and discount
            favItem.discount == null
                ? SizedBox(
                    height: 12.h,
                  )
                : Row(
                    children: [
                      Text(
                        favItem.prevPrice!,
                        style: TextStyle(
                          fontFamily: fontPeaceSans,
                          fontWeight: FontWeight.w400,
                          fontSize: AppFonts.fontSize12,
                          color: AppColors.greyColor,
                        ),
                      ),
                      Text(
                        favItem.discount!,
                        style: TextStyle(
                          fontFamily: fontPeaceSans,
                          fontWeight: FontWeight.w400,
                          fontSize: AppFonts.fontSize12,
                          color: AppColors.redColor,
                        ),
                      ),
                    ],
                  ),
            //name
            SizedBox(
              height: 36.h,
              child: Text(
                favItem.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: AppFonts.fontSize14,
                ),
              ),
            ),

            Expanded(
              child: BlocBuilder<CartButtonBloc, CartButtonState>(
                builder: (context, state) {
                  final isItemInCart =
                      state.cartList.any((item) => item.id == cartItem.id);
                  return !isItemInCart
                      ? Button.iconButton(
                          width: 120.w,
                          onTap: () {
                            context
                                .read<CartButtonBloc>()
                                .add(AddCartEvent(cartItem));
                            context
                                .read<CartButtonBloc>()
                                .add(SumProductEvent(cartItem));
                          },
                        )
                      : CartAmountButton(
                          index: index,
                          cartItem: cartItem,
                          width: 120.w,
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
