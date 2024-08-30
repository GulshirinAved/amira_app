part of 'validate_text_field_bloc.dart';

sealed class ValidateTextFieldEvent extends Equatable {
  const ValidateTextFieldEvent();

  @override
  List<Object> get props => [];
}

class PhoneNumberChanged extends ValidateTextFieldEvent {
  final String phoneNumber;

  const PhoneNumberChanged({required this.phoneNumber});
  @override
  List<Object> get props => [phoneNumber];
}

class PasswordChanged extends ValidateTextFieldEvent {
  final String passWord;

  const PasswordChanged({required this.passWord});
  @override
  List<Object> get props => [passWord];
}

class NewPasswordChanged extends ValidateTextFieldEvent {
  final String newPassWord;

  const NewPasswordChanged({required this.newPassWord});
  @override
  List<Object> get props => [newPassWord];
}

class VerifyPassChanged extends ValidateTextFieldEvent {
  final String verifyPass;

  const VerifyPassChanged({required this.verifyPass});
  @override
  List<Object> get props => [verifyPass];
}

class BirthdayChanged extends ValidateTextFieldEvent {
  final String birthdayDate;

  const BirthdayChanged({required this.birthdayDate});
  @override
  List<Object> get props => [birthdayDate];
}

class EmailChanged extends ValidateTextFieldEvent {
  final String email;

  const EmailChanged({required this.email});
  @override
  List<Object> get props => [email];
}

class NameChanged extends ValidateTextFieldEvent {
  final String name;

  const NameChanged({required this.name});
  @override
  List<Object> get props => [name];
}

class AddressChanged extends ValidateTextFieldEvent {
  final String address;

  const AddressChanged({required this.address});
  @override
  List<Object> get props => [address];
}
