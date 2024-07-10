import 'package:amira_app/blocs/productProfile/dotIndicator_bloc.dart/dot_indicator_bloc.dart';
import 'package:amira_app/blocs/productProfile/imageScrolling/image_scrolling_bloc.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageSlider extends StatelessWidget {
  final List imageList;
  const ImageSlider({
    required PageController pageController,
    required this.imageList,
    super.key,
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
            itemCount: imageList.length,
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
              child: imageList[index] is Map<String, dynamic>
                  ? ExtendedImage.network(
                      'https://kip.tm/magaz/' + imageList[index]['url']!,
                      height: 390.h,
                      width: 390.w,
                      fit: BoxFit.cover,
                    )
                  : ExtendedImage.network(
                      'https://kip.tm/magaz/' + imageList[index].url,
                      height: 390.h,
                      width: 390.w,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
        imageList.length == 1
            ? SizedBox.shrink()
            : Positioned(
                bottom: 20.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    imageList.length,
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
                            width: stateIndicator.selectedIndex == index
                                ? 50.w
                                : 10.w,
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
