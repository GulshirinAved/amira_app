// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amira_app/blocs/home/getHome/get_home_bloc.dart';
import 'package:amira_app/presentation/CustomWidgets/animations.dart';
import 'package:amira_app/presentation/Screens/home/components/listviewProducts_slider.dart';

import 'package:amira_app/presentation/Screens/search/search_screen.dart';
import 'package:extended_image/extended_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/presentation/Screens/home/components/deliveryAddress_tile.dart';
import 'package:amira_app/presentation/CustomWidgets/custom_textField.dart';

import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetHomeBloc()..add(const GetHomeBannerList()),
      child: SafeArea(
        child: PopScope(
          onPopInvoked: (value) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: ListView(
              children: [
                //delivery address
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: const DeliveryAddressTile(),
                ),
                //search bar
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Container(
                    height: 46.h,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                          color: AppColors.purple1Color.withOpacity(0.4),
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
                //banner
                BlocBuilder<GetHomeBloc, GetHomeState>(
                  builder: (context, state) {
                    if (state is GetHomeError) {
                      return Center(
                        child: Text('there is error:${state.error}'),
                      );
                    } else if (state is GetHomeInitial) {
                      return const Center(
                        child: Text('it is initial'),
                      );
                    } else if (state is GetHomeLoading) {
                      return Animations.loading;
                    } else if (state is GetHomeLoaded) {
                      if (state.getHomeBannerList.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 15.h,
                          horizontal: 16.w,
                        ),
                        child: ClipRRect(
                          borderRadius: AppBorders.borderRadius10,
                          child: ExtendedImage.network(
                            '$url${state.getHomeBannerList[0].image.url}',
                            height: 150.h,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),

                //products
                BlocBuilder<GetHomeBloc, GetHomeState>(
                  builder: (context, state) {
                    if (state is GetHomeError) {
                      return Center(
                        child: Text('there is error:${state.error}'),
                      );
                    } else if (state is GetHomeInitial) {
                      return const Center(
                        child: Text('it is initial'),
                      );
                    } else if (state is GetHomeLoading) {
                      return Animations.loading;
                    } else if (state is GetHomeLoaded) {
                      if (state.getHomeBannerList.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return Column(
                        children: [
                          //home page category sliders
                          Column(
                            children: [
                              for (int i = 0; i < state.getHomeData.length; i++)
                                ListviewProductsSlider(
                                  topTitle:
                                      state.getHomeData[i].category?.name ??
                                          'Default Category Name',
                                  productsList: state.getHomeProducts[i],
                                ),
                            ],
                          ),
                          //banner
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: ClipRRect(
                              borderRadius: AppBorders.borderRadius10,
                              child: ExtendedImage.network(
                                '$url${state.getHomeBannerList[1].image.url}',
                                height: 150.h,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
