import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'expand_drop_down_state.dart';

class ExpandDropDownCubit extends Cubit<bool> {
  ExpandDropDownCubit() : super(false);
  void tapDropDown() {
    emit(!state);
  }
}
