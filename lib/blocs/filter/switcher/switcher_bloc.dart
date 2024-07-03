import 'package:bloc/bloc.dart';

part 'switcher_event.dart';
part 'switcher_state.dart';

class SwitcherBloc extends Bloc<SwitcherEvent, SwitcherState> {
  SwitcherBloc() : super(SwitcherState(false)) {
    on<ToggleSwitchEvent>((event, emit) {
      emit(state.copyWith(tempIsLight: event.isLight));
    });

    on<ApplySwitcherEvent>((event, emit) {
      emit(state.copyWith(isLight: state.tempIsLight ?? state.isLight));
    });
  }
}
