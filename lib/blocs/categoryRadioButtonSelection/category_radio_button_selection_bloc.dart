import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_radio_button_selection_event.dart';
part 'category_radio_button_selection_state.dart';

class CategoryRadioButtonSelectionBloc extends Bloc<
    CategoryRadioButtonSelectionEvent, CategoryRadioButtonSelectionState> {
  CategoryRadioButtonSelectionBloc()
      : super(CategoryRadioButtonSelectionState(null)) {
    on<CategoryRadioButtonSelectionEvent>((event, emit) {
      emit(state.copyWith(title: event.pressedTitle));
    });
  }
}
