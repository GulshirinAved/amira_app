// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:amira_app/blocs/filter/brandSelection/brand_selection_bloc.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';

class BrandCards extends StatelessWidget {
  final int bottomSheet;
  const BrandCards({
    required this.bottomSheet,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: brands.length,
      padding: EdgeInsets.only(top: 5.h),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        mainAxisExtent: 44,
      ),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          context
              .read<BrandSelectionBloc>()
              .add(SelectBrand(bottomSheet, index));
        },
        child: BlocBuilder<BrandSelectionBloc, BrandSelectionState>(
          builder: (context, state) {
            bool isSelected = (bottomSheet == 1
                    ? state.selectedBrandBottomSheet1
                    : state.selectedBrandBottomSheet2) ==
                index;
            return Container(
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.blackColor
                    : AppColors.lightGreyColor,
                borderRadius: AppBorders.borderRadius10,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 8.h,
              ),
              child: Text(
                brands[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color:
                      isSelected ? AppColors.whiteColor : AppColors.blackColor,
                  fontWeight: FontWeight.w500,
                  fontSize: AppFonts.fontSize14,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
