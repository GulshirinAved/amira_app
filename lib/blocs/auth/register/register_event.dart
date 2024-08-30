part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterSubmitted extends RegisterEvent {
  final String? phoneNumber;
  final String? password;
  final String? address;
  final String? name;
  final String? birthday;
  final String? gender;

  const RegisterSubmitted({
    required this.phoneNumber,
    required this.password,
    required this.address,
    required this.name,
    required this.birthday,
    required this.gender,
  });
  @override
  List<Object> get props => [
        phoneNumber ?? '',
        password ?? '',
        address ?? '',
        name ?? '',
        birthday ?? '',
        gender ?? '',
      ];
}

class ResetRegister extends RegisterEvent {}
