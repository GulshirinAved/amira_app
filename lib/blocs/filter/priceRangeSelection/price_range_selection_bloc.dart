import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'price_range_selection_event.dart';
part 'price_range_selection_state.dart';

class PriceRangeSelectionBloc
    extends Bloc<PriceRangeSelectionEvent, PriceRangeSelectionState> {
  int? _selectedPriceBottomSheet1;
  int? _selectedPriceBottomSheet2;
  PriceRangeSelectionBloc() : super(const PriceRangeSelectionState(-1, -1)) {
    on<SelectPrice>((event, emit) {
      if (event.bottomSheet == 1) {
        _selectedPriceBottomSheet1 = event.pressedPriceIndex;
      } else if (event.bottomSheet == 3) {
        _selectedPriceBottomSheet2 = event.pressedPriceIndex;
      }
      emit(
        FilterPriceUpdated(
          _selectedPriceBottomSheet1 ?? -1,
          _selectedPriceBottomSheet2 ?? -1,
        ),
      );
    });
    on<ApplyPriceEvent>((event, emit) {
      if (event.bottomSheet == 1) {
        emit(
          FilterPriceUpdated(
            _selectedPriceBottomSheet1 ?? -1,
            _selectedPriceBottomSheet1 ?? -1,
          ),
        );
      } else if (event.bottomSheet == 3) {
        emit(
          FilterPriceUpdated(
            _selectedPriceBottomSheet2 ?? -1,
            _selectedPriceBottomSheet2 ?? -1,
          ),
        );
      }
    });
  }
}
