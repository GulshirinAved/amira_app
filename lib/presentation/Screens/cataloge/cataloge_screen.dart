import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/presentation/Screens/cataloge/categoryProfile_screen.dart';
import 'package:amira_app/presentation/Screens/cataloge/components/categoryProducts_slider.dart';
import 'package:amira_app/presentation/CustomWidgets/custom_textField.dart';
import 'package:amira_app/presentation/Screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CatelogeScreen extends StatelessWidget {
  const CatelogeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            //search field
            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomTextField.search(
                onTap: () {
                  pushScreenWithNavBar(
                    context,
                    const SearchScreen(),
                  );
                },
              ),
            ),
            //veg tile
            CategoryProductsSlider(
              topTitle: 'Офощи и фрукты',
              categoryProductList: vegCategory,
              onTap: () {
                pushScreenWithNavBar(
                  context,
                  CategoryProfileScreen(
                    topTitle: 'Офощи и фрукты',
                    categoryProductList: vegCategory,
                  ),
                );
              },
            ),
            //meat tile
            CategoryProductsSlider(
              topTitle: 'Мясо',
              categoryProductList: meatCategory,
            ),
            //milk tile
            CategoryProductsSlider(
              topTitle: 'Молочка',
              categoryProductList: milkCategory,
            ),
            //cosmetics tile
            CategoryProductsSlider(
              topTitle: 'Касметика',
              categoryProductList: cosmeticsCategory,
            ),
            //hygiene tile
            CategoryProductsSlider(
              topTitle: 'Гигиена',
              categoryProductList: cosmeticsCategory,
            ),
            //house tile
            CategoryProductsSlider(
              topTitle: 'Дом',
              categoryProductList: cosmeticsCategory,
            ),
            //child tile
            CategoryProductsSlider(
              topTitle: 'Детям',
              categoryProductList: cosmeticsCategory,
            ),
            //chancery tile
            CategoryProductsSlider(
              topTitle: 'Канцелярия',
              categoryProductList: cosmeticsCategory,
            ),
            //zoo tile
            CategoryProductsSlider(
              topTitle: 'Зоотовары',
              categoryProductList: cosmeticsCategory,
            ),
          ],
        ),
      ),
    );
  }
}
