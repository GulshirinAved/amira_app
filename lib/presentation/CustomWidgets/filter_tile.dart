import 'package:amira_app/blocs/filter/filter/categoryRadioButtonSelection/category_radio_button_selection_bloc.dart';
import 'package:amira_app/blocs/filter/brandSelection/brand_selection_bloc.dart';
import 'package:amira_app/blocs/filter/priceRangeSelection/price_range_selection_bloc.dart';
import 'package:amira_app/blocs/filter/switcher/switcher_bloc.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
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

  const FilterTile({
    super.key,
    this.width,
  });

  @override
  State<FilterTile> createState() => _FilterTileState();
}

class _FilterTileState extends State<FilterTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // filter icon
        GestureDetector(
          onTap: () {
            filterBottomSheet(context);
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
              child: FilterChipCard(index: index),
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
                  const PriceRangeFieldAndCard(
                    bottomSheet: 3,
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

  Future<dynamic> filterBottomSheet(BuildContext context) {
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
                        child: Column(
                          children: List.generate(
                            filterCatgeories.length,
                            (index) => BlocBuilder<
                                CategoryRadioButtonSelectionBloc,
                                CategoryRadioButtonSelectionState>(
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    CustomRadioButton(
                                      title: filterCatgeories[index],
                                      value: filterCatgeories[index],
                                      groupValue: state.tempSelectedTitle ??
                                          filterCatgeories[0],
                                      onChanged: (value) {
                                        context
                                            .read<
                                                CategoryRadioButtonSelectionBloc>()
                                            .add(
                                              SelectRadioButtonEvent(
                                                value ?? filterCatgeories[0],
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
                                    print(value);
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
                      const PriceRangeFieldAndCard(
                        bottomSheet: 1,
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
