// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:amira_app/blocs/cart/cartButton/cart_button_bloc.dart';
import 'package:amira_app/config/theme/constants.dart';
import 'package:amira_app/data/models/cart_model.dart';

class CartAmountButton extends StatelessWidget {
  final CartItem cartItem;
  final int index;
  final double? width;
  final double? height;

  const CartAmountButton({
    required this.cartItem,
    required this.index,
    this.width,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 25.h,
      width: width ?? 85.w,
      decoration: BoxDecoration(
        color: AppColors.purpleColor,
        borderRadius: AppBorders.borderRadius10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              context.read<CartButtonBloc>().add(MinusButtonEvent(cartItem));
              context.read<CartButtonBloc>().add(SumProductEvent());
            },
            child: Icon(
              CupertinoIcons.minus,
              color: AppColors.whiteColor,
              size: 17,
            ),
          ),
          BlocBuilder<CartButtonBloc, CartButtonState>(
            builder: (context, state) {
              final cartItemIndex =
                  state.cartList.indexWhere((item) => item.id == cartItem.id);
              final quantity = cartItemIndex != -1
                  ? state.cartList[cartItemIndex].quantity
                  : 0;
              return Text(
                quantity.toString(),
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w500,
                  fontSize: AppFonts.fontSize14,
                ),
              );
            },
          ),
          GestureDetector(
            onTap: () {
              context.read<CartButtonBloc>().add(PlusButtonEvent(cartItem));
              context.read<CartButtonBloc>().add(SumProductEvent());
            },
            child: Icon(
              CupertinoIcons.add,
              color: AppColors.whiteColor,
              size: 17,
            ),
          ),
        ],
      ),
    );
  }
}
