import 'package:amira_app/blocs/filter/brandSelection/brand_selection_bloc.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrandCards extends StatelessWidget {
  const BrandCards({
    super.key,
  });

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
          context.read<BrandSelectionBloc>().add(BrandSelectionEvent(index));
        },
        child: BlocBuilder<BrandSelectionBloc, BrandSelectionState>(
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                color: state.selectedIndex == index
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
                  color: state.selectedIndex == index
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
  }
}
