// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amira_app/blocs/cateloge/getAllCategory/all_category_bloc.dart';
import 'package:amira_app/blocs/cateloge/getAllProducts/all_products_bloc.dart';
import 'package:amira_app/blocs/cateloge/getOneCataloge/get_one_cateloge_bloc.dart';
import 'package:amira_app/blocs/filter/filter/categoryRadioButtonSelection/category_radio_button_selection_bloc.dart';
import 'package:amira_app/blocs/filter/brandSelection/brand_selection_bloc.dart';
import 'package:amira_app/blocs/filter/priceRangeSelection/price_range_selection_bloc.dart';
import 'package:amira_app/blocs/filter/switcher/switcher_bloc.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/data/models/cart_model.dart';
import 'package:amira_app/data/models/category_model.dart';
import 'package:amira_app/data/models/fav_model.dart';
import 'package:amira_app/presentation/CustomWidgets/animations.dart';
import 'package:amira_app/presentation/CustomWidgets/custom_appbar.dart';
import 'package:amira_app/presentation/CustomWidgets/filter_tile.dart';
import 'package:amira_app/presentation/CustomWidgets/productLarge_card.dart';
import 'package:amira_app/presentation/Screens/cataloge/components/categoryProduct_card.dart';
import 'package:amira_app/presentation/Screens/search/search_screen.dart';
import 'package:flutter/material.dart';

import 'package:amira_app/config/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CategoryProfileScreen extends StatelessWidget {
  final String topTitle;
  final List<Rows> subCategoryList;
  final String categoryId;
  final int index;

  const CategoryProfileScreen({
    required this.topTitle,
    required this.subCategoryList,
    required this.categoryId,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoryRadioButtonSelectionBloc(),
        ),
        BlocProvider(
          create: (context) => SwitcherBloc(),
        ),
        BlocProvider(
          create: (context) => BrandSelectionBloc(),
        ),
        BlocProvider(
          create: (context) => PriceRangeSelectionBloc(),
        ),
        BlocProvider(
          create: (context) => AllCategoryBloc()..add(GetAllCategoryList()),
        ),
        BlocProvider(
          create: (context) => AllProductsBloc()
            ..add(
              GetAllProductsList(
                postData: {
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
                  'isLiked': true,
                },
              ),
            ),
        ),
        BlocProvider(
          create: (context) =>
              GetOneCatelogeBloc()..add(GetOneCataloge(id: categoryId)),
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(
          topTitle: topTitle,
          iconTitle: searchIcon,
          onTap: () => pushScreenWithNavBar(context, const SearchScreen()),
        ),
        body: ListView(
          children: [
            //category cards
            Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r),
                ),
              ),
              margin: EdgeInsets.symmetric(vertical: 6.h),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 140.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: subCategoryList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      context.read<AllProductsBloc>().add(
                            GetAllProductsList(
                              postData: {
                                'categories': [
                                  subCategoryList[index].id,
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
                              },
                            ),
                          );
                      context
                          .read<GetOneCatelogeBloc>()
                          .add(GetOneCataloge(id: categoryId));
                    },
                    child: CategoryProductCard(
                      index: index,
                      subCategoryList: subCategoryList,
                      imageHeight: 85,
                    ),
                  ),
                ),
              ),
            ),
            //filter and products
            Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r),
                ),
              ),
              margin: EdgeInsets.symmetric(vertical: 6.h),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Column(
                children: [
                  ///filter tile
                  BlocBuilder<AllCategoryBloc, AllCategoryState>(
                    builder: (context, state) {
                      if (state is AllCategoryError) {
                        return Center(
                          child: Text(state.error.toString()),
                        );
                      } else if (state is AllCategoryInitial) {
                        return const Center(
                          child: Text('It is initial'),
                        );
                      } else if (state is AllCategoryLoading) {
                        return Animations.loading;
                      } else if (state is AllCategoryLoaded) {
                        if (state.allCategoryList.isEmpty) {
                          return const Center(
                            child: Text('it is empty'),
                          );
                        }
                        return FilterTile(
                          width: MediaQuery.of(context).size.width - 58.w,
                          id: state.allCategoryList[0].id!,
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  BlocBuilder<AllProductsBloc, AllProductsState>(
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
                        if (state.allProductsList.isEmpty) {
                          return const Center(
                            child: Text('it is empty'),
                          );
                        }
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 370,
                          ),
                          itemCount: state.allProductsList.length,
                          itemBuilder: (context, index) {
                            return ProductLargeCard(
                              index: index,
                              cartItem: CartItem(
                                  id: state.allProductsList[index].id,
                                  name: state.allProductsList[index].name,
                                  image: state.allProductsList[index].images,
                                  price: state.allProductsList[index].price,
                                  prevPrice: '',
                                  discount: null,
                                  desc: null,
                                  shopid: state.allProductsList[index].shopId),
                              favItem: FavItem(
                                  id: state.allProductsList[index].id
                                      .toString(),
                                  name: state.allProductsList[index].name,
                                  image: state.allProductsList[index].images,
                                  price: state.allProductsList[index].price,
                                  prevPrice: '',
                                  discount: null,
                                  desc: null,
                                  shopid: state.allProductsList[index].id),
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
