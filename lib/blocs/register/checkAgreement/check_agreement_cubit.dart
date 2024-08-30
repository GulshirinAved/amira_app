import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'check_agreement_state.dart';

class CheckAgreementCubit extends Cubit<bool> {
  CheckAgreementCubit() : super(false);
  void toggleCheck() {
    emit(!state);
  }
}
