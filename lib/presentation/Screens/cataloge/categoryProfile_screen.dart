// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amira_app/blocs/filter/filter/categoryRadioButtonSelection/category_radio_button_selection_bloc.dart';
import 'package:amira_app/blocs/filter/brandSelection/brand_selection_bloc.dart';
import 'package:amira_app/blocs/filter/priceRangeSelection/price_range_selection_bloc.dart';
import 'package:amira_app/blocs/filter/switcher/switcher_bloc.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/data/models/cart_model.dart';
import 'package:amira_app/data/models/fav_model.dart';
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
  final List categoryProductList;
  const CategoryProfileScreen({
    required this.topTitle,
    required this.categoryProductList,
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
              child: GridView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: categoryProductList.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: 156,
                  mainAxisSpacing: 7,
                  crossAxisSpacing: 5,
                ),
                itemBuilder: (context, index) => CategoryProductCard(
                  index: index,
                  categoryProductList: categoryProductList,
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
                  FilterTile(
                    width: MediaQuery.of(context).size.width - 58.w,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 370,
                    ),
                    itemCount: saleProducts.length,
                    itemBuilder: (context, index) {
                      return ProductLargeCard(
                        index: index,
                        cartItem: CartItem(
                          id: saleProducts[index].id,
                          name: saleProducts[index].name,
                          image: saleProducts[index].image,
                          price: saleProducts[index].price,
                          prevPrice: saleProducts[index].prevPrice,
                          discount: saleProducts[index].discount,
                          desc: saleProducts[index].desc,
                        ),
                        favItem: FavItem(
                          id: saleProducts[index].id,
                          name: saleProducts[index].name,
                          image: saleProducts[index].image,
                          price: saleProducts[index].price,
                          prevPrice: saleProducts[index].prevPrice,
                          discount: saleProducts[index].discount,
                          desc: saleProducts[index].desc,
                        ),
                      );
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
