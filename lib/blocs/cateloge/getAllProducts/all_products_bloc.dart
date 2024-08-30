import 'package:amira_app/data/api_repositories/getAllProducts_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'all_products_event.dart';
part 'all_products_state.dart';

class AllProductsBloc extends Bloc<AllProductsEvent, AllProductsState> {
  ScrollController scrollController = ScrollController();

  Map<String, dynamic> currentFilter = {};
  bool isLoadingMore = false;
  int page = 1;

  AllProductsBloc() : super(AllProductsInitial()) {
    final GetAllProductsRepository allProductsRepository =
        GetAllProductsRepository();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!isLoadingMore) {
          add(const AllProductsLoadMoreEvent());
        }
      }
    });
    on<GetAllProductsList>((event, emit) async {
      isLoadingMore = false;
      currentFilter = event.postData;
      page = 1;
      try {
        final List<dynamic> allProductsList = await allProductsRepository
            .fetchAllProductList(currentFilter, page);
        emit(AllProductsLoaded(
          allProductsList: allProductsList,
        ));
      } catch (e) {
        emit(AllProductsError(error: e.toString()));
      }
    });
    on<AllProductsLoadMoreEvent>((event, emit) async {
      if (!isLoadingMore && state is AllProductsLoaded) {
        isLoadingMore = true;
        page++;
        final List<dynamic> allProductsList = await allProductsRepository
            .fetchAllProductList(currentFilter, page);
        if (allProductsList.isNotEmpty) {
          emit(
            AllProductsLoaded(
              allProductsList: [
                ...(state as AllProductsLoaded).allProductsList,
                ...allProductsList,
              ],
            ),
          );
        }
        isLoadingMore = false;
      }
    });
  }
}
