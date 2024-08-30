// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amira_app/blocs/cateloge/getAllBrands/get_all_brands_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:amira_app/blocs/filter/brandSelection/brand_selection_bloc.dart';
import 'package:amira_app/config/theme/constants.dart';

class BrandCards extends StatelessWidget {
  final int bottomSheet;
  const BrandCards({
    required this.bottomSheet,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllBrandsBloc, GetAllBrandsState>(
      builder: (context, brandState) {
        if (brandState is GetAllBrandsError) {
          return SizedBox.shrink();
        } else if (brandState is GetAllBrandsInitial ||
            brandState is GetAllBrandsLoading) {
          return SizedBox.shrink();
        } else if (brandState is GetAllBrandsLoaded) {
          if (brandState.allBrandsList.isEmpty) {
            return SizedBox.shrink();
          }
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: brandState.allBrandsList.length,
            padding: EdgeInsets.only(top: 5.h),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              mainAxisExtent: 44,
            ),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                context.read<BrandSelectionBloc>().add(
                      SelectBrand(
                          bottomSheet,
                          brandState.allBrandsList[index].name,
                          brandState.allBrandsList[index].id),
                    );
              },
              child: BlocBuilder<BrandSelectionBloc, BrandSelectionState>(
                builder: (context, state) {
                  final bool isSelected = (bottomSheet == 1
                          ? state.selectedBrandBottomSheet1
                          : state.selectedBrandBottomSheet2)
                      .any((brand) =>
                          brand['name'] ==
                          brandState.allBrandsList[index].name);
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
                      brandState.allBrandsList[index].name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isSelected
                            ? AppColors.whiteColor
                            : AppColors.blackColor,
                        fontWeight: FontWeight.w500,
                        fontSize: AppFonts.fontSize14,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return const Center(
            child: const CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
