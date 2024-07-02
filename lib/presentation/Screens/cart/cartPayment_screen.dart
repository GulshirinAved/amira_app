import 'package:amira_app/blocs/cart/paymentSelection/payment_selection_bloc.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/presentation/CustomWidgets/button.dart';
import 'package:amira_app/presentation/CustomWidgets/custom_textField.dart';
import 'package:amira_app/presentation/CustomWidgets/radio_button.dart';
import 'package:amira_app/presentation/Screens/cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartPaymentScreen extends StatelessWidget {
  const CartPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentSelectionBloc(),
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
                    )
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
                      hintText: 'Имя',
                      backColor: AppColors.lightGreyColor,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: CustomTextField.normal(
                        hintText: 'Гарашсызлык 15',
                        backColor: AppColors.lightGreyColor,
                      ),
                    ),
                    CustomTextField.normal(
                      hintText: '+993 (61) 87 67 98',
                      backColor: AppColors.lightGreyColor,
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
                    rowText(leftText: 'Товары', rightText: '50.75'),
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
                      text: 'Оплатить',
                      onTap: () {},
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
