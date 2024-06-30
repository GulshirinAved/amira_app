// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/presentation/CustomWidgets/button.dart';

class ProductSmallCard extends StatelessWidget {
  final int index;
  final List productList;
  const ProductSmallCard({
    required this.index,
    required this.productList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Image.asset(productList[index]['image']),
          ),
          Text(
            productList[index]['price'],
            style: TextStyle(
              fontFamily: fontPeaceSans,
              fontWeight: FontWeight.w500,
              fontSize: AppFonts.fontSize14,
            ),
          ),
          //  previous price and discount
          productList[index]['discount'] == null
              ? SizedBox(
                  height: 12.h,
                )
              : Row(
                  children: [
                    Text(
                      productList[index]['prev_price'],
                      style: TextStyle(
                        fontFamily: fontPeaceSans,
                        fontWeight: FontWeight.w400,
                        fontSize: AppFonts.fontSize12,
                        color: AppColors.greyColor,
                      ),
                    ),
                    Text(
                      productList[index]['discount'],
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
              productList[index]['name'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: AppFonts.fontSize14,
              ),
            ),
          ),

          Button.iconButton(
            120.w,
            () {},
          ),
        ],
      ),
    );
  }
}
