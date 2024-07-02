import 'package:amira_app/blocs/productProfile/dotIndicator_bloc.dart/dot_indicator_bloc.dart';
import 'package:amira_app/blocs/productProfile/imageScrolling/image_scrolling_bloc.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({
    super.key,
    required PageController pageController,
  }) : _pageController = pageController;

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 390.h,
          width: 390.w,
          margin: EdgeInsets.only(bottom: 5.h),
          child: PageView.builder(
            controller: _pageController,
            itemCount: productProfileImage.length,
            scrollDirection: Axis.horizontal,
            allowImplicitScrolling: true,
            onPageChanged: (value) {
              context
                  .read<ImageScrollingBloc>()
                  .add(ImageScrollingEvent(value));
              context.read<DotIndicatorBloc>().add(DotIndicatorEvent(value));
            },
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: AppBorders.borderRadius10,
              child: Image.asset(
                productProfileImage[index],
                height: 390.h,
                width: 390.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              productProfileImage.length,
              (index) => BlocBuilder<DotIndicatorBloc, DotIndicatorState>(
                builder: (context, stateIndicator) {
                  return GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                      context
                          .read<DotIndicatorBloc>()
                          .add(DotIndicatorEvent(index));
                    },
                    child: Container(
                      width:
                          stateIndicator.selectedIndex == index ? 50.w : 10.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                        color: stateIndicator.selectedIndex == index
                            ? AppColors.whiteColor
                            : AppColors.greyColor,
                        borderRadius: AppBorders.borderRadius10,
                        border: Border.all(
                          color: stateIndicator.selectedIndex == index
                              ? AppColors.whiteColor
                              : AppColors.greyColor,
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                      ),
                      margin: EdgeInsets.only(right: 5.w),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
