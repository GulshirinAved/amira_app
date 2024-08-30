import 'package:amira_app/data/api_repositories/getAllOrders_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'get_all_order_event.dart';
part 'get_all_order_state.dart';

class GetAllOrderBloc extends Bloc<GetAllOrderEvent, GetAllOrderState> {
  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;
  int page = 1;

  GetAllOrderBloc() : super(GetAllOrderInitial()) {
    final GetAllOrdersRepository getAllOrdersRepository =
        GetAllOrdersRepository();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!isLoadingMore) {
          add(GetMoreOrderList());
        }
      }
    });

    on<GetOrdersList>((event, emit) async {
      isLoadingMore = false;
      page = 1;
      try {
        final List<dynamic> allOrdersList =
            await getAllOrdersRepository.fetchAllOrdersList(page: page);
        emit(GetAllOrderLoaded(allOrdersList: allOrdersList));
      } catch (e) {
        emit(GetAllOrderError(error: e.toString()));
      }
    });

    on<GetMoreOrderList>((event, emit) async {
      if (!isLoadingMore && state is GetAllOrderLoaded) {
        isLoadingMore = true;
        page++;
        try {
          final List<dynamic> allOrdersList =
              await getAllOrdersRepository.fetchAllOrdersList(page: page);
          if (allOrdersList.isNotEmpty) {
            emit(
              GetAllOrderLoaded(
                allOrdersList: [
                  ...(state as GetAllOrderLoaded).allOrdersList,
                  ...allOrdersList
                ],
              ),
            );
          }
        } catch (e) {
          emit(GetAllOrderError(error: e.toString()));
        } finally {
          isLoadingMore = false;
        }
      }
    });
  }
}
