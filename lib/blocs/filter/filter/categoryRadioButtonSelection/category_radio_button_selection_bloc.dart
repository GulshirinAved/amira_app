import 'package:bloc/bloc.dart';

part 'category_radio_button_selection_event.dart';
part 'category_radio_button_selection_state.dart';

class CategoryRadioButtonSelectionBloc extends Bloc<
    CategoryRadioButtonSelectionEvent, CategoryRadioButtonSelectionState> {
  CategoryRadioButtonSelectionBloc()
      : super(CategoryRadioButtonSelectionState(
            selectedTitle: null, tempSelectedTitle: null)) {
    on<SelectRadioButtonEvent>((event, emit) {
      emit(state.copyWith(tempSelectedTitle: event.pressedTitle));
    });

    on<ApplyRadioButtonEvent>((event, emit) {
      emit(state.copyWith(selectedTitle: state.tempSelectedTitle));
    });
  }
}
