// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amira_app/presentation/CustomWidgets/cartAmount_button.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import 'package:amira_app/blocs/cart/cartButton/cart_button_bloc.dart';
import 'package:amira_app/blocs/favButton/favbutton_bloc.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/constants.dart';
import 'package:amira_app/data/models/cart_model.dart';
import 'package:amira_app/data/models/fav_model.dart';
import 'package:amira_app/presentation/CustomWidgets/button.dart';
import 'package:amira_app/presentation/Screens/home/productProfile_screen.dart';

class ProductLargeCard extends StatelessWidget {
  final FavItem favItem;
  final CartItem cartItem;
  final int index;
  const ProductLargeCard({
    required this.favItem,
    required this.cartItem,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => pushScreenWithNavBar(
        context,
        ProductProfileScreen(
          favItem: favItem,
          cartItem: cartItem,
          index: index,
        ),
      ),
      child: Container(
        color: AppColors.whiteColor,
        margin: EdgeInsets.symmetric(horizontal: 3.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //image
            Container(
              height: 160.h,
              width: 160.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.lightPurpleColor,
                borderRadius: AppBorders.borderRadius10,
              ),
              child: ClipRRect(
                borderRadius: AppBorders.borderRadius10,
                child: (cartItem.image != null && cartItem.image!.isNotEmpty)
                    ? (cartItem.image![0] is Map<String, dynamic>
                        ? ExtendedImage.network(
                            url + cartItem.image![0]['url']!,
                            height: 160.h,
                            width: 160.h,
                            fit: BoxFit.cover,
                          )
                        : ExtendedImage.network(
                            url + cartItem.image![0].url,
                            height: 160.h,
                            width: 160.h,
                            fit: BoxFit.cover,
                          ))
                    : Container(
                        height: 160.h,
                        width: 160.h,
                        color: AppColors.lightPurpleColor,
                        child: const Center(child: Text('No Image')),
                      ),
              ),
            ),
            // price, previous price and discount

            Row(
              children: [
                favItem.price == null
                    ? const SizedBox.shrink()
                    : Text(
                        '${favItem.price!.toString()} ${favItem.coin == null ? '' : '.${favItem.coin}'}',
                        style: TextStyle(
                          fontFamily: fontPeaceSans,
                          fontWeight: FontWeight.w500,
                          fontSize: AppFonts.fontSize14,
                        ),
                      ),
                favItem.discount?.price == null
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Text(
                          '${favItem.discount?.price}',
                          style: TextStyle(
                            fontFamily: fontPeaceSans,
                            fontWeight: FontWeight.w400,
                            fontSize: AppFonts.fontSize12,
                            color: AppColors.greyColor,
                          ),
                        ),
                      ),
                favItem.discount?.percent == null
                    ? const SizedBox.shrink()
                    : Text(
                        '${favItem.discount?.percent}%',
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
            //desc
            SizedBox(
              height: 36.h,
              child: Text(
                favItem.desc ?? '',
                maxLines: 2,
                textAlign: TextAlign.justify,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: AppFonts.fontSize14,
                  color: AppColors.greyColor,
                ),
              ),
            ),
            SizedBox(
              height: 34.h,
              child: Row(
                children: [
                  Expanded(
                    child: BlocBuilder<CartButtonBloc, CartButtonState>(
                      builder: (context, state) {
                        final isItemInCart = state.cartList
                            .any((item) => item.id == cartItem.id);
                        return !isItemInCart
                            ? Button.iconButton(
                                width: 120.w,
                                onTap: () {
                                  context
                                      .read<CartButtonBloc>()
                                      .add(AddCartEvent(cartItem));
                                  context
                                      .read<CartButtonBloc>()
                                      .add(SumProductEvent());
                                },
                              )
                            : CartAmountButton(
                                index: index,
                                cartItem: cartItem,
                                height: 34.w,
                              );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context
                        .read<FavButtonBloc>()
                        .add(ToggleFavEvent(item: favItem)),
                    child: BlocBuilder<FavButtonBloc, FavButtonState>(
                      builder: (context, state) {
                        return Container(
                          height: 30.h,
                          margin: EdgeInsets.only(left: 5.w),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: state.favList
                                      .any((item) => item.id == favItem.id)
                                  ? AppColors.purpleColor
                                  : AppColors.greyColor,
                            ),
                            color: state.favList
                                    .any((item) => item.id == favItem.id)
                                ? AppColors.purpleColor
                                : AppColors.whiteColor,
                            borderRadius: AppBorders.borderRadius10,
                          ),
                          padding: const EdgeInsets.all(5),
                          child: SvgPicture.asset(
                            state.favList.any((item) => item.id == favItem.id)
                                ? heartBoldIcon
                                : heartIcon,
                            colorFilter: ColorFilter.mode(
                              state.favList.any((item) => item.id == favItem.id)
                                  ? AppColors.whiteColor
                                  : AppColors.greyColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
