import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/presentation/CustomWidgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProductLargeCard extends StatelessWidget {
  final int index;
  const ProductLargeCard({
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //image
          Container(
            height: 180.h,
            width: 180.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.lightPurpleColor,
              borderRadius: AppBorders.borderRadius10,
            ),
            child: Image.asset(saleProducts[index]['image']),
          ),
          // price, previous price and discount

          Row(
            children: [
              Text(
                saleProducts[index]['price'],
                style: TextStyle(
                  fontFamily: fontPeaceSans,
                  fontWeight: FontWeight.w500,
                  fontSize: AppFonts.fontSize14,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Text(
                  saleProducts[index]['prev_price'],
                  style: TextStyle(
                    fontFamily: fontPeaceSans,
                    fontWeight: FontWeight.w400,
                    fontSize: AppFonts.fontSize12,
                    color: AppColors.greyColor,
                  ),
                ),
              ),
              Text(
                saleProducts[index]['discount'],
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
              saleProducts[index]['name'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: AppFonts.fontSize14,
              ),
            ),
          ),
          //desc
          Text(
            saleProducts[index]['desc'],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: AppFonts.fontSize14,
              color: AppColors.greyColor,
            ),
          ),
          Row(
            children: [
              const Expanded(
                child: Button(
                  width: 120,
                ),
              ),
              Container(
                height: 30.h,
                margin: EdgeInsets.only(left: 5.w),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.greyColor,
                  ),
                  borderRadius: AppBorders.borderRadius10,
                ),
                padding: const EdgeInsets.all(5),
                child: SvgPicture.asset(heartIcon),
              ),
            ],
          )
        ],
      ),
    );
  }
}
