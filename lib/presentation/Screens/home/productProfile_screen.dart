// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amira_app/app_localization.dart';
import 'package:amira_app/blocs/cart/cartButton/cart_button_bloc.dart';
import 'package:amira_app/blocs/favButton/favbutton_bloc.dart';
import 'package:amira_app/blocs/home/getOneProduct/get_one_product_bloc.dart';
import 'package:amira_app/blocs/productProfile/expanableText/expandable_text_cubit.dart';
import 'package:amira_app/data/models/cart_model.dart';
import 'package:amira_app/data/models/fav_model.dart';
import 'package:amira_app/presentation/CustomWidgets/animations.dart';
import 'package:amira_app/presentation/CustomWidgets/button.dart';
import 'package:amira_app/presentation/CustomWidgets/cartAmount_button.dart';
import 'package:amira_app/presentation/CustomWidgets/customContainer_extension.dart';
import 'package:amira_app/presentation/Screens/home/components/discount_card.dart';
import 'package:amira_app/presentation/Screens/home/components/expandable_text.dart';
import 'package:amira_app/presentation/Screens/home/components/gridviewProducts_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:amira_app/blocs/productProfile/dotIndicator/dot_indicator_bloc.dart';
import 'package:amira_app/blocs/productProfile/imageScrolling/image_scrolling_bloc.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/constants.dart';
import 'package:amira_app/presentation/CustomWidgets/custom_appbar.dart';
import 'package:amira_app/presentation/Screens/home/components/image_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProductProfileScreen extends StatefulWidget {
  final FavItem favItem;
  final CartItem cartItem;
  final int index;

  const ProductProfileScreen({
    required this.favItem,
    required this.index,
    required this.cartItem,
    super.key,
  });

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
        BlocProvider(
          create: (context) =>
              GetOneProductBloc()..add(GetOneProduct(id: widget.favItem.id)),
        ),
        BlocProvider(
          create: (context) => ExpandableTextCubit(),
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
                  topTitle: widget.favItem.name ?? '',
                  iconTitle: isFav ? heartBoldIcon : heartIcon,
                  favActiveColor:
                      isFav ? AppColors.purpleColor : AppColors.greyColor,
                  onTap: () => context
                      .read<FavButtonBloc>()
                      .add(ToggleFavEvent(item: widget.favItem)),
                ),
                body: BlocBuilder<GetOneProductBloc, GetOneProductState>(
                  builder: (context, state) {
                    if (state is GetOneProductError) {
                      return SizedBox.shrink();
                    } else if (state is GetOneProductInitial ||
                        state is GetOneProductLoading) {
                      return Animations.loading;
                    }
                    return ListView(
                      children: [
                        //first tile:image and discount
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: AppBorders.borderRadius10,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                          child: Column(
                            children: [
                              //image slider

                              ImageSlider(
                                imageList: widget.favItem.image!,
                                pageController: _pageController,
                              ),
                              //discount cards
                              widget.favItem.discount?.price == null
                                  ? const SizedBox.shrink()
                                  : Row(
                                      children: [
                                        //discount
                                        DiscountCard(
                                          title:
                                              '${widget.favItem.discount!.percent}%',
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
                        //desc
                        CustomContainer.buildContainer(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(vertical: 6.h),
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          alignment: Alignment.centerLeft,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalization.of(context).getTransatedValues(
                                      'description',
                                    ) ??
                                    '',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: AppFonts.fontSize14,
                                  color: AppColors.blackColor,
                                ),
                              ),
                              ExpandableText(
                                text: widget.favItem.desc ?? '',
                              ),
                            ],
                          ),
                        ),
                        //third tile brand desc
                        CustomContainer.buildContainer(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(vertical: 6.h),
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: BlocBuilder<GetOneProductBloc,
                              GetOneProductState>(
                            builder: (context, state) {
                              if (state is GetOneProductError) {
                                return Center(
                                  child: Text(state.error.toString()),
                                );
                              } else if (state is GetOneProductInitial) {
                                return SizedBox.shrink();
                              } else if (state is GetOneProductLoading) {
                                return Animations.loading;
                              } else if (state is GetOneProductLoaded) {
                                if (state.getOneProductList.product == null) {
                                  return SizedBox.shrink();
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //brand name
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: ClipRRect(
                                        borderRadius: AppBorders.borderRadius10,
                                        child: ExtendedImage.network(
                                          '$url${widget.favItem.brand?.logo?.url}',
                                          height: 42.h,
                                          width: 83.w,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      title: Text(
                                        state.getOneProductList.product!.brand!
                                            .name!,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: AppFonts.fontSize14,
                                        ),
                                      ),
                                      subtitle: Text(
                                        AppLocalization.of(context)
                                                .getTransatedValues('brand') ??
                                            '',
                                        style: TextStyle(
                                          color: AppColors.greyColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: AppFonts.fontSize14,
                                        ),
                                      ),
                                      trailing:
                                          SvgPicture.asset(arrowRightIcon),
                                    ),
                                    //seller
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.getOneProductList.product!.shop!
                                                  .name ??
                                              '',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: AppFonts.fontSize14,
                                          ),
                                        ),
                                        Text(
                                          AppLocalization.of(context)
                                                  .getTransatedValues(
                                                'seller',
                                              ) ??
                                              '',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: AppFonts.fontSize14,
                                            color: AppColors.greyColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ),
                        //recommended
                        BlocBuilder<GetOneProductBloc, GetOneProductState>(
                          builder: (context, state) {
                            if (state is GetOneProductError) {
                              return SizedBox.shrink();
                            } else if (state is GetOneProductInitial) {
                              return SizedBox.shrink();
                            } else if (state is GetOneProductLoading) {
                              return Animations.loading;
                            } else if (state is GetOneProductLoaded) {
                              if (state.getOneProductList.similaryProducts!
                                  .isEmpty) {
                                return SizedBox.shrink();
                              }
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: GridviewProductsSlider(
                                  topTitle: AppLocalization.of(context)
                                          .getTransatedValues('recommend') ??
                                      '',
                                  productList:
                                      state.getOneProductList.similaryProducts!,
                                ),
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
                bottomSheet: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ).copyWith(bottom: kBottomNavigationBarHeight + 10, top: 10),
                  child: SizedBox(
                    height: 34.h,
                    child: Row(
                      children: [
                        Expanded(
                          child: BlocBuilder<CartButtonBloc, CartButtonState>(
                            builder: (context, state) {
                              final isItemInCart = state.cartList.any(
                                (item) => item.id == widget.cartItem.id,
                              );
                              return !isItemInCart
                                  ? Button.iconButton(
                                      width: 120.w,
                                      onTap: () {
                                        context.read<CartButtonBloc>().add(
                                              AddCartEvent(
                                                widget.cartItem,
                                              ),
                                            );
                                        context
                                            .read<CartButtonBloc>()
                                            .add(SumProductEvent());
                                      },
                                    )
                                  : CartAmountButton(
                                      index: widget.index,
                                      cartItem: widget.cartItem,
                                      height: 34.w,
                                    );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
