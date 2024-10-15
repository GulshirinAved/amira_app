import 'package:amira_app/app_localization.dart';
import 'package:amira_app/blocs/cateloge/getAllBrands/get_all_brands_bloc.dart';
import 'package:amira_app/blocs/cateloge/getAllProducts/all_products_bloc.dart';
import 'package:amira_app/blocs/cateloge/getOneCataloge/get_one_cateloge_bloc.dart';
import 'package:amira_app/blocs/cateloge/subCategoryCardSelection/sub_category_selection_bloc.dart';
import 'package:amira_app/blocs/filter/brandSelection/brand_selection_bloc.dart';
import 'package:amira_app/blocs/filter/filter/categoryRadioButtonSelection/category_radio_button_selection_bloc.dart';
import 'package:amira_app/blocs/filter/switcher/switcher_bloc.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/constants.dart';
import 'package:amira_app/presentation/CustomWidgets/button.dart';
import 'package:amira_app/presentation/CustomWidgets/radio_button.dart';
import 'package:amira_app/presentation/Screens/cataloge/components/brand_cards.dart';
import 'package:amira_app/presentation/Screens/cataloge/components/priceRangeFieldCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> filterBottomSheet(
  BuildContext context,
  String categoryId,
  TextEditingController toTextEditingController,
  TextEditingController fromTextEditingController,
) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    isDismissible: false,
    backgroundColor: AppColors.lightGreyColor,
    builder: (BuildContext contextt) {
      return FractionallySizedBox(
        heightFactor: 0.8,
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: BlocProvider.of<CategoryRadioButtonSelectionBloc>(context),
            ),
            BlocProvider.value(
              value: BlocProvider.of<SwitcherBloc>(context),
            ),
            BlocProvider.value(
              value: BlocProvider.of<GetAllBrandsBloc>(context),
            ),
            BlocProvider.value(
              value: BlocProvider.of<BrandSelectionBloc>(context),
            ),
            BlocProvider(
              create: (context) =>
                  GetOneCatelogeBloc()..add(GetOneCataloge(id: categoryId)),
            ),
            BlocProvider.value(
              value: BlocProvider.of<SubCategorySelectionBloc>(context),
            ),
            BlocProvider.value(
              value: BlocProvider.of<AllProductsBloc>(context),
            ),
          ],
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Text(
                      AppLocalization.of(context)
                              .getTransatedValues('filters') ??
                          '',
                      style: TextStyle(
                        fontFamily: fontPeaceSans,
                        fontWeight: FontWeight.w400,
                        fontSize: AppFonts.fontSize22,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      color: AppColors.whiteColor,
                      child:
                          BlocBuilder<GetOneCatelogeBloc, GetOneCatelogeState>(
                        builder: (context, state) {
                          if (state is GetOneCatalogeError) {
                            return const SizedBox.shrink();
                          } else if (state is GetOneCatelogeInitial ||
                              state is GetOneCatalogeLoading) {
                            return const SizedBox.shrink();
                          } else if (state is GetOneCatalogeLoaded) {
                            if (state
                                .getOneCatalogeList.subcategories!.isEmpty) {
                              return const SizedBox.shrink();
                            }
                            return Column(
                              children: List.generate(
                                state.getOneCatalogeList.subcategories!.length,
                                (index) => BlocBuilder<
                                    CategoryRadioButtonSelectionBloc,
                                    CategoryRadioButtonSelectionState>(
                                  builder: (context, stateRadio) {
                                    return Column(
                                      children: [
                                        CustomRadioButton(
                                          title: state.getOneCatalogeList
                                              .subcategories![index].name!,
                                          value: state.getOneCatalogeList
                                              .subcategories![index].name!,
                                          groupValue:
                                              stateRadio.tempSelectedTitle ??
                                                  '',
                                          onChanged: (value) {
                                            context
                                                .read<
                                                    CategoryRadioButtonSelectionBloc>()
                                                .add(
                                                  SelectRadioButtonEvent(
                                                    value ?? '',
                                                    state
                                                        .getOneCatalogeList
                                                        .subcategories![index]
                                                        .id!,
                                                  ),
                                                );
                                          },
                                        ),
                                        Divider(
                                          endIndent: 10,
                                          indent: 10,
                                          color: AppColors.lightGreyColor,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: EdgeInsets.only(top: 6.h),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: AppBorders.borderRadius10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocBuilder<SwitcherBloc, SwitcherState>(
                            builder: (context, state) {
                              return SwitchListTile(
                                dense: true,
                                visualDensity: VisualDensity.compact,
                                activeColor: AppColors.purpleColor,
                                title: Text(
                                  AppLocalization.of(context)
                                          .getTransatedValues(
                                        'saleAndPromotion',
                                      ) ??
                                      '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: AppFonts.fontSize14,
                                  ),
                                ),
                                value: state.tempIsLight ?? false,
                                onChanged: (value) {
                                  context
                                      .read<SwitcherBloc>()
                                      .add(ToggleSwitchEvent(value));
                                },
                              );
                            },
                          ),
                          Divider(
                            endIndent: 10,
                            indent: 10,
                            color: AppColors.lightGreyColor,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 5.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Бренды',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: AppFonts.fontSize14,
                                  ),
                                ),
                                const BrandCards(bottomSheet: 1),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    PriceRangeFieldAndCard(
                      bottomSheet: 1,
                      toPriceController: toTextEditingController,
                      fromPriceController: fromTextEditingController,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: kBottomNavigationBarHeight,
                        left: 10.w,
                        right: 10.w,
                      ),
                      child:
                          BlocBuilder<BrandSelectionBloc, BrandSelectionState>(
                        builder: (context, state) {
                          return BlocBuilder<CategoryRadioButtonSelectionBloc,
                              CategoryRadioButtonSelectionState>(
                            builder: (context, radioState) {
                              return BlocBuilder<SwitcherBloc, SwitcherState>(
                                builder: (context, switcherState) {
                                  return Button.textButton(
                                    text: 'Применить',
                                    onTap: () {
                                      context
                                          .read<
                                              CategoryRadioButtonSelectionBloc>()
                                          .add(ApplyRadioButtonEvent());
                                      context
                                          .read<SubCategorySelectionBloc>()
                                          .add(
                                            SubCategorySelectionEvent(
                                              pressedName: radioState
                                                      .tempSelectedTitle ??
                                                  '',
                                            ),
                                          );
                                      context
                                          .read<SwitcherBloc>()
                                          .add(ApplySwitcherEvent());
                                      context.read<BrandSelectionBloc>().add(
                                            const ApplyBrandEvent(
                                              bottomSheet: 1,
                                            ),
                                          );

                                      final int? priceFrom = int.tryParse(
                                        fromTextEditingController.text,
                                      );
                                      final int? priceTo = int.tryParse(
                                        toTextEditingController.text,
                                      );

                                      context.read<AllProductsBloc>().add(
                                            GetAllProductsList(
                                              postData: {
                                                'categories': [
                                                  radioState.selectedId == ''
                                                      ? categoryId
                                                      : radioState.selectedId,
                                                ],
                                                'brands': state
                                                    .selectedBrandBottomSheet1
                                                    .map((e) => e['brandId'])
                                                    .toList(),
                                                'shops': const [],
                                                'priceFrom': priceFrom,
                                                'priceTo': priceTo,
                                                'ordering': 'popular',
                                                'search': '',
                                                'pageSize': 10,
                                                'discount':
                                                    switcherState.tempIsLight,
                                                'isLiked': true,
                                                'page': 1,
                                              },
                                            ),
                                          );
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              );
                            },
                          );
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
    },
  );
}
