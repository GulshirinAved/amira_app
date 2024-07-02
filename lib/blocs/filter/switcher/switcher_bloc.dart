import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'switcher_event.dart';
part 'switcher_state.dart';

class SwitcherBloc extends Bloc<SwitcherEvent, SwitcherState> {
  SwitcherBloc() : super(SwitcherState(false)) {
    on<SwitcherEvent>((event, emit) {
      emit(state.copyWith(isLight: event.isLight));
    });
  }
}
