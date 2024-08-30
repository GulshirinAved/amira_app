import 'package:amira_app/blocs/cart/cartButton/cart_button_bloc.dart';
import 'package:amira_app/blocs/favButton/favbutton_bloc.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/constants.dart';
import 'package:amira_app/data/models/cart_model.dart';
import 'package:amira_app/data/models/fav_model.dart';
import 'package:amira_app/presentation/CustomWidgets/cartAmount_button.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CartProductCard extends StatelessWidget {
  final CartItem cartItem;
  final FavItem favItem;

  final int index;
  const CartProductCard({
    required this.cartItem,
    required this.favItem,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          ClipRRect(
              borderRadius: AppBorders.borderRadius10,
              child: cartItem.image![0] is Map<String, dynamic>
                  ? ExtendedImage.network(
                      '$url' + cartItem.image![0]['url']!,
                      height: 75.h,
                      width: 75.h,
                      fit: BoxFit.cover,
                    )
                  : ExtendedImage.network(
                      '$url' + cartItem.image![0].url,
                      height: 75.h,
                      width: 75.h,
                      fit: BoxFit.cover,
                    )),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Prices
                        Text(
                          '${cartItem.price!.toString()} ${cartItem.coin == null ? '' : '.${cartItem.coin}'} TMT',
                          style: TextStyle(
                            fontFamily: fontPeaceSans,
                            fontWeight: FontWeight.w400,
                            fontSize: AppFonts.fontSize14,
                          ),
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        cartItem.discount?.percent == null
                            ? SizedBox.shrink()
                            : Text(
                                '${cartItem.discount?.percent} % ',
                                style: TextStyle(
                                  color: AppColors.greyColor,
                                  fontFamily: fontPeaceSans,
                                  fontWeight: FontWeight.w400,
                                  fontSize: AppFonts.fontSize12,
                                ),
                              ),
                      ],
                    ),
                    // Heart icon
                    BlocBuilder<FavButtonBloc, FavButtonState>(
                      builder: (context, state) {
                        final isFav =
                            state.favList.any((item) => item.id == favItem.id);
                        return GestureDetector(
                          onTap: () {
                            context
                                .read<FavButtonBloc>()
                                .add(ToggleFavEvent(item: favItem));
                          },
                          child: SvgPicture.asset(
                            isFav ? heartBoldIcon : heartIcon,
                            colorFilter: ColorFilter.mode(
                              isFav
                                  ? AppColors.purpleColor
                                  : AppColors.greyColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Text(
                  cartItem.name!,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: AppFonts.fontSize14,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Trash icon
                    GestureDetector(
                      onTap: () {
                        context
                            .read<CartButtonBloc>()
                            .add(RemoveCartEvent(cartItem));
                        context.read<CartButtonBloc>().add(SumProductEvent());
                      },
                      child: SvgPicture.asset(trashIcon),
                    ),
                    const Spacer(),
                    CartAmountButton(
                      cartItem: cartItem,
                      index: index,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
