import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'delivery_selection_event.dart';
part 'delivery_selection_state.dart';

class DeliverySelectionBloc
    extends Bloc<DeliverySelectionEvent, DeliverySelectionState> {
  DeliverySelectionBloc() : super(const DeliverySelectionState('', '')) {
    on<DeliverySelectionEvent>((event, emit) {
      emit(
        state.copyWith(
          title: event.pressedTitle,
          id: event.pressedId,
        ),
      );
    });
  }
}
