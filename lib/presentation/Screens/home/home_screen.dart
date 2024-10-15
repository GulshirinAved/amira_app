// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amira_app/app_localization.dart';
import 'package:amira_app/blocs/cateloge/getAllCategory/all_category_bloc.dart';
import 'package:amira_app/blocs/home/getHome/get_home_bloc.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/presentation/CustomWidgets/animations.dart';
import 'package:amira_app/presentation/Screens/home/components/listviewProducts_slider.dart';

import 'package:amira_app/presentation/Screens/search/search_screen.dart';
import 'package:extended_image/extended_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:amira_app/config/theme/constants.dart';
import 'package:amira_app/presentation/Screens/home/components/deliveryAddress_tile.dart';
import 'package:amira_app/presentation/CustomWidgets/custom_textField.dart';

import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetHomeBloc()..add(const GetHomeBannerList()),
        ),
        BlocProvider(
          create: (context) => AllCategoryBloc()..add(GetAllCategoryList()),
        ),
      ],
      child: SafeArea(
        child: PopScope(
          onPopInvoked: (value) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Builder(
              builder: (context) {
                return RefreshIndicator(
                  onRefresh: () async {
// Trigger the events to reload data
                    context.read<GetHomeBloc>().add(const GetHomeBannerList());
                    context.read<AllCategoryBloc>().add(GetAllCategoryList());
                  },
                  child: BlocBuilder<GetHomeBloc, GetHomeState>(
                    builder: (context, homeState) {
                      return BlocBuilder<AllCategoryBloc, AllCategoryState>(
                        builder: (context, categoryState) {
                          if (homeState is GetHomeError ||
                              categoryState is AllCategoryError) {
                            return ListView(
                              children: [
                                Center(
                                  child: Text(
                                    AppLocalization.of(context)
                                            .getTransatedValues('error') ??
                                        'An error occurred. Pull to refresh.',
                                  ),
                                ),
                              ],
                            );
                          } else if (homeState is GetHomeLoading ||
                              homeState is GetHomeInitial ||
                              categoryState is AllCategoryInitial ||
                              categoryState is AllCategoryLoading) {
                            return Animations.loading;
                          } else if (homeState is GetHomeLoaded &&
                              categoryState is AllCategoryLoaded) {
// Ensure lists have the same length
                            final int length = [
                              homeState.getHomeData.length,
                              homeState.getHomeProducts.length,
                              categoryState.allCategoryList.length,
                            ].reduce(
                              (value, element) =>
                                  value < element ? value : element,
                            );

                            return ListView(
                              children: [
// Delivery address
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: const DeliveryAddressTile(),
                                ),
// Search bar
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: Container(
                                    height: 46.h,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 7,
                                          offset: const Offset(0, 3),
                                          color: AppColors.purple1Color
                                              .withOpacity(0.4),
                                        ),
                                      ],
                                    ),
                                    child: CustomTextField.search(
                                      context: context,
                                      onTap: () {
                                        pushScreenWithNavBar(
                                          context,
                                          const SearchScreen(),
                                        );
                                      },
                                    ),
                                  ),
                                ),
// Banner
                                if (homeState.getHomeBannerList.isNotEmpty)
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 15.h,
                                      horizontal: 16.w,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: AppBorders.borderRadius10,
                                      child: ExtendedImage.network(
                                        '$url'
                                        '${homeState.getHomeBannerList[0].image.url}',
                                        height: 150.h,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
// Products
                                Column(
                                  children: [
// Home page category sliders
                                    for (int i = 0; i < length; i++)
                                      ListviewProductsSlider(
                                        titlePressed: true,
                                        topTitle: homeState.getHomeData[i]
                                                .category?.name ??
                                            'Default Category Name',
                                        productsList:
                                            homeState.getHomeProducts[i],
                                        index: i,
                                        subCategoryList: categoryState
                                            .allCategoryList[i].subcategories!,
                                        categoryId: homeState
                                                .getHomeData[i].categoryId ??
                                            '',
                                      ),
// Banner
                                    if (homeState.getHomeBannerList.length > 1)
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16.w,
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              AppBorders.borderRadius10,
                                          child: ExtendedImage.network(
                                            '$url${homeState.getHomeBannerList[1].image.url}',
                                            height: 150.h,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
