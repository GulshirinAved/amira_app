// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:amira_app/blocs/addDeliveryLocation/location_add_bloc.dart';
import 'package:amira_app/presentation/Screens/home/components/listviewProducts_slider.dart';

import 'package:amira_app/presentation/Screens/home/components/gridviewProducts_slider.dart';
import 'package:amira_app/presentation/Screens/search/search_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/presentation/Screens/home/components/deliveryAddress_tile.dart';
import 'package:amira_app/presentation/Screens/home/components/search_field.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationAddBloc()..add(const LoadAddressEvent('')),
      child: SafeArea(
        child: Scaffold(
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
                  child: SearchField(
                    hintText: 'Поиск',
                    needPrefix: true,
                    onTap: () {
                      pushScreenWithoutNavBar(context, const SearchScreen());
                    },
                  ),
                ),
              ),
              //banner
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
                child: Image.asset(bannerImage),
              ),
              //tabars
              // TabBar(
              //   padding: EdgeInsetsDirectional.zero,
              //   indicatorPadding: EdgeInsetsDirectional.zero,
              //   labelPadding: EdgeInsets.zero,
              //   indicator: BoxDecoration(
              //     color: AppColors.blackColor,
              //     borderRadius: AppBorders.borderRadius10,
              //   ),
              //   unselectedLabelColor: AppColors.blackColor,
              //   labelColor: AppColors.whiteColor,
              //   labelStyle: TextStyle(
              //     fontWeight: FontWeight.w500,
              //     fontSize: AppFonts.fontSize14,
              //   ),
              //   unselectedLabelStyle: TextStyle(
              //     fontWeight: FontWeight.w500,
              //     fontSize: AppFonts.fontSize14,
              //   ),
              //   tabAlignment: TabAlignment.start,
              //   isScrollable: true,
              //   dividerColor: Colors.transparent,
              //   tabs: List.generate(
              //     tabbarName.length,
              //     (index) => Container(
              //       padding: const EdgeInsets.all(10),
              //       child: Text(tabbarName[index]['name']),
              //     ),
              //   ),
              // ),
              //products
              Column(
                children: [
                  //sale slilder
                  ListviewProductsSlider(
                    topTitle: 'Скидки и акции',
                    productsList: saleProducts,
                  ),
                  //veg slider
                  ListviewProductsSlider(
                    topTitle: 'Овощи и фрукты',
                    productsList: vegProducts,
                  ),
                  //banner
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Image.asset(banner1Image),
                  ),
                  //meat slider
                  ListviewProductsSlider(
                    topTitle: 'Мясо',
                    productsList: meatProducts,
                  ),
                  //milk slider
                  ListviewProductsSlider(
                    topTitle: 'Молочка',
                    productsList: milkProducts,
                  ),

                  //cosmetics slider
                  ListviewProductsSlider(
                    topTitle: 'Касметика',
                    productsList: cosmeticsProducts,
                  ),
                  //hygiene slider
                  ListviewProductsSlider(
                    topTitle: 'Гигиена',
                    productsList: hygieneProducts,
                  ),
                  //house slider
                  ListviewProductsSlider(
                    topTitle: 'Дом',
                    productsList: houseProducts,
                  ),
                  //child slider
                  ListviewProductsSlider(
                    topTitle: 'Детям',
                    productsList: childProducts,
                  ),
                  //chancerySlider
                  ListviewProductsSlider(
                    topTitle: 'Концелярия',
                    productsList: chanceryProducts,
                  ),

                  //zoo slider
                  ListviewProductsSlider(
                    topTitle: 'Зоотовары',
                    productsList: chanceryProducts,
                  ),
                  //more gridview
                  const GridviewProductsSlider(
                    topTitle: 'Еще товары',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
