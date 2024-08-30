// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amira_app/app_localization.dart';
import 'package:amira_app/blocs/addDeliveryLocation/location_add_bloc.dart';
import 'package:amira_app/blocs/auth/validateTextField/validate_text_field_bloc.dart';
import 'package:amira_app/blocs/cart/cartButton/cart_button_bloc.dart';
import 'package:amira_app/blocs/cart/createOrder/create_order_bloc.dart';
import 'package:amira_app/data/api_providers/auth_provider.dart';
import 'package:amira_app/data/models/updateUserData_model.dart';
import 'package:amira_app/presentation/CustomWidgets/customContainer_extension.dart';
import 'package:amira_app/presentation/Screens/auth/components/custom_textField.dart';
import 'package:amira_app/presentation/Screens/bottomNavBar/bottomNavBar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:amira_app/blocs/cart/paymentSelection/payment_selection_bloc.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/constants.dart';
import 'package:amira_app/presentation/CustomWidgets/button.dart';
import 'package:amira_app/presentation/CustomWidgets/radio_button.dart';
import 'package:amira_app/presentation/Screens/cart/cart_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

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
  late final Data? userData;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    addressController = TextEditingController();
    phonenumberController = TextEditingController();
    userData = AuthProvider().getUserData();
    nameController.text = userData!.name ?? '';
    addressController.text = userData!.address ?? '';
    phonenumberController.text = userData!.phone ?? '';
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phonenumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PaymentSelectionBloc(),
        ),
        BlocProvider(
          create: (context) => LocationAddBloc(),
        ),
        BlocProvider(
          create: (context) => CreateOrderBloc(),
        ),
        BlocProvider(
          create: (context) => ValidateTextFieldBloc(),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          body: ListView(
            children: [
              CustomContainer.buildContainer(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(vertical: 6.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalization.of(context)
                              .getTransatedValues('paymentMethod') ??
                          '',
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
              CustomContainer.buildContainer(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(vertical: 6.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalization.of(context)
                              .getTransatedValues('details') ??
                          '',
                      style: TextStyle(
                        fontFamily: fontPeaceSans,
                        fontWeight: FontWeight.w400,
                        fontSize: AppFonts.fontSize22,
                      ),
                    ),
                    //name
                    BlocBuilder<ValidateTextFieldBloc, ValidateTextFieldState>(
                      builder: (context, state) {
                        return BaseTextField(
                          hintText: AppLocalization.of(context)
                                  .getTransatedValues('name') ??
                              '',
                          topPadding: 15,
                          errorText: state.isNameValid
                              ? ''
                              : AppLocalization.of(context)
                                      .getTransatedValues('noName') ??
                                  '',
                          controller: nameController,
                          onChanged: (value) {
                            context
                                .read<ValidateTextFieldBloc>()
                                .add(NameChanged(name: value ?? ''));
                            return null;
                          },
                          isTextNumber: false,
                          prefixWidget: const SizedBox.shrink(),
                          backColor: AppColors.lightGreyColor,
                          borderColor: AppColors.lightGreyColor,
                        );
                      },
                    ),
                    //address
                    BlocBuilder<ValidateTextFieldBloc, ValidateTextFieldState>(
                      builder: (context, state) {
                        return BlocBuilder<LocationAddBloc, LocationAddState>(
                          builder: (context, locationState) {
                            addressController.text =
                                locationState.savedLocation == ''
                                    ? userData!.address!
                                    : locationState.savedLocation;
                            return BaseTextField(
                              hintText: AppLocalization.of(context)
                                      .getTransatedValues('address') ??
                                  '',
                              topPadding: 15,
                              errorText: state.isPassValid
                                  ? ''
                                  : AppLocalization.of(context)
                                          .getTransatedValues('noAddress') ??
                                      '',
                              controller: addressController,
                              onChanged: (value) {
                                context
                                    .read<ValidateTextFieldBloc>()
                                    .add(AddressChanged(address: value ?? ''));
                                return null;
                              },
                              isTextNumber: false,
                              prefixWidget: const SizedBox.shrink(),
                              backColor: AppColors.lightGreyColor,
                              borderColor: AppColors.lightGreyColor,
                            );
                          },
                        );
                      },
                    ),
                    //phone
                    BlocBuilder<ValidateTextFieldBloc, ValidateTextFieldState>(
                      builder: (context, state) {
                        return BaseTextField(
                          hintText: '(61) 87 67 98',
                          topPadding: 15,
                          errorText: state.isPhoneValid
                              ? ''
                              : AppLocalization.of(context)
                                      .getTransatedValues('noName') ??
                                  '',
                          controller: phonenumberController,
                          onChanged: (value) {
                            context.read<ValidateTextFieldBloc>().add(
                                  PhoneNumberChanged(phoneNumber: value ?? ''),
                                );
                            return null;
                          },
                          isTextNumber: true,
                          prefixWidget: const SizedBox.shrink(),
                          backColor: AppColors.lightGreyColor,
                          borderColor: AppColors.lightGreyColor,
                          readOnly: true,
                          rangeNumber: 8,
                        );
                      },
                    ),
                  ],
                ),
              ),
              CustomContainer.buildContainer(
                width: MediaQuery.of(context).size.width,
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
                      leftText: AppLocalization.of(context)
                              .getTransatedValues('products') ??
                          '',
                      rightText: widget.productsSumPrice.toString(),
                    ),
                    rowText(
                      leftText: AppLocalization.of(context)
                              .getTransatedValues('sale') ??
                          '',
                      rightText: widget.discountPrice.toString(),
                      color: AppColors.redColor,
                    ),
                    rowText(
                      leftText: AppLocalization.of(context)
                              .getTransatedValues('sum') ??
                          '',
                      rightText: widget.totalPrice.toString(),
                      color: AppColors.purpleColor,
                      fontSize: AppFonts.fontSize22,
                    ),
                    BlocListener<CreateOrderBloc, CreateOrderState>(
                      listener: (context, state) {
                        if (state is CreateOrderSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalization.of(context)
                                        .getTransatedValues('orderSuccess') ??
                                    '',
                              ),
                            ),
                          );
                        }
                        if (state is CreateOrderFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalization.of(context)
                                        .getTransatedValues('error') ??
                                    '',
                              ),
                            ),
                          );
                        }
                      },
                      child: BlocBuilder<CartButtonBloc, CartButtonState>(
                        builder: (context, cartState) {
                          return BlocBuilder<PaymentSelectionBloc,
                              PaymentSelectionState>(
                            builder: (context, state) {
                              return Button.textButton(
                                text: AppLocalization.of(context)
                                        .getTransatedValues('toPay') ??
                                    '',
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
                                                'productId': cartState
                                                    .cartList[index].id,
                                                'shopId': cartState
                                                    .cartList[index].shopid,
                                                'quantity': cartState
                                                    .cartList[index].quantity,
                                              },
                                            ),
                                          },
                                        ),
                                      );
                                  pushScreenWithoutNavBar(
                                    context,
                                    const BottomNavBar(),
                                  );
                                },
                              );
                            },
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
      ),
    );
  }
}
