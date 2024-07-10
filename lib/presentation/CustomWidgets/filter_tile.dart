import 'package:amira_app/blocs/cateloge/getOneCataloge/get_one_cateloge_bloc.dart';
import 'package:amira_app/blocs/filter/filter/categoryRadioButtonSelection/category_radio_button_selection_bloc.dart';
import 'package:amira_app/blocs/filter/brandSelection/brand_selection_bloc.dart';
import 'package:amira_app/blocs/filter/priceRangeSelection/price_range_selection_bloc.dart';
import 'package:amira_app/blocs/filter/switcher/switcher_bloc.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/presentation/CustomWidgets/animations.dart';
import 'package:amira_app/presentation/CustomWidgets/button.dart';
import 'package:amira_app/presentation/CustomWidgets/radio_button.dart';
import 'package:amira_app/presentation/Screens/cataloge/components/brand_cards.dart';
import 'package:amira_app/presentation/Screens/cataloge/components/priceRangeFieldCard.dart';
import 'package:amira_app/presentation/Screens/search/components/filter_chipCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class FilterTile extends StatefulWidget {
  final double? width;
  final String id;

  const FilterTile({
    required this.id,
    super.key,
    this.width,
  });

  @override
  State<FilterTile> createState() => _FilterTileState();
}

class _FilterTileState extends State<FilterTile> {
  late TextEditingController _toTextEditingController;
  late TextEditingController _fromTextEditingController;

  @override
  void initState() {
    super.initState();
    _toTextEditingController = TextEditingController();
    _fromTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _toTextEditingController.dispose();
    _fromTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // filter icon
        GestureDetector(
          onTap: () {
            filterBottomSheet(context, widget.id);
          },
          child: Container(
            height: 34.h,
            width: 34.w,
            decoration: BoxDecoration(
              color: AppColors.lightGreyColor,
              borderRadius: AppBorders.borderRadius10,
            ),
            child: SvgPicture.asset(
              filterIcon,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        // filter cards
        SizedBox(
          width: widget.width ?? MediaQuery.of(context).size.width,
          height: 38.h,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: filtername.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                index == 1
                    ? brandBottomSheet(context)
                    : index == 2
                        ? priceBottomsheet(context)
                        : null;
              },
              child: BlocBuilder<GetOneCatelogeBloc, GetOneCatelogeState>(
                builder: (context, state) {
                  if (state is GetOneCatalogeError) {
                    return Center(
                      child: Text(state.error.toString()),
                    );
                  } else if (state is GetOneCatelogeInitial) {
                    return const Center(
                      child: Text('It is initial'),
                    );
                  } else if (state is GetOneCatalogeLoading) {
                    return Animations.loading;
                  } else if (state is GetOneCatalogeLoaded) {
                    if (state.getOneCatalogeList.subcategories!.isEmpty) {
                      return const Center(
                        child: Text('it is empty'),
                      );
                    }
                    return FilterChipCard(
                      index: index,
                      initialCategoryValue:
                          state.getOneCatalogeList.subcategories![0].name!,
                    );
                  }
                  return const Center(
                    child: const CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> priceBottomsheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: AppColors.lightGreyColor,
      builder: (contextt) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: BlocProvider.of<PriceRangeSelectionBloc>(
              context,
            ),
          ),
        ],
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
                    'Цена',
                    style: TextStyle(
                      fontFamily: fontPeaceSans,
                      fontWeight: FontWeight.w400,
                      fontSize: AppFonts.fontSize22,
                    ),
                  ),
                  PriceRangeFieldAndCard(
                    bottomSheet: 3,
                    toPriceController: _toTextEditingController,
                    fromPriceController: _fromTextEditingController,
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
                            .read<PriceRangeSelectionBloc>()
                            .add(const ApplyPriceEvent(bottomSheet: 3));
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

  Future<dynamic> brandBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: AppColors.lightGreyColor,
      builder: (contextt) => BlocProvider.value(
        value: BlocProvider.of<BrandSelectionBloc>(
          context,
        ),
        child: Column(
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> filterBottomSheet(BuildContext context, String id) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: AppColors.lightGreyColor,
      builder: (contextt) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: BlocProvider.of<CategoryRadioButtonSelectionBloc>(
                  context,
                ),
              ),
              BlocProvider.value(
                value: BlocProvider.of<SwitcherBloc>(
                  context,
                ),
              ),
              BlocProvider.value(
                value: BlocProvider.of<BrandSelectionBloc>(
                  context,
                ),
              ),
              BlocProvider.value(
                value: BlocProvider.of<PriceRangeSelectionBloc>(
                  context,
                ),
              ),
              BlocProvider.value(
                value: BlocProvider.of<GetOneCatelogeBloc>(
                  context,
                ),
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
                      //toptitle
                      Text(
                        'Фильтры',
                        style: TextStyle(
                          fontFamily: fontPeaceSans,
                          fontWeight: FontWeight.w400,
                          fontSize: AppFonts.fontSize22,
                        ),
                      ),
                      //first tile
                      //radio buttons
                      Container(
                        padding: const EdgeInsets.all(5),
                        color: AppColors.whiteColor,
                        child: BlocBuilder<GetOneCatelogeBloc,
                            GetOneCatelogeState>(
                          builder: (context, state) {
                            if (state is GetOneCatalogeError) {
                              return Center(
                                child: Text(state.error.toString()),
                              );
                            } else if (state is GetOneCatelogeInitial) {
                              return const Center(
                                child: Text('It is initial'),
                              );
                            } else if (state is GetOneCatalogeLoading) {
                              return Animations.loading;
                            } else if (state is GetOneCatalogeLoaded) {
                              if (state
                                  .getOneCatalogeList.subcategories!.isEmpty) {
                                return const Center(
                                  child: Text('it is empty'),
                                );
                              }
                              return Column(
                                children: List.generate(
                                  state
                                      .getOneCatalogeList.subcategories!.length,
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
                                                    state
                                                        .getOneCatalogeList
                                                        .subcategories![0]
                                                        .name!,
                                            onChanged: (value) {
                                              context
                                                  .read<
                                                      CategoryRadioButtonSelectionBloc>()
                                                  .add(
                                                    SelectRadioButtonEvent(
                                                      value ??
                                                          state
                                                              .getOneCatalogeList
                                                              .subcategories![0]
                                                              .name!,
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
                      //second tile
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
                            //switcher tile
                            BlocBuilder<SwitcherBloc, SwitcherState>(
                              builder: (context, state) {
                                return SwitchListTile(
                                  dense: true,
                                  visualDensity: VisualDensity.compact,
                                  activeColor: AppColors.purpleColor,
                                  title: Text(
                                    'Скидки и акции',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: AppFonts.fontSize14,
                                    ),
                                  ),
                                  value: state.tempIsLight ?? false,
                                  onChanged: (value) {
                                    context
                                        .read<SwitcherBloc>()
                                        .add(ToggleSwitchEvent(!value));
                                  },
                                );
                              },
                            ),
                            Divider(
                              endIndent: 10,
                              indent: 10,
                              color: AppColors.lightGreyColor,
                            ),
                            //brand name and brand cards
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
                                  const BrandCards(
                                    bottomSheet: 1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      //thirt tile
                      //price range textfield and price range card
                      PriceRangeFieldAndCard(
                        bottomSheet: 1,
                        toPriceController: _toTextEditingController,
                        fromPriceController: _fromTextEditingController,
                      ),
                      //save button
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: kBottomNavigationBarHeight,
                          left: 10.w,
                          right: 10.w,
                        ),
                        child: BlocBuilder<PriceRangeSelectionBloc,
                            PriceRangeSelectionState>(
                          builder: (context, state) {
                            return BlocBuilder<BrandSelectionBloc,
                                BrandSelectionState>(
                              builder: (context, state) {
                                return Button.textButton(
                                  text: 'Применить',
                                  onTap: () {
                                    context.read<BrandSelectionBloc>().add(
                                          const ApplyBrandEvent(bottomSheet: 1),
                                        );
                                    context.read<PriceRangeSelectionBloc>().add(
                                          const ApplyPriceEvent(bottomSheet: 1),
                                        );
                                    context
                                        .read<
                                            CategoryRadioButtonSelectionBloc>()
                                        .add(ApplyRadioButtonEvent());
                                    context
                                        .read<SwitcherBloc>()
                                        .add(ApplySwitcherEvent());
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
}
