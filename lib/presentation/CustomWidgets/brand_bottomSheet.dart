import 'package:amira_app/blocs/cateloge/getAllBrands/get_all_brands_bloc.dart';
import 'package:amira_app/blocs/cateloge/getAllProducts/all_products_bloc.dart';
import 'package:amira_app/blocs/filter/brandSelection/brand_selection_bloc.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/presentation/CustomWidgets/button.dart';
import 'package:amira_app/presentation/Screens/cataloge/components/brand_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> brandBottomSheet(BuildContext context,
    {String? subCategoryId, required List? brandList}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    isDismissible: false,
    backgroundColor: AppColors.lightGreyColor,
    builder: (contextt) => MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: BlocProvider.of<BrandSelectionBloc>(
            context,
          ),
        ),
        BlocProvider.value(
          value: BlocProvider.of<GetAllBrandsBloc>(
            context,
          ),
        ),
        BlocProvider.value(
          value: BlocProvider.of<AllProductsBloc>(context)
            ..add(
              GetAllProductsList(
                postData: {
                  'categories': [
                    subCategoryId,
                  ],
                  'brands': brandList,
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
      child: BlocBuilder<BrandSelectionBloc, BrandSelectionState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Бренды',
                style: TextStyle(
                  fontFamily: fontPeaceSans,
                  fontWeight: FontWeight.w400,
                  fontSize: AppFonts.fontSize22,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(7),
                margin: EdgeInsets.only(top: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: AppBorders.borderRadius10,
                ),
                child: const BrandCards(
                  bottomSheet: 2,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: kBottomNavigationBarHeight,
                  left: 10.w,
                  right: 10.w,
                ),
                child: Button.textButton(
                  text: 'Применить',
                  onTap: () {
                    context
                        .read<BrandSelectionBloc>()
                        .add(const ApplyBrandEvent(bottomSheet: 2));
                    context.read<AllProductsBloc>().add(
                          GetAllProductsList(
                            postData: {
                              'categories': [subCategoryId],
                              'brands': state.selectedBrandBottomSheet2
                                  .map(
                                    (e) => e['brandId'],
                                  )
                                  .toList(),
                              'shops': const [],
                              'priceFrom': null,
                              'priceTo': null,
                              'ordering': 'popular',
                              'search': '',
                              'pageSize': 10,
                              'discount': false,
                              'isLiked': true,
                              'page': 1,
                            },
                          ),
                        );

                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}
