import 'package:amira_app/data/models/fav_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'favbutton_event.dart';
part 'favbutton_state.dart';

class FavButtonBloc extends Bloc<FavButtonEvent, FavButtonState> {
  FavButtonBloc() : super(const FavButtonInitial(favList: [])) {
    on<ToggleFavEvent>((event, emit) {
      final existingIndex =
          state.favList.indexWhere((item) => item.id == event.item.id);
      final List<FavItem> updatedFavList = List.from(state.favList);

      if (existingIndex != -1) {
        updatedFavList.removeAt(existingIndex);
      } else {
        updatedFavList.add(event.item);
      }

      emit(SuccessState(favList: updatedFavList));
    });
  }
}
