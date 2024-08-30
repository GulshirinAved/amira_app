import 'package:amira_app/data/api_providers/auth_provider.dart';
import 'package:amira_app/data/api_repositories/auth_repository.dart';
import 'package:amira_app/data/models/updateUserData_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'update_user_data_event.dart';
part 'update_user_data_state.dart';

class UpdateUserDataBloc
    extends Bloc<UpdateUserDataEvent, UpdateUserDataState> {
  final AuthRepository updateUserDataRepository = AuthRepository();
  final AuthProvider updateUserDataProvider = AuthProvider();

  UpdateUserDataBloc() : super(UpdateUserDataInitial()) {
    on<UpdateUserDataSubmitted>((event, emit) async {
      try {
        final userData = await updateUserDataRepository.updateUserData(
          name: event.name,
          birthday: event.birthday,
          email: event.email,
          gender: event.gender,
        );
        print("""  name: ${event.name},
          birthday: ${event.birthday},
          email: ${event.email},
          gender: ${event.gender},""");
        print(userData);
        emit(UpdateUserDataLoaded(userData: userData!));
      } catch (e) {
        emit(UpdateUserDataFailure(error: e.toString()));
      }
    });
  }
}
