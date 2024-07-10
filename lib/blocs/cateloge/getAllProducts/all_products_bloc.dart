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
      print('it is current fielter ${currentFilter}');
      try {
        emit(AllProductsLoading());
        print('it is current fielter ${currentFilter}');
        final List<dynamic> allProductsList =
            await allProductsRepository.fetchAllProductList(currentFilter);
        print('it is current fielter ${currentFilter}');
        print('it is current products ${allProductsList}');
        emit(AllProductsLoaded(allProductsList: allProductsList));
      } catch (e) {
        emit(AllProductsError(error: e.toString()));
      }
    });
  }
}
