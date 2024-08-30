import 'package:amira_app/data/api_repositories/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    final AuthRepository loginRepository = AuthRepository();
    on<LoginSubmitted>((event, emit) async {
      try {
        final statusCode = await loginRepository.signIn(
          phone: event.phoneNumber,
          password: event.password,
        );
        if (statusCode == 200 || statusCode == 201) {
          emit(LoginLoaded(statusCode: statusCode!));
        } else {
          emit(LoginFailure(statusCode: statusCode!));
        }
      } catch (e) {}
    });
    on<ResetLogin>((event, emit) async {
      emit(LoginInitial());
    });
  }
}
