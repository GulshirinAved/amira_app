import 'package:amira_app/blocs/filter/priceRangeSelection/price_range_selection_bloc.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/presentation/CustomWidgets/custom_textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceRangeFieldAndCard extends StatelessWidget {
  const PriceRangeFieldAndCard({
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
                    hintText: 'от',
                    backColor: AppColors.lightGreyColor,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: CustomTextField.normal(
                    hintText: 'до',
                    backColor: AppColors.lightGreyColor,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: Text(
                'Популярные диопозоны',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: AppFonts.fontSize14,
                ),
              ),
            ),
            SizedBox(
              height: 34.h,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: priceRange.length,
                itemBuilder: (context, index) => BlocBuilder<
                    PriceRangeSelectionBloc, PriceRangeSelectionState>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () => context
                          .read<PriceRangeSelectionBloc>()
                          .add(PriceRangeSelectionEvent(index)),
                      child: Container(
                        decoration: BoxDecoration(
                          color: state.selectedIndex == index
                              ? AppColors.blackColor
                              : AppColors.lightGreyColor,
                          borderRadius: AppBorders.borderRadius10,
                        ),
                        margin: EdgeInsets.only(right: 5.w),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                        child: Text(
                          priceRange[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: state.selectedIndex == index
                                ? AppColors.whiteColor
                                : AppColors.blackColor,
                            fontWeight: FontWeight.w500,
                            fontSize: AppFonts.fontSize14,
                          ),
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
    );
  }
}
