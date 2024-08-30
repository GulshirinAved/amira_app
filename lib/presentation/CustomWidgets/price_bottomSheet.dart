import 'package:amira_app/app_localization.dart';
import 'package:amira_app/blocs/cateloge/getAllProducts/all_products_bloc.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/constants.dart';
import 'package:amira_app/presentation/CustomWidgets/button.dart';
import 'package:amira_app/presentation/Screens/cataloge/components/priceRangeFieldCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> priceBottomsheet(
  BuildContext context,
  String subCategoryId,
  TextEditingController toTextEditingController,
  TextEditingController fromTextEditingController,
) {
  return showModalBottomSheet(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    isDismissible: false,
    backgroundColor: AppColors.lightGreyColor,
    builder: (contextt) => BlocProvider.value(
      value: context.read<AllProductsBloc>()
        ..add(GetAllProductsList(postData: {
          'categories': [
            subCategoryId,
          ],
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
        })),
      child: Container(
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalization.of(context).getTransatedValues('price') ?? '',
                  style: TextStyle(
                    fontFamily: fontPeaceSans,
                    fontWeight: FontWeight.w400,
                    fontSize: AppFonts.fontSize22,
                  ),
                ),
                PriceRangeFieldAndCard(
                  bottomSheet: 3,
                  toPriceController: toTextEditingController,
                  fromPriceController: fromTextEditingController,
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
                          .read<AllProductsBloc>()
                          .add(GetAllProductsList(postData: {
                            'categories': [
                              subCategoryId,
                            ],
                            'brands': [],
                            'shops': [],
                            'priceFrom':
                                int.parse(fromTextEditingController.text),
                            'priceTo': int.parse(toTextEditingController.text),
                            'ordering': 'popular',
                            'search': '',
                            'page': 1,
                            'pageSize': 10,
                            'discount': false,
                            'isLiked': true,
                          }));
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
