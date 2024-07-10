// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amira_app/blocs/cateloge/getAllProducts/all_products_bloc.dart';

import 'package:amira_app/data/models/category_model.dart';
import 'package:amira_app/presentation/CustomWidgets/animations.dart';
import 'package:amira_app/presentation/Screens/cataloge/categoryProfile_screen.dart';
import 'package:amira_app/presentation/Screens/cataloge/components/categoryProduct_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/presentation/Screens/home/components/sliderTopTitle.dart';

class CategoryProductsSlider extends StatelessWidget {
  final String topTitle;
  final List<Rows> subCategoryList;
  final List categoryList;
  final String categoryId;
  final VoidCallback? onTap;
  const CategoryProductsSlider({
    required this.subCategoryList,
    required this.topTitle,
    required this.categoryList,
    required this.categoryId,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllProductsBloc()
        ..add(GetAllProductsList(postData: {
          'categories': [categoryId],
          'brands': [],
          'shops': [],
          'priceFrom': null,
          'priceTo': null,
          'ordering': 'popular',
          'search': '',
          'page': 1,
          'pageSize': 10,
          'discount': false,
          'isLiked': true
        })),
      child: Container(
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
            TopTitle(
              title: topTitle,
              onTap: onTap,
            ),
            SizedBox(
              height: 154.h,
              child: ListView.builder(
                itemCount: subCategoryList.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return BlocBuilder<AllProductsBloc, AllProductsState>(
                    builder: (context, state) {
                      if (state is AllProductsError) {
                        return Center(
                          child: Text(state.error.toString()),
                        );
                      } else if (state is AllProductsInitial) {
                        return const Center(
                          child: Text('It is initial'),
                        );
                      } else if (state is AllProductsLoading) {
                        return Animations.loading;
                      } else if (state is AllProductsLoaded) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryProfileScreen(
                                  topTitle: topTitle,
                                  subCategoryList: subCategoryList,
                                  categoryId: subCategoryList[index].id!,
                                  index: index,
                                ),
                              ),
                            );
                            context
                                .read<AllProductsBloc>()
                                .add(GetAllProductsList(postData: {
                                  'categories': [
                                    subCategoryList[index].id,
                                    categoryId
                                  ],
                                  'brands': [],
                                  'shops': [],
                                  'priceFrom': null,
                                  'priceTo': null,
                                  'ordering': 'popular',
                                  'search': '',
                                  'page': 1,
                                  'pageSize': 10,
                                  'discount': false,
                                  'isLiked': true
                                }));
                          },
                          child: GestureDetector(
                            onTap: onTap,
                            child: CategoryProductCard(
                              index: index,
                              subCategoryList: subCategoryList,
                            ),
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
