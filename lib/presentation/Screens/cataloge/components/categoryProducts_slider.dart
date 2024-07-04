// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amira_app/blocs/cateloge/getAllProducts/all_products_bloc.dart';
import 'package:amira_app/presentation/Screens/cataloge/components/categoryProduct_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/presentation/Screens/home/components/sliderTopTitle.dart';

class CategoryProductsSlider extends StatelessWidget {
  final String topTitle;
  final List categoryProductList;
  final String categoryId;
  final VoidCallback? onTap;
  const CategoryProductsSlider({
    required this.categoryProductList,
    required this.topTitle,
    required this.categoryId,
    this.onTap,
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
        children: [
          TopTitle(
            title: topTitle,
            onTap: onTap,
          ),
          SizedBox(
            height: 154.h,
            child: BlocBuilder<AllProductsBloc, AllProductsState>(
              builder: (context, state) {
                if (state is AllProductsError) {
                  return Center(
                    child: Text('it is ${state.error}'),
                  );
                } else if (state is AllProductsInitial) {
                  return const Center(
                    child: Text('It is initial'),
                  );
                } else if (state is AllProductsLoading) {
                  return const Center(
                    child: Text('It is loading'),
                  );
                } else if (state is AllProductsLoaded) {
                  if (state.allProductsList.isEmpty) {
                    return const Center(
                      child: Text('It is empty'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: state.allProductsList.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return CategoryProductCard(
                          index: index,
                          categoryProductList: state.allProductsList,
                        );
                      },
                    );
                  }
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
