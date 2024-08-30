part of 'update_user_data_bloc.dart';

sealed class UpdateUserDataEvent extends Equatable {
  const UpdateUserDataEvent();

  @override
  List<Object> get props => [];
}

class UpdateUserDataSubmitted extends UpdateUserDataEvent {
  final String? name;
  final String? birthday;
  final String? email;
  final String? gender;

  const UpdateUserDataSubmitted({
    required this.name,
    required this.birthday,
    required this.gender,
    required this.email,
  });
  @override
  List<Object> get props =>
      [name ?? '', birthday ?? '', gender ?? '', email ?? ''];
}
