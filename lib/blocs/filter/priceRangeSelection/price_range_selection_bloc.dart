import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'price_range_selection_event.dart';
part 'price_range_selection_state.dart';

class PriceRangeSelectionBloc
    extends Bloc<PriceRangeSelectionEvent, PriceRangeSelectionState> {
  PriceRangeSelectionBloc() : super(const PriceRangeSelectionState(-1)) {
    on<PriceRangeSelectionEvent>((event, emit) {
      emit(state.copyWith(selectedIndex: event.pressedIndex));
    });
  }
}
