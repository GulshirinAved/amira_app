import 'package:amira_app/data/api_repositories/auth_repository.dart';
import 'package:amira_app/data/models/updateUserData_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'change_pass_event.dart';
part 'change_pass_state.dart';

class ChangePassBloc extends Bloc<ChangePassEvent, ChangePassState> {
  ChangePassBloc() : super(ChangePassInitial()) {
    final AuthRepository changePassRepository = AuthRepository();
    on<ChangePassSubmitted>((event, emit) async {
      try {
        final Data? userData = await changePassRepository.changePass(
          newPassword: event.newPassword ?? '',
          oldPassword: event.oldPassword ?? '',
        );
        emit(ChangePassLoaded(userData: userData!));
      } catch (e) {
        emit(ChangePassFailure(error: e.toString()));
      }
    });
    on<ResetPass>((event, emit) async {
      emit(ChangePassInitial());
    });
  }
}
