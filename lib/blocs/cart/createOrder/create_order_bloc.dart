import 'package:amira_app/data/api_repositories/createOrder_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_order_event.dart';
part 'create_order_state.dart';

class CreateOrderBloc extends Bloc<CreateOrderEvent, CreateOrderState> {
  CreateOrderBloc() : super(CreateOrderInitial()) {
    final CreateOrderRepository createOrderRepository = CreateOrderRepository();
    on<CreateOrderPressed>((event, emit) async {
      final bool result =
          await createOrderRepository.createOrder(postData: event.postData);
      if (result == true) {
        emit(const CreateOrderSuccess());
      } else {
        emit(const CreateOrderFailure('Something went wrong!'));
      }
    });
  }
}
