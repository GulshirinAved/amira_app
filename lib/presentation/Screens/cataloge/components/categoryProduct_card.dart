// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amira_app/blocs/cateloge/getAllProducts/all_products_bloc.dart';
import 'package:amira_app/blocs/cateloge/getOneCataloge/get_one_cateloge_bloc.dart';
import 'package:amira_app/blocs/cateloge/subCategoryCardSelection/sub_category_selection_bloc.dart';
import 'package:amira_app/blocs/filter/brandSelection/brand_selection_bloc.dart';
import 'package:amira_app/blocs/filter/filter/categoryRadioButtonSelection/category_radio_button_selection_bloc.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/data/models/category_model.dart';
import 'package:amira_app/presentation/Screens/cataloge/categoryProfile_screen.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:amira_app/config/theme/theme.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CategoryProductCard extends StatelessWidget {
  final int index;
  final List<Rows> subCategoryList;
  final List categoryList;
  final double? imageHeight;
  final bool needNavigate;
  final String topTitle;
  final List selectedBrandName;
  final String categoryId;

  const CategoryProductCard({
    required this.index,
    required this.subCategoryList,
    required this.categoryList,
    required this.needNavigate,
    required this.topTitle,
    required this.selectedBrandName,
    required this.categoryId,
    this.imageHeight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<SubCategorySelectionBloc>().add(
              SubCategorySelectionEvent(
                pressedName: subCategoryList[index].name ?? '',
              ),
            );
        context
            .read<GetOneCatelogeBloc>()
            .add(GetOneCataloge(id: categoryList[index].id!));
        context.read<AllProductsBloc>().add(
              GetAllProductsList(
                postData: {
                  'categories': [subCategoryList[index].id],
                  'brands': selectedBrandName,
                  'shops': [],
                  'priceFrom': null,
                  'priceTo': null,
                  'ordering': 'popular',
                  'search': '',
                  'page': 1,
                  'pageSize': 10,
                  'discount': false,
                  'isLiked': true,
                },
              ),
            );
        context.read<CategoryRadioButtonSelectionBloc>().add(
            SelectRadioButtonEvent(subCategoryList[index].name ?? '',
                subCategoryList[index].id ?? ''));
        context
            .read<CategoryRadioButtonSelectionBloc>()
            .add(ApplyRadioButtonEvent());
        context.read<BrandSelectionBloc>().add(const ClearBrandEvent());

        if (needNavigate) {
          pushScreenWithNavBar(
            context,
            BlocBuilder<SubCategorySelectionBloc, SubCategorySelectionState>(
              builder: (context, state) {
                return CategoryProfileScreen(
                  topTitle: topTitle,
                  titlePressed: false,
                  subCategoryList: subCategoryList,
                  categoryList: categoryList,
                  index: index,
                  brandName: selectedBrandName,
                  categoryId: categoryId,
                );
              },
            ),
          );
        }
      },
      child: BlocBuilder<SubCategorySelectionBloc, SubCategorySelectionState>(
        builder: (context, state) {
          return Container(
            width: 126.w,
            margin: EdgeInsets.only(right: 3.w),
            decoration: BoxDecoration(
              color: AppColors.lightPurpleColor,
              borderRadius: AppBorders.borderRadius10,
              border: Border.all(
                color: state.subcategoryName == subCategoryList[index].name
                    ? AppColors.purpleColor
                    : AppColors.lightPurpleColor,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: AppBorders.borderRadius10,
                    child: ExtendedImage.network(
                      '$url${subCategoryList[index].image!.url}',
                      height: imageHeight?.h ?? 100.h,
                      width: imageHeight?.w ?? 106.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  subCategoryList[index].name ?? '',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: AppFonts.fontSize14,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
