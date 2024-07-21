import 'package:amira_app/blocs/cateloge/getOneCataloge/get_one_cateloge_bloc.dart';
import 'package:amira_app/blocs/cateloge/subCategoryCardSelection/sub_category_selection_bloc.dart';
import 'package:amira_app/blocs/filter/brandSelection/brand_selection_bloc.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/presentation/CustomWidgets/animations.dart';
import 'package:amira_app/presentation/CustomWidgets/brand_bottomSheet.dart';
import 'package:amira_app/presentation/CustomWidgets/filter_bottomSheet.dart';
import 'package:amira_app/presentation/CustomWidgets/price_bottomSheet.dart';
import 'package:amira_app/presentation/Screens/search/components/filter_chipCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class FilterTile extends StatefulWidget {
  final double? width;
  final String subCategoryId;
  final String categoryId;

  final bool? isTopPressed;
  const FilterTile({
    required this.subCategoryId,
    required this.categoryId,
    required this.isTopPressed,
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
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          // filter icon
          GestureDetector(
            onTap: () {
              filterBottomSheet(
                context,
                widget.categoryId,
                _toTextEditingController,
                _fromTextEditingController,
              );
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
            width: widget.width ?? MediaQuery.of(context).size.width - 58.w,
            height: 38.h,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: filtername.length,
              itemBuilder: (context, index) =>
                  BlocBuilder<BrandSelectionBloc, BrandSelectionState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      index == 1
                          ? brandBottomSheet(context,
                              subCategoryId: widget.subCategoryId,
                              brandList: state.selectedBrandBottomSheet2
                                  .map(
                                    (e) => e['brandId'],
                                  )
                                  .toList())
                          : index == 2
                              ? priceBottomsheet(
                                  context,
                                  widget.subCategoryId,
                                  _toTextEditingController,
                                  _fromTextEditingController)
                              : null;
                    },
                    child: BlocBuilder<GetOneCatelogeBloc, GetOneCatelogeState>(
                      builder: (context, state) {
                        if (state is GetOneCatalogeError) {
                          return Center(
                            child: Text(state.error.toString()),
                          );
                        } else if (state is GetOneCatelogeInitial ||
                            state is GetOneCatalogeLoading) {
                          return Animations.loading;
                        } else if (state is GetOneCatalogeLoaded) {
                          if (state.getOneCatalogeList.subcategories!.isEmpty) {
                            return const SizedBox.shrink();
                          }
                          return BlocBuilder<SubCategorySelectionBloc,
                              SubCategorySelectionState>(
                            builder: (context, selectionState) {
                              return index == 0 &&
                                      selectionState.subcategoryName == ''
                                  ? const SizedBox.shrink()
                                  : FilterChipCard(
                                      index: index,
                                      isTopPressed: widget.isTopPressed,
                                    );
                            },
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
