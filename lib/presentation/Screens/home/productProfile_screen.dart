// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amira_app/blocs/favButton/favbutton_bloc.dart';
import 'package:amira_app/data/models/fav_model.dart';
import 'package:amira_app/presentation/Screens/home/components/discount_card.dart';
import 'package:amira_app/presentation/Screens/home/components/gridviewProducts_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:amira_app/blocs/productProfile/dotIndicator_bloc.dart/dot_indicator_bloc.dart';
import 'package:amira_app/blocs/productProfile/imageScrolling/image_scrolling_bloc.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/presentation/CustomWidgets/custom_appbar.dart';
import 'package:amira_app/presentation/Screens/home/components/image_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProductProfileScreen extends StatefulWidget {
  final FavItem favItem;
  const ProductProfileScreen({required this.favItem, super.key});

  @override
  State<ProductProfileScreen> createState() => _ProductProfileScreenState();
}

class _ProductProfileScreenState extends State<ProductProfileScreen> {
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ImageScrollingBloc(),
        ),
        BlocProvider(
          create: (context) => DotIndicatorBloc(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return BlocBuilder<FavButtonBloc, FavButtonState>(
            builder: (context, state) {
              final isFav =
                  state.favList.any((item) => item.id == widget.favItem.id);
              return Scaffold(
                appBar: CustomAppBar(
                  topTitle: 'Органические яблоки',
                  iconTitle: isFav ? heartBoldIcon : heartIcon,
                  favActiveColor:
                      isFav ? AppColors.purpleColor : AppColors.darkGreyColor,
                  onTap: () => context
                      .read<FavButtonBloc>()
                      .add(ToggleFavEvent(item: widget.favItem)),
                ),
                body: ListView(
                  children: [
                    //first tile:image and dicount
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: AppBorders.borderRadius10,
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 16.h),
                      child: Column(
                        children: [
                          //image slider

                          ImageSlider(pageController: _pageController),
                          //discount cards
                          widget.favItem.discount == null
                              ? const SizedBox.shrink()
                              : Row(
                                  children: [
                                    //discount
                                    DiscountCard(
                                      title: widget.favItem.discount!,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    //sale
                                    DiscountCard(
                                      title: 'Акция',
                                      backColor: AppColors.greenColor,
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                    //second tile
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: AppBorders.borderRadius10,
                      ),
                      margin: EdgeInsets.symmetric(vertical: 6.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //brand name
                          ListTile(
                            leading: Image.asset(logo1Image),
                            title: Text(
                              'Alma production',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: AppFonts.fontSize14,
                              ),
                            ),
                            subtitle: Text(
                              'Бренд',
                              style: TextStyle(
                                color: AppColors.greyColor,
                                fontWeight: FontWeight.w700,
                                fontSize: AppFonts.fontSize14,
                              ),
                            ),
                            trailing: SvgPicture.asset(arrowRightIcon),
                          ),
                          //seller
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Мерген Джумаев',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: AppFonts.fontSize14,
                                ),
                              ),
                              Text(
                                'Продавец',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: AppFonts.fontSize14,
                                  color: AppColors.greyColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const GridviewProductsSlider(topTitle: 'Рекомендуем'),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
