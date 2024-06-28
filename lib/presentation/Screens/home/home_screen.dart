// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amira_app/presentation/Screens/home/components/chancery_slider.dart';
import 'package:amira_app/presentation/Screens/home/components/child_slider.dart';
import 'package:amira_app/presentation/Screens/home/components/cosmetics_slider.dart';
import 'package:amira_app/presentation/Screens/home/components/house_slider.dart';
import 'package:amira_app/presentation/Screens/home/components/hygiene_slider.dart';
import 'package:amira_app/presentation/Screens/home/components/meat_slider.dart';
import 'package:amira_app/presentation/Screens/home/components/milk_slider.dart';
import 'package:amira_app/presentation/Screens/home/components/moreProducts_slider.dart';
import 'package:amira_app/presentation/Screens/home/components/sale_slider.dart';
import 'package:amira_app/presentation/Screens/home/components/veg_slider.dart';
import 'package:amira_app/presentation/Screens/home/components/zoo_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/presentation/Screens/home/components/deliveryAddress_tile.dart';
import 'package:amira_app/presentation/Screens/home/components/search_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            //delivery address
            const DeliveryAddressTile(),
            //search bar
            Container(
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
              child: const SearchField(),
            ),
            //banner
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Image.asset(bannerImage),
            ),
            //tabars
            DefaultTabController(
              length: tabbarName.length,
              child: TabBar(
                padding: EdgeInsetsDirectional.zero,
                indicatorPadding: EdgeInsetsDirectional.zero,
                labelPadding: EdgeInsets.zero,
                indicator: BoxDecoration(
                  color: AppColors.blackColor,
                  borderRadius: AppBorders.borderRadius10,
                ),
                unselectedLabelColor: AppColors.blackColor,
                labelColor: AppColors.whiteColor,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: AppFonts.fontSize14,
                ),
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: AppFonts.fontSize14,
                ),
                tabAlignment: TabAlignment.start,
                isScrollable: true,
                dividerColor: Colors.transparent,
                tabs: List.generate(
                  tabbarName.length,
                  (index) => Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(tabbarName[index]['name']),
                  ),
                ),
              ),
            ),

            Column(
              children: [
                //sale slilder
                const SaleSlider(),
                //veg slider
                const VegSlider(),
                //banner
                Image.asset(banner1Image),
                //meat slider
                const MeatSlider(),
                //meat slider
                const MilkSlider(),
                //cosmetics slider
                const CosmeticsSlider(),
                //hygiene slider
                const HygieneSlider(),
                //house slider
                const HouseSlider(),
                //child slider
                const ChildSlider(),
                //chancerySlider
                const ChancerySlider(),
                //zoo slider
                const ZooSlider(),
                //more gridview
                const MoreProductsSlider()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
