import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/presentation/CustomWidgets/productSmall_card.dart';
import 'package:amira_app/presentation/Screens/home/components/sliderTopTitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HouseSlider extends StatelessWidget {
  const HouseSlider({
    super.key,
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
          const TopTitle(
            title: 'Дом',
          ),
          SizedBox(
            height: 240.h,
            child: ListView.builder(
              itemCount: houseProducts.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return ProductSmallCard(
                  index: index,
                  productList: houseProducts,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
