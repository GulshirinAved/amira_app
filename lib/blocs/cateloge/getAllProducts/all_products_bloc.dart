import 'package:amira_app/data/api_repositories/getAllProducts_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'all_products_event.dart';
part 'all_products_state.dart';

class AllProductsBloc extends Bloc<AllProductsEvent, AllProductsState> {
  Map<String, dynamic> currentFilter = {};
  AllProductsBloc() : super(AllProductsInitial()) {
    final GetAllProductsRepository allProductsRepository =
        GetAllProductsRepository();
    on<GetAllProductsList>((event, emit) async {
      currentFilter = event.postData;
      try {
        emit(AllProductsLoading());
        final List<dynamic> allProductsList =
            await allProductsRepository.fetchAllProductList(currentFilter);
        emit(AllProductsLoaded(allProductsList: allProductsList));
      } catch (e) {
        emit(AllProductsError(error: e.toString()));
      }
    });
  }
}
