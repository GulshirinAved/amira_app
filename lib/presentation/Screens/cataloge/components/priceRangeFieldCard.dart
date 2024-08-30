// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:amira_app/config/theme/constants.dart';
import 'package:amira_app/presentation/CustomWidgets/custom_textField.dart';

class PriceRangeFieldAndCard extends StatelessWidget {
  final int bottomSheet;
  final TextEditingController fromPriceController;
  final TextEditingController toPriceController;
  const PriceRangeFieldAndCard({
    required this.bottomSheet,
    required this.fromPriceController,
    required this.toPriceController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: EdgeInsets.only(top: 6.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: AppBorders.borderRadius10,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 5.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: Text(
                'Цена',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: AppFonts.fontSize14,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextField.normal(
                    context: context,
                    hintText: 'от',
                    rangeNumber: 6,
                    backColor: AppColors.lightGreyColor,
                    controller: fromPriceController,
                    isTextNumber: true,
                    onFieldSubmitted: (value) {},
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: CustomTextField.normal(
                    context: context,
                    hintText: 'до',
                    rangeNumber: 6,
                    backColor: AppColors.lightGreyColor,
                    controller: toPriceController,
                    isTextNumber: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
