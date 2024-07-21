import 'package:amira_app/blocs/cateloge/getAllBrands/get_all_brands_bloc.dart';
import 'package:amira_app/blocs/cateloge/getAllProducts/all_products_bloc.dart';
import 'package:amira_app/blocs/cateloge/getOneCataloge/get_one_cateloge_bloc.dart';
import 'package:amira_app/blocs/cateloge/subCategoryCardSelection/sub_category_selection_bloc.dart';
import 'package:amira_app/blocs/filter/brandSelection/brand_selection_bloc.dart';
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
  final List<Rows> subCategoryList;
  final List categoryList;
  final int index;
  final bool titlePressed;
  final String topTitle;
  final List brandName;
  final String categoryId;
  const CategoryProfileScreen({
    required this.subCategoryList,
    required this.categoryList,
    required this.index,
    required this.titlePressed,
    required this.topTitle,
    required this.brandName,
    required this.categoryId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AllProductsBloc()
            ..add(
              GetAllProductsList(
                postData: {
                  'categories': [
                    titlePressed
                        ? categoryList[index].id
                        : subCategoryList[index].id,
                  ],
                  'brands': brandName,
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
          create: (context) => GetOneCatelogeBloc()
            ..add(
              GetOneCataloge(id: categoryList[index].id!),
            ),
        ),
        BlocProvider(
          create: (context) => SwitcherBloc(),
        ),
        BlocProvider(
          create: (context) => GetAllBrandsBloc()
            ..add(GetAllBrandsList(categoryId: categoryList[index].id)),
        ),
        BlocProvider(
          create: (context) => BrandSelectionBloc(),
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
            Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r),
                ),
              ),
              margin: EdgeInsets.symmetric(vertical: 6.h),
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //subCategory Slider

                  SizedBox(
                    height: 157.h,
                    child: BlocBuilder<AllProductsBloc, AllProductsState>(
                      builder: (context, state) {
                        print('it is state ${state}');
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
                                needNavigate: false,
                                topTitle: topTitle,
                                selectedBrandName: brandName,
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
                  BlocBuilder<GetOneCatelogeBloc, GetOneCatelogeState>(
                    builder: (context, state) {
                      if (state is GetOneCatalogeError) {
                        return Center(
                          child: Text("it gives error ${state.error}"),
                        );
                      } else if (state is GetOneCatalogeLoading ||
                          state is GetOneCatalogeLoading) {
                        return Animations.loading;
                      }
                      return Column(
                        children: [
                          BlocBuilder<SubCategorySelectionBloc,
                              SubCategorySelectionState>(
                            builder: (context, state) {
                              return FilterTile(
                                subCategoryId: state.subcategoryName == ''
                                    ? categoryList[index].id
                                    : subCategoryList[index].id!,
                                categoryId: categoryId,
                                isTopPressed: titlePressed,
                              );
                            },
                          ),
                          SizedBox(
                            child:
                                BlocBuilder<AllProductsBloc, AllProductsState>(
                              builder: (context, state) {
                                if (state is AllProductsLoaded) {
                                  return GridView.builder(
                                    controller:
                                        BlocProvider.of<AllProductsBloc>(
                                                context)
                                            .scrollController,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: state.allProductsList.length + 1,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisExtent: 370,
                                    ),
                                    itemBuilder: (context, index) {
                                      if (index >=
                                          state.allProductsList.length) {
                                        if (!BlocProvider.of<AllProductsBloc>(
                                                context)
                                            .isLoadingMore) {
                                          BlocProvider.of<AllProductsBloc>(
                                                  context)
                                              .add(
                                                  const AllProductsLoadMoreEvent());
                                        }
                                        return state.allProductsList.length !=
                                                index
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : const SizedBox.shrink();
                                      }
                                      return ProductLargeCard(
                                        favItem: FavItem(
                                          id: state.allProductsList[index].id,
                                          name:
                                              state.allProductsList[index].name,
                                          desc: state.allProductsList[index]
                                              .description,
                                          image: state
                                              .allProductsList[index].images,
                                          price: state
                                              .allProductsList[index].price,
                                          shopid: state
                                              .allProductsList[index].shopId,
                                          coin:
                                              state.allProductsList[index].coin,
                                        ),
                                        cartItem: CartItem(
                                          id: state.allProductsList[index].id,
                                          name:
                                              state.allProductsList[index].name,
                                          desc: state.allProductsList[index]
                                              .description,
                                          image: state
                                              .allProductsList[index].images,
                                          price: state
                                              .allProductsList[index].price,
                                          shopid: state
                                              .allProductsList[index].shopId,
                                          coin:
                                              state.allProductsList[index].coin,
                                        ),
                                        index: index,
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
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
