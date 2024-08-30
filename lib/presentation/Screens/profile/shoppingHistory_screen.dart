import 'package:amira_app/app_localization.dart';
import 'package:amira_app/blocs/cart/getAllOrder/get_all_order_bloc.dart';
import 'package:amira_app/presentation/CustomWidgets/animations.dart';
import 'package:amira_app/presentation/CustomWidgets/custom_appbar.dart';
import 'package:amira_app/presentation/Screens/profile/components/shopHistoryAllProduct_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingHistoryScreen extends StatelessWidget {
  const ShoppingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetAllOrderBloc()..add(GetOrdersList()),
      child: Scaffold(
        appBar: CustomAppBar(
          topTitle: AppLocalization.of(context)
                  .getTransatedValues('shoppingHistory') ??
              '',
        ),
        body: BlocBuilder<GetAllOrderBloc, GetAllOrderState>(
          builder: (context, state) {
            if (state is GetAllOrderError) {
              return Animations.empty;
            } else if (state is GetAllOrderInitial ||
                state is GetAllOrderLoading) {
              return Animations.loading;
            } else if (state is GetAllOrderLoaded) {
              return ListView.builder(
                controller:
                    BlocProvider.of<GetAllOrderBloc>(context).scrollController,
                itemCount: state.allOrdersList.length + 1,
                itemBuilder: (context, index) {
                  if (index >= state.allOrdersList.length) {
                    if (!BlocProvider.of<GetAllOrderBloc>(context)
                        .isLoadingMore) {
                      BlocProvider.of<GetAllOrderBloc>(context)
                          .add(GetMoreOrderList());
                    }
                    return state.allOrdersList.length != index
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const SizedBox.shrink();
                  }
                  return ShopHistoryAllProductCard(
                    ordersList: state.allOrdersList,
                    index: index,
                  );
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
