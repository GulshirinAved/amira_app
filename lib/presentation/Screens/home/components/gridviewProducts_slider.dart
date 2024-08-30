// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amira_app/data/models/cart_model.dart';
import 'package:amira_app/data/models/fav_model.dart';
import 'package:amira_app/presentation/CustomWidgets/customContainer_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/constants.dart';
import 'package:amira_app/presentation/CustomWidgets/productLarge_card.dart';

class GridviewProductsSlider extends StatelessWidget {
  final String topTitle;
  final List<dynamic> productList;
  const GridviewProductsSlider({
    required this.topTitle,
    required this.productList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer.buildContainer(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            topTitle,
            style: TextStyle(
              color: AppColors.blackColor,
              fontFamily: fontPeaceSans,
              fontSize: AppFonts.fontSize22,
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 370,
            ),
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return ProductLargeCard(
                index: index,
                cartItem: CartItem(
                  id: productList[index].id.toString(),
                  name: productList[index].name,
                  image: productList[index].images,
                  price: productList[index].price,
                  discount: productList[index].discount,
                  desc: productList[index].description,
                  shopid: productList[index].shopId,
                  coin: productList[index].coin,
                ),
                favItem: FavItem(
                  id: productList[index].id.toString(),
                  name: productList[index].name,
                  image: productList[index].images,
                  price: productList[index].price,
                  discount: productList[index].discount,
                  desc: productList[index].description,
                  shopid: productList[index].shopId,
                  coin: productList[index].coin,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
