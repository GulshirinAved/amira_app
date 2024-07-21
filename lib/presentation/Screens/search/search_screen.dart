// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amira_app/app_localization.dart';

import 'package:amira_app/blocs/cateloge/getAllProducts/all_products_bloc.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/data/models/cart_model.dart';
import 'package:amira_app/data/models/fav_model.dart';
import 'package:amira_app/presentation/CustomWidgets/animations.dart';
import 'package:amira_app/presentation/CustomWidgets/custom_textField.dart';
import 'package:amira_app/presentation/CustomWidgets/productLarge_card.dart';
import 'package:amira_app/presentation/Screens/home/components/gridviewProducts_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchController;
  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllProductsBloc()
        ..add(
          GetAllProductsList(
            postData: {
              'categories': const [],
              'brands': const [],
              'shops': const [],
              'priceFrom': null,
              'priceTo': null,
              'ordering': 'popular',
              'search': searchController.text,
              'page': 1,
              'pageSize': 10,
              'discount': false,
              'isLiked': true,
            },
          ),
        ),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: BlocBuilder<AllProductsBloc, AllProductsState>(
                  builder: (context, state) {
                    return ListView(
                      children: [
                        //search field and clear button
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField.search(
                                autoFocus: true,
                                context: context,
                                controller: searchController,
                                onFieldSubmitted: (value) {
                                  context.read<AllProductsBloc>().add(
                                        GetAllProductsList(
                                          postData: {
                                            'categories': const [],
                                            'brands': const [],
                                            'shops': const [],
                                            'priceFrom': null,
                                            'priceTo': null,
                                            'ordering': 'popular',
                                            'search': searchController.text,
                                            'page': 1,
                                            'pageSize': 10,
                                            'discount': false,
                                            'isLiked': true,
                                          },
                                        ),
                                      );
                                },
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                searchController.clear();
                                context.read<AllProductsBloc>().add(
                                      GetAllProductsList(
                                        postData: {
                                          'categories': const [],
                                          'brands': const [],
                                          'shops': const [],
                                          'priceFrom': null,
                                          'priceTo': null,
                                          'ordering': 'popular',
                                          'search': searchController.text,
                                          'page': 1,
                                          'pageSize': 10,
                                          'discount': false,
                                          'isLiked': true,
                                        },
                                      ),
                                    );
                              },
                              child: Text(
                                AppLocalization.of(context)
                                        .getTransatedValues('cancel') ??
                                    '',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: AppFonts.fontSize14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        searchController.text.isEmpty
                            ? const GridviewProductsSlider(
                                topTitle: 'Рекомендуемые товары',
                                productList: [],
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.r),
                                    topRight: Radius.circular(10.r),
                                  ),
                                ),
                                margin: EdgeInsets.symmetric(vertical: 6.h),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 10.h,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    BlocBuilder<AllProductsBloc,
                                        AllProductsState>(
                                      builder: (context, state) {
                                        if (state is AllProductsError) {
                                          return Center(
                                            child: Text(state.error.toString()),
                                          );
                                        } else if (state
                                            is AllProductsInitial) {
                                          return const Center(
                                            child: Text('It is initial'),
                                          );
                                        } else if (state
                                            is AllProductsLoading) {
                                          return Animations.loading;
                                        } else if (state is AllProductsLoaded) {
                                          if (state.allProductsList.isEmpty) {
                                            return const Center(
                                              child: Text('it is empty'),
                                            );
                                          }
                                          return GridView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisExtent: 370,
                                            ),
                                            itemCount:
                                                state.allProductsList.length,
                                            itemBuilder: (context, index) {
                                              return ProductLargeCard(
                                                index: index,
                                                cartItem: CartItem(
                                                  id: state
                                                      .allProductsList[index]
                                                      .id,
                                                  name: state
                                                      .allProductsList[index]
                                                      .name,
                                                  image: state
                                                      .allProductsList[index]
                                                      .images,
                                                  price: state
                                                      .allProductsList[index]
                                                      .price,
                                                  prevPrice: '',
                                                  discount: null,
                                                  desc: state
                                                      .allProductsList[index]
                                                      .description,
                                                  shopid: state
                                                      .allProductsList[index]
                                                      .shopId,
                                                  coin: state
                                                      .allProductsList[index]
                                                      .coin,
                                                ),
                                                favItem: FavItem(
                                                  id: state
                                                      .allProductsList[index].id
                                                      .toString(),
                                                  name: state
                                                      .allProductsList[index]
                                                      .name,
                                                  image: state
                                                      .allProductsList[index]
                                                      .images,
                                                  price: state
                                                      .allProductsList[index]
                                                      .price,
                                                  prevPrice: '',
                                                  discount: null,
                                                  desc: state
                                                      .allProductsList[index]
                                                      .description,
                                                  shopid: state
                                                      .allProductsList[index]
                                                      .id,
                                                  coin: state
                                                      .allProductsList[index]
                                                      .coin,
                                                ),
                                              );
                                            },
                                          );
                                        } else {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    );
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
