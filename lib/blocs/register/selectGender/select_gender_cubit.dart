import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'select_gender_state.dart';

class SelectGenderCubit extends Cubit<String> {
  SelectGenderCubit() : super('');
  void selectGender(String value) {
    emit(value);
  }
}
