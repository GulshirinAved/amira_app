import 'package:amira_app/data/api_repositories/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'change_pass_event.dart';
part 'change_pass_state.dart';

class ChangePassBloc extends Bloc<ChangePassEvent, ChangePassState> {
  ChangePassBloc() : super(ChangePassInitial()) {
    final AuthRepository changePassRepository = AuthRepository();
    on<ChangePassSubmitted>((event, emit) async {
      try {
        final statusCode = await changePassRepository.changePass(
          newPassword: event.newPassword,
          oldPassword: event.oldPassword,
        );
        if (statusCode == 200 || statusCode == 201) {
          emit(ChangePassLoaded(statusCode: statusCode!));
        } else {
          emit(ChangePassFailure(statusCode: statusCode!));
        }
      } catch (e) {}
    });
    on<ResetPass>((event, emit) async {
      emit(ChangePassInitial());
    });
  }
}
