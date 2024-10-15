import 'package:amira_app/data/api_repositories/getPayment_repository.dart';
import 'package:amira_app/data/models/payment_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_payment_event.dart';
part 'get_payment_state.dart';

class GetPaymentBloc extends Bloc<GetPaymentEvent, GetPaymentState> {
  final PaymentRepository _paymentRepository = PaymentRepository();
  GetPaymentBloc() : super(GetPaymentInitial()) {
    on<GetPaymentList>((event, emit) async {
      try {
        final List<Rows> paymentList = await _paymentRepository.getPayment();
        emit(GetPaymentLoaded(paymentList: paymentList));
      } catch (e) {
        emit(GetPaymentError(error: e.toString()));
      }
    });
  }
}
