// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amira_app/data/models/cart_model.dart';
import 'package:amira_app/data/models/fav_model.dart';
import 'package:amira_app/presentation/CustomWidgets/customContainer_extension.dart';
import 'package:amira_app/presentation/CustomWidgets/productSmall_card.dart';
import 'package:amira_app/presentation/Screens/cataloge/categoryProfile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:amira_app/presentation/Screens/home/components/sliderTopTitle.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class ListviewProductsSlider extends StatelessWidget {
  final String topTitle;
  final List productsList;
  final int index;
  final String categoryId;
  final List subCategoryList;
  final bool? titlePressed;
  const ListviewProductsSlider({
    required this.topTitle,
    required this.productsList,
    required this.index,
    required this.categoryId,
    required this.subCategoryList,
    required this.titlePressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer.buildContainer(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: TopTitle(
              title: topTitle,
              onTap: () => pushScreenWithNavBar(
                  context,
                  CategoryProfileScreen(
                      subCategoryList: subCategoryList,
                      categoryList: productsList,
                      index: index,
                      titlePressed: titlePressed ?? true,
                      topTitle: topTitle,
                      brandName: [],
                      categoryId: categoryId)),
            ),
          ),
          SizedBox(
            height: 220.h,
            child: ListView.builder(
              itemCount: productsList.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 15),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return ProductSmallCard(
                  index: index,
                  cartItem: CartItem(
                    id: productsList[index].id,
                    name: productsList[index].name,
                    image: productsList[index].images,
                    price: productsList[index].price,
                    discount: productsList[index].discount,
                    desc: productsList[index].description,
                    shopid: productsList[index].shopId,
                    coin: productsList[index].coin,
                  ),
                  favItem: FavItem(
                    id: productsList[index].id,
                    name: productsList[index].name,
                    image: productsList[index].images,
                    price: productsList[index].price,
                    discount: productsList[index].discount,
                    desc: productsList[index].description,
                    shopid: productsList[index].shopId,
                    coin: productsList[index].coin,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
