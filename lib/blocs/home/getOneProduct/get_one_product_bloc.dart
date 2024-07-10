import 'package:amira_app/data/api_repositories/getOneProduct_repository.dart';
import 'package:amira_app/data/models/getOneProduct_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_one_product_event.dart';
part 'get_one_product_state.dart';

class GetOneProductBloc extends Bloc<GetOneProductEvent, GetOneProductState> {
  GetOneProductBloc() : super(GetOneProductInitial()) {
    final GetOneProductRepository getOneProductRepository =
        GetOneProductRepository();
    on<GetOneProduct>((event, emit) async {
      print('it is product event ${event.id}');
      try {
        emit(GetOneProductLoading());
        final getOneProduct =
            await getOneProductRepository.getOneProductRepository(event.id);
        print(getOneProduct);
        emit(GetOneProductLoaded(getOneProductList: getOneProduct));
      } catch (e) {
        emit(GetOneProductError(error: e.toString()));
      }
    });
  }
}
