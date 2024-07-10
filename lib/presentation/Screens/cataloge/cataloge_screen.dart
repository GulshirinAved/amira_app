import 'package:amira_app/blocs/cateloge/getAllCategory/all_category_bloc.dart';
import 'package:amira_app/presentation/CustomWidgets/animations.dart';
import 'package:amira_app/presentation/Screens/cataloge/categoryProfile_screen.dart';
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
    return BlocProvider(
      create: (context) => AllCategoryBloc()
        ..add(
          GetAllCategoryList(),
        ),
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
                //category sliders
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
                      return Animations.loading;
                    } else if (state is AllCategoryLoaded) {
                      if (state.allCategoryList.isEmpty) {
                        return const Center(
                          child: Text('it is empty'),
                        );
                      }

                      return ListView.builder(
                        controller: BlocProvider.of<AllCategoryBloc>(context)
                            .scrollController,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: state.allCategoryList.length + 1,
                        itemBuilder: (context, index) {
                          if (index >= state.allCategoryList.length) {
                            if (!BlocProvider.of<AllCategoryBloc>(context)
                                .isLoadingMore) {
                              BlocProvider.of<AllCategoryBloc>(context)
                                  .add(LoadMoreEvent());
                            }
                            return state.allCategoryList.length != index
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : const SizedBox.shrink();
                          }
                          //category card and toptitle
                          return CategoryProductsSlider(
                            categoryList: state.allCategoryList,
                            topTitle: state.allCategoryList[index].name!,
                            subCategoryList:
                                state.allCategoryList[index].subcategories!,
                            categoryId: state.allCategoryList[index].id!,
                            onTap: () {
                              //if press to title then shows all categoryID products. if press categorycard then shows  subcategoryId
                              pushScreenWithNavBar(
                                context,
                                CategoryProfileScreen(
                                  topTitle: state.allCategoryList[index].name!,
                                  subCategoryList: state
                                      .allCategoryList[index].subcategories!,
                                  categoryId: state.allCategoryList[index].id!,
                                  index: index,
                                ),
                              );
                            },
                          );
                        },
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
