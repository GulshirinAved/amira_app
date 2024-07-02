import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'payment_selection_event.dart';
part 'payment_selection_state.dart';

class PaymentSelectionBloc
    extends Bloc<PaymentSelectionEvent, PaymentSelectionState> {
  PaymentSelectionBloc() : super(PaymentSelectionState('')) {
    on<PaymentSelectionEvent>((event, emit) {
      emit(state.copyWith(title: event.pressedTitle));
    });
  }
}
