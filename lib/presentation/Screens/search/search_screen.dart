// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amira_app/blocs/searchShpwProducts/search_show_products_bloc.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/presentation/CustomWidgets/productLarge_card.dart';
import 'package:amira_app/presentation/Screens/home/components/gridviewProducts_slider.dart';
import 'package:amira_app/presentation/Screens/home/components/search_field.dart';
import 'package:amira_app/presentation/Screens/search/components/filter_chipCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      create: (context) => SearchShowProductsBloc(),
      child: Builder(
        builder: (context) {
          return SafeArea(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: [
                    //search field and clear button
                    Row(
                      children: [
                        Expanded(
                          child: SearchField(
                            hintText: 'Поиск',
                            needPrefix: true,
                            textController: searchController,
                            autofocus: true,
                            onChanged: (value) {
                              context.read<SearchShowProductsBloc>().add(
                                    SearchShowProductsEvent(
                                      searchController.text,
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
                            context.read<SearchShowProductsBloc>().add(
                                  SearchShowProductsEvent(
                                    searchController.text,
                                  ),
                                );
                          },
                          child: Text(
                            'Отмена',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: AppFonts.fontSize14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    BlocBuilder<SearchShowProductsBloc,
                        SearchShowProductsState>(
                      builder: (context, state) {
                        final List options = saleProducts
                            .where(
                              (product) =>
                                  product['name'].toLowerCase().contains(
                                        searchController.text.toLowerCase(),
                                      ),
                            )
                            .map((product) => product['name'] as String)
                            .toList();
                        return
                            //no text
                            state.selectedText == ''
                                ? const GridviewProductsSlider(
                                    topTitle: 'Рекомендуемые товары',
                                  )
                                //after option selected opens gridview products
                                : options.contains(state.selectedText)
                                    ? Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.whiteColor,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.r),
                                            topRight: Radius.circular(10.r),
                                          ),
                                        ),
                                        margin:
                                            EdgeInsets.symmetric(vertical: 6.h),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                        ),
                                        //filter raw
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 3.h,
                                              ),
                                              child: Row(
                                                children: [
                                                  //filter icon
                                                  Container(
                                                    height: 34.h,
                                                    width: 34.w,
                                                    decoration: BoxDecoration(
                                                      color: AppColors
                                                          .lightGreyColor,
                                                      borderRadius: AppBorders
                                                          .borderRadius10,
                                                    ),
                                                    child: SvgPicture.asset(
                                                      filterIcon,
                                                      fit: BoxFit.scaleDown,
                                                    ),
                                                  ),
                                                  //filter cards
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            75.w,
                                                    height: 38.h,
                                                    child: ListView.builder(
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount:
                                                          filtername.length,
                                                      itemBuilder:
                                                          (context, index) =>
                                                              FilterChipCard(
                                                        index: index,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            GridView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                mainAxisExtent: 370,
                                              ),
                                              itemCount: saleProducts.length,
                                              itemBuilder: (context, index) {
                                                return ProductLargeCard(
                                                  index: index,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      )
                                    // options popupmenu
                                    : Align(
                                        alignment: Alignment.topLeft,
                                        child: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: AppColors.whiteColor,
                                            child: ListView.separated(
                                              shrinkWrap: true,
                                              itemCount: options.length,
                                              itemBuilder: (
                                                BuildContext context,
                                                int index,
                                              ) {
                                                final option =
                                                    options.elementAt(index);
                                                return ListTile(
                                                  title: Text(option),
                                                  onTap: () {
                                                    context
                                                        .read<
                                                            SearchShowProductsBloc>()
                                                        .add(
                                                          SearchShowProductsEvent(
                                                            option,
                                                          ),
                                                        );
                                                    searchController.text =
                                                        option;
                                                  },
                                                );
                                              },
                                              separatorBuilder: (
                                                BuildContext context,
                                                int index,
                                              ) =>
                                                  const Divider(),
                                            ),
                                          ),
                                        ),
                                      );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
