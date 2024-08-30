import 'package:amira_app/data/api_repositories/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterSubmitted>((event, emit) async {
      final AuthRepository registerRepository = AuthRepository();
      try {
        final statusCode = await registerRepository.signUp(
          phone: event.phoneNumber,
          password: event.password,
          address: event.address,
          name: event.name,
          birthday: event.birthday,
          gender: event.gender,
        );

        if (statusCode == 200 || statusCode == 201) {
          emit(RegisterLoaded(statusCode: statusCode!));
        } else if (statusCode == 602) {
          emit(RegisterFailure(statusCode: statusCode!));
        } else if (statusCode == 603) {
          emit(RegisterFailure(statusCode: statusCode!));
        }
      } catch (e) {}
    });
    on<ResetRegister>((event, emit) async {
      emit(RegisterInitial());
    });
  }
}
