import 'package:amira_app/data/api_providers/auth_provider.dart';
import 'package:amira_app/data/models/updateUserData_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final AuthProvider userProfileProvider = AuthProvider();

  UserProfileBloc() : super(UserProfileInitial()) {
    on<GetUserData>((event, emit) async {
      try {
        final Data? userData = await userProfileProvider.getUserProfile();
        emit(UserProfileLoaded(userData: userData));
      } catch (e) {
        emit(UserProfileError(error: e.toString()));
      }
    });
  }
}
