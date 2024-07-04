import 'package:amira_app/blocs/cateloge/getAllCategory/all_category_bloc.dart';
import 'package:amira_app/blocs/cateloge/getAllProducts/all_products_bloc.dart';
import 'package:amira_app/presentation/Screens/cataloge/components/categoryProducts_slider.dart';
import 'package:amira_app/presentation/CustomWidgets/custom_textField.dart';
import 'package:amira_app/presentation/Screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CatelogeScreen extends StatelessWidget {
  const CatelogeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AllCategoryBloc()..add(GetAllCategoryList()),
        ),
        BlocProvider(
          create: (context) => AllProductsBloc()
            ..add(
              const GetAllProductsList(
                postData: {
                  'categories': ['category2'],
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
      ],
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                //search field
                Padding(
                  padding: const EdgeInsets.all(16),
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
                //veg tile
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
                      return const Center(
                        child: Text('it is loading'),
                      );
                    } else if (state is AllCategoryLoaded) {
                      if (state.allCategoryList.isEmpty) {
                        return const Center(
                          child: Text('it is empty'),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: state.categoryCount,
                        itemBuilder: (context, index) => CategoryProductsSlider(
                          categoryProductList: state.allCategoryList,
                          topTitle: state.allCategoryList[index].name,
                          categoryId: state.allCategoryList[index].id,
                        ),
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
