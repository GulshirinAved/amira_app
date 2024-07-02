import 'package:amira_app/blocs/favButton/favbutton_bloc.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/data/models/cart_model.dart';
import 'package:amira_app/data/models/fav_model.dart';
import 'package:amira_app/presentation/CustomWidgets/custom_textField.dart';
import 'package:amira_app/presentation/CustomWidgets/productLarge_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
              child: CustomTextField.search(),
            ),
            BlocBuilder<FavButtonBloc, FavButtonState>(
              builder: (context, state) {
                if (state is FavButtonInitial || state.favList.isEmpty) {
                  return const Center(
                    child: Text('There is no favorites'),
                  );
                } else {
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: AppBorders.borderRadius10,
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 370,
                      ),
                      itemCount: state.favList.length,
                      itemBuilder: (context, index) {
                        final favList = state.favList[index];
                        return ProductLargeCard(
                          index: index,
                          cartItem: CartItem(
                            id: favList.id,
                            name: favList.name,
                            image: favList.image,
                            price: favList.price,
                            prevPrice: favList.prevPrice,
                            discount: favList.discount,
                            desc: favList.desc,
                          ),
                          favItem: FavItem(
                            id: favList.id,
                            name: favList.name,
                            image: favList.image,
                            price: favList.price,
                            prevPrice: favList.prevPrice,
                            discount: favList.discount,
                            desc: favList.desc,
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
