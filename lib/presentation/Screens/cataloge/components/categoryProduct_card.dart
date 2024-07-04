// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amira_app/config/constants/constants.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:amira_app/config/theme/theme.dart';

class CategoryProductCard extends StatelessWidget {
  final int index;
  final List categoryProductList;
  const CategoryProductCard({
    required this.index,
    required this.categoryProductList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 126.w,
      margin: EdgeInsets.only(right: 3.w),
      decoration: BoxDecoration(
        color: AppColors.lightPurpleColor,
        borderRadius: AppBorders.borderRadius10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ExtendedImage.network(
              '$url${categoryProductList[index].images[0].url}',
              height: 106.h,
              width: 106.w,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            categoryProductList[index].name,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: AppFonts.fontSize14,
            ),
          ),
        ],
      ),
    );
  }
}
