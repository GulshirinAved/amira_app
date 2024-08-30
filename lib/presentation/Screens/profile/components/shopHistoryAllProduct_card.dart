import 'package:amira_app/app_localization.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/constants.dart';
import 'package:amira_app/presentation/CustomWidgets/customContainer_extension.dart';
import 'package:amira_app/presentation/Screens/profile/components/shopHistory_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ShopHistoryAllProductCard extends StatelessWidget {
  final List ordersList;
  final int index;
  final double? topMargin;
  final double? topPadding;
  const ShopHistoryAllProductCard({
    required this.ordersList,
    required this.index,
    this.topMargin,
    this.topPadding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer.buildContainer(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: topMargin?.h ?? 0),
      padding:
          EdgeInsets.symmetric(horizontal: 16.w, vertical: topPadding?.h ?? 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
//data
          Text(
            DateFormat('yyyy-MM-dd – kk:mm')
                .format(ordersList[index].createdAt),
            style: TextStyle(
              fontFamily: fontPeaceSans,
              fontWeight: FontWeight.w400,
              fontSize: AppFonts.fontSize14,
            ),
          ),
//divider
          Divider(
            color: AppColors.greyColor,
          ),
//ordered Products
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, productIndex) => Column(
              children: [
                ShopHistoryCard(
                  image: ordersList[index]
                      .orderProducts[productIndex]
                      .product
                      .images[0]
                      .url,
                  name: ordersList[index]
                      .orderProducts[productIndex]
                      .product
                      .translations[
                          AppLocalization.of(context).locale == 'tr' ? 0 : 1]
                      .name,
                  description: ordersList[index]
                      .orderProducts[productIndex]
                      .product
                      .translations[
                          AppLocalization.of(context).locale == 'tr' ? 0 : 1]
                      .description,
                ),
              ],
            ),
            separatorBuilder: (context, productIndex) => Divider(
              color: AppColors.lightGreyColor,
            ),
            itemCount: ordersList[index].orderProducts.length,
          ),
//number of orders
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalization.of(context)
                          .getTransatedValues('orderAmount') ??
                      '',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: AppFonts.fontSize14,
                  ),
                ),
                Text(
                  ordersList[index].orderProducts.length.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: AppFonts.fontSize14,
                  ),
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 20),
          //   child: Button.textButton(
          //     text: AppLocalization.of(context).getTransatedValues('reorder') ??
          //         '',
          //     onTap: () {
          //       pushScreen(context,
          //           screen: CartPaymentScreen(
          //             productsSumPrice: ordersList[index].price,
          //             discountPrice: 0,

          //             totalPrice: ordersList[index].price,
          //           ));
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
