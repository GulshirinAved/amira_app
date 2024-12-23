import 'package:amira_app/blocs/filter/filter/categoryRadioButtonSelection/category_radio_button_selection_bloc.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterChipCard extends StatelessWidget {
  final int index;
  final bool? isTopPressed;
  const FilterChipCard({
    required this.index,
    required this.isTopPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38.h,
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 8.h,
      ),
      margin: const EdgeInsets.all(
        3,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: AppBorders.borderRadius10,
        color: index == 0 ? AppColors.blackColor : AppColors.lightGreyColor,
      ),
      child: BlocBuilder<CategoryRadioButtonSelectionBloc,
          CategoryRadioButtonSelectionState>(
        builder: (context, state) {
          return Text(
            index == 0 ? state.selectedTitle : filtername[index],
            style: TextStyle(
              color: index == 0 ? AppColors.whiteColor : AppColors.blackColor,
              fontWeight: FontWeight.w500,
              fontSize: AppFonts.fontSize14,
            ),
          );
        },
      ),
    );
  }
}
