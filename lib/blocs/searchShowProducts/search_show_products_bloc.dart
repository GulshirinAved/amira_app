import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_show_products_event.dart';
part 'search_show_products_state.dart';

class SearchShowProductsBloc
    extends Bloc<SearchShowProductsEvent, SearchShowProductsState> {
  SearchShowProductsBloc() : super(const SearchShowProductsState('')) {
    on<SearchShowProductsEvent>((event, emit) {
      emit(state.copyWith(selectedText: event.pressedText));
    });
  }
}
