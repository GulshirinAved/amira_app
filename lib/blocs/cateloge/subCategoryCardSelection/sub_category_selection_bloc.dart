import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sub_category_selection_event.dart';
part 'sub_category_selection_state.dart';

class SubCategorySelectionBloc
    extends Bloc<SubCategorySelectionEvent, SubCategorySelectionState> {
  SubCategorySelectionBloc()
      : super(const SubCategorySelectionState(subcategoryName: '')) {
    on<SubCategorySelectionEvent>((event, emit) {
      emit(state.copyWith(subcategoryName: event.pressedName));
    });
  }
}
