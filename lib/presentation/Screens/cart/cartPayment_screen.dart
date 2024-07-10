// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amira_app/blocs/cart/cartButton/cart_button_bloc.dart';
import 'package:amira_app/blocs/cart/createOrder/create_order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:amira_app/blocs/cart/paymentSelection/payment_selection_bloc.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/presentation/CustomWidgets/button.dart';
import 'package:amira_app/presentation/CustomWidgets/custom_textField.dart';
import 'package:amira_app/presentation/CustomWidgets/radio_button.dart';
import 'package:amira_app/presentation/Screens/cart/cart_screen.dart';

class CartPaymentScreen extends StatefulWidget {
  final double productsSumPrice;
  final double discountPrice;
  final double totalPrice;
  const CartPaymentScreen({
    required this.productsSumPrice,
    required this.discountPrice,
    required this.totalPrice,
    Key? key,
  }) : super(key: key);

  @override
  State<CartPaymentScreen> createState() => _CartPaymentScreenState();
}

class _CartPaymentScreenState extends State<CartPaymentScreen> {
  late TextEditingController nameController;
  late TextEditingController addressController;
  late TextEditingController phonenumberController;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    addressController = TextEditingController();
    phonenumberController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PaymentSelectionBloc(),
        ),
        BlocProvider(
          create: (context) => CreateOrderBloc(),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          body: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: AppBorders.borderRadius10,
                ),
                margin: EdgeInsets.symmetric(vertical: 6.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Способ оплаты',
                      style: TextStyle(
                        fontFamily: fontPeaceSans,
                        fontWeight: FontWeight.w400,
                        fontSize: AppFonts.fontSize22,
                      ),
                    ),
                    //payment methods radio button
                    Column(
                      children: List.generate(
                        paymentMethod.length,
                        (index) => BlocBuilder<PaymentSelectionBloc,
                            PaymentSelectionState>(
                          builder: (context, state) {
                            return CustomRadioButton(
                              isRight: true,
                              title: paymentMethod[index],
                              value: paymentMethod[index],
                              groupValue: state.title == ''
                                  ? paymentMethod[0]
                                  : state.title,
                              onChanged: (value) =>
                                  context.read<PaymentSelectionBloc>().add(
                                        PaymentSelectionEvent(
                                          value ?? paymentMethod[0],
                                        ),
                                      ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //Data about user
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
                      'Способ оплаты',
                      style: TextStyle(
                        fontFamily: fontPeaceSans,
                        fontWeight: FontWeight.w400,
                        fontSize: AppFonts.fontSize22,
                      ),
                    ),
                    CustomTextField.normal(
                      context: context,
                      hintText: 'Имя',
                      backColor: AppColors.lightGreyColor,
                      controller: nameController,
                      isTextNumber: false,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: CustomTextField.normal(
                        context: context,
                        hintText: 'Гарашсызлык 15',
                        backColor: AppColors.lightGreyColor,
                        controller: addressController,
                        isTextNumber: false,
                      ),
                    ),
                    CustomTextField.normal(
                      context: context,
                      hintText: '+993 (61) 87 67 98',
                      backColor: AppColors.lightGreyColor,
                      controller: phonenumberController,
                      isTextNumber: true,
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: AppBorders.borderRadius10,
                ),
                margin: EdgeInsets.symmetric(vertical: 6.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Выш заказ',
                      style: TextStyle(
                        fontFamily: fontPeaceSans,
                        fontWeight: FontWeight.w400,
                        fontSize: AppFonts.fontSize22,
                      ),
                    ),
                    rowText(
                      leftText: 'Товары',
                      rightText: widget.productsSumPrice.toString(),
                    ),
                    rowText(
                      leftText: 'Скидка',
                      rightText: widget.discountPrice.toString(),
                      color: AppColors.redColor,
                    ),
                    rowText(
                      leftText: 'Итого',
                      rightText: widget.totalPrice.toString(),
                      color: AppColors.purpleColor,
                      fontSize: AppFonts.fontSize22,
                    ),
                    BlocBuilder<CartButtonBloc, CartButtonState>(
                      builder: (context, cartState) {
                        return BlocBuilder<PaymentSelectionBloc,
                            PaymentSelectionState>(
                          builder: (context, state) {
                            return Button.textButton(
                              text: 'Оплатить',
                              onTap: () {
                                context.read<CreateOrderBloc>().add(
                                      CreateOrderPressed(
                                        postData: {
                                          'address': addressController.text,
                                          'name': nameController.text,
                                          'phone': phonenumberController.text,
                                          'payment': state.title == '' ||
                                                  state.title ==
                                                      paymentMethod[0]
                                              ? 'onlinePay'
                                              : 'cashPay',
                                          'summa': widget.totalPrice,
                                          'products': List.generate(
                                            cartState.cartList.length,
                                            (index) => {
                                              'productId':
                                                  cartState.cartList[index].id,
                                              'shopId': cartState
                                                  .cartList[index].shopid,
                                              'quantity': cartState
                                                  .cartList[index].quantity,
                                            },
                                          ),
                                        },
                                      ),
                                    );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
