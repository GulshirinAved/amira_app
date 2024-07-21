// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amira_app/blocs/cateloge/getAllProducts/all_products_bloc.dart';
import 'package:amira_app/blocs/cateloge/subCategoryCardSelection/sub_category_selection_bloc.dart';
import 'package:amira_app/blocs/filter/brandSelection/brand_selection_bloc.dart';
import 'package:amira_app/blocs/filter/filter/categoryRadioButtonSelection/category_radio_button_selection_bloc.dart';

import 'package:amira_app/data/models/category_model.dart';
import 'package:amira_app/presentation/Screens/cataloge/categoryProfile_screen.dart';
import 'package:amira_app/presentation/Screens/cataloge/components/categoryProduct_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/presentation/Screens/home/components/sliderTopTitle.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CategoryProductsSlider extends StatelessWidget {
  final List<Rows> subCategoryList;
  final List categoryList;
  final String topTitle;
  final List selectedBrand;
  final int index;
  final String categoryId;

  const CategoryProductsSlider({
    required this.subCategoryList,
    required this.categoryList,
    required this.topTitle,
    required this.index,
    required this.selectedBrand,
    required this.categoryId,
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
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //toptitle
          TopTitle(
            title: topTitle,
            onTap: () {
              context
                  .read<SubCategorySelectionBloc>()
                  .add(const SubCategorySelectionEvent(pressedName: ''));
              context
                  .read<CategoryRadioButtonSelectionBloc>()
                  .add(SelectRadioButtonEvent('', ''));
              context
                  .read<CategoryRadioButtonSelectionBloc>()
                  .add(ApplyRadioButtonEvent());
              context.read<BrandSelectionBloc>().add(const ClearBrandEvent());

              pushScreenWithNavBar(
                context,
                BlocBuilder<SubCategorySelectionBloc,
                    SubCategorySelectionState>(
                  builder: (context, state) {
                    return CategoryProfileScreen(
                      subCategoryList: subCategoryList,
                      categoryList: categoryList,
                      index: index,
                      titlePressed: true,
                      topTitle: topTitle,
                      brandName: selectedBrand,
                      categoryId: categoryList[index].id,
                    );
                  },
                ),
              );
            },
          ),
          //subCategory Slider
          SizedBox(
            height: 157.h,
            child: BlocBuilder<AllProductsBloc, AllProductsState>(
              builder: (context, state) {
                if (state is AllProductsError) {
                  return Center(
                    child: Text(state.error.toString()),
                  );
                } else if (state is AllProductsInitial ||
                    state is AllProductsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is AllProductsLoaded) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: subCategoryList.length,
                    itemBuilder: (context, index) {
                      //subCategory card
                      return CategoryProductCard(
                        index: index,
                        subCategoryList: subCategoryList,
                        categoryList: categoryList,
                        needNavigate: true,
                        topTitle: topTitle,
                        selectedBrandName: selectedBrand,
                        categoryId: categoryId,
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
