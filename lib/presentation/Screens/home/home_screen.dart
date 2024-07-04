// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amira_app/presentation/Screens/home/components/listviewProducts_slider.dart';

import 'package:amira_app/presentation/Screens/home/components/gridviewProducts_slider.dart';
import 'package:amira_app/presentation/Screens/search/search_screen.dart';

import 'package:flutter/material.dart';
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
    return SafeArea(
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
                child: Image.asset(bannerImage),
              ),

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
                    productsList: zooProducts,
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
