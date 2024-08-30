import 'package:amira_app/app_localization.dart';
import 'package:amira_app/blocs/cateloge/getAllBrands/get_all_brands_bloc.dart';
import 'package:amira_app/blocs/cateloge/getAllCategory/all_category_bloc.dart';
import 'package:amira_app/blocs/cateloge/getAllProducts/all_products_bloc.dart';
import 'package:amira_app/blocs/cateloge/getOneCataloge/get_one_cateloge_bloc.dart';
import 'package:amira_app/blocs/filter/brandSelection/brand_selection_bloc.dart';
import 'package:amira_app/blocs/filter/filter/categoryRadioButtonSelection/category_radio_button_selection_bloc.dart';
import 'package:amira_app/presentation/CustomWidgets/animations.dart';
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
          create: (context) => AllCategoryBloc()
            ..add(
              GetAllCategoryList(),
            ),
        ),
        BlocProvider(
          create: (context) =>
              GetOneCatelogeBloc()..add(const GetOneCataloge(id: '')),
        ),
        BlocProvider(
          create: (context) => GetAllBrandsBloc()
            ..add(
              const GetAllBrandsList(categoryId: ''),
            ),
        ),
        BlocProvider(
          create: (context) => BrandSelectionBloc(),
        ),
        BlocProvider.value(
          value: context.read<CategoryRadioButtonSelectionBloc>(),
        ),
        BlocProvider.value(
          value: context.read<AllProductsBloc>()
            ..add(
              const GetAllProductsList(
                postData: {
                  'categories': [],
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
          body: Builder(
            builder: (context) {
              return RefreshIndicator(
                onRefresh: () async {
// Trigger the events to reload data
                  context.read<AllCategoryBloc>().add(GetAllCategoryList());
                  context
                      .read<GetOneCatelogeBloc>()
                      .add(const GetOneCataloge(id: ''));
                  context
                      .read<GetAllBrandsBloc>()
                      .add(const GetAllBrandsList(categoryId: ''));
                  context.read<AllProductsBloc>().add(
                        const GetAllProductsList(
                          postData: {
                            'categories': [],
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
                      );
                },
                child: BlocBuilder<AllCategoryBloc, AllCategoryState>(
                  builder: (context, state) {
                    if (state is AllCategoryError) {
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
                    } else if (state is AllCategoryInitial ||
                        state is AllCategoryLoading) {
                      return Animations.loading;
                    } else if (state is AllCategoryLoaded) {
// Filter categories with non-empty subcategories
                      final nonEmptyCategories = state.allCategoryList
                          .where(
                              (category) => category.subcategories!.isNotEmpty)
                          .toList();

                      return SingleChildScrollView(
                        child: Column(
                          children: [
// Search field
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
// Category sliders
                            ListView.builder(
                              controller:
                                  BlocProvider.of<AllCategoryBloc>(context)
                                      .scrollController,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: nonEmptyCategories.length + 1,
                              itemBuilder: (context, index) {
                                if (index >= nonEmptyCategories.length) {
                                  if (!BlocProvider.of<AllCategoryBloc>(context)
                                      .isLoadingMore) {
                                    BlocProvider.of<AllCategoryBloc>(context)
                                        .add(LoadMoreEvent());
                                  }
                                  return nonEmptyCategories.length != index
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : const SizedBox.shrink();
                                }
// Category card and top title
                                return BlocBuilder<BrandSelectionBloc,
                                    BrandSelectionState>(
                                  builder: (context, stateBrand) {
                                    return CategoryProductsSlider(
                                      subCategoryList: nonEmptyCategories[index]
                                          .subcategories!,
                                      categoryList: nonEmptyCategories,
                                      topTitle:
                                          nonEmptyCategories[index].name ?? '',
                                      selectedBrand:
                                          stateBrand.selectedBrandBottomSheet1,
                                      index: index,
                                      categoryId: nonEmptyCategories[index]
                                          .id
                                          .toString(),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
