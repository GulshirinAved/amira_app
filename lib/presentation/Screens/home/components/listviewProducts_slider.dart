// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/presentation/CustomWidgets/productSmall_card.dart';
import 'package:amira_app/presentation/Screens/home/components/sliderTopTitle.dart';

class ListviewProductsSlider extends StatelessWidget {
  final String topTitle;
  final List productsList;
  const ListviewProductsSlider({
    super.key,
    required this.topTitle,
    required this.productsList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
        ),
      ),
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          TopTitle(title: topTitle),
          SizedBox(
            height: 240.h,
            child: ListView.builder(
              itemCount: productsList.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return ProductSmallCard(
                  index: index,
                  productList: productsList,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}