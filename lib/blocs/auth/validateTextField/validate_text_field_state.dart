// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'validate_text_field_bloc.dart';

class ValidateTextFieldState extends Equatable {
  final String phoneNumber;
  final String password;
  final String newPassword;

  final String verifyPass;
  final String birthdayDate;
  final String email;
  final String name;
  final String address;
  final bool isPhoneValid;
  final bool isPassValid;
  final bool isVerifyPassValid;

  final bool isVerifyBirthdayValid;
  final bool isVerifyEmailValid;
  final bool isNameValid;
  final bool isAddressValid;
  final bool isNewPassValid;

  const ValidateTextFieldState({
    required this.phoneNumber,
    required this.password,
    required this.newPassword,
    required this.verifyPass,
    required this.birthdayDate,
    required this.email,
    required this.name,
    required this.address,
    required this.isPhoneValid,
    required this.isPassValid,
    required this.isVerifyPassValid,
    required this.isVerifyBirthdayValid,
    required this.isVerifyEmailValid,
    required this.isNameValid,
    required this.isAddressValid,
    required this.isNewPassValid,
  });
  factory ValidateTextFieldState.initial() {
    return const ValidateTextFieldState(
        phoneNumber: '',
        password: '',
        verifyPass: '',
        birthdayDate: '',
        email: '',
        name: '',
        address: '',
        newPassword: '',
        isPhoneValid: true,
        isPassValid: true,
        isVerifyPassValid: true,
        isVerifyBirthdayValid: true,
        isVerifyEmailValid: true,
        isAddressValid: true,
        isNameValid: true,
        isNewPassValid: true);
  }

  @override
  List<Object> get props => [
        phoneNumber,
        password,
        birthdayDate,
        verifyPass,
        email,
        name,
        address,
        newPassword,
        isPhoneValid,
        isPassValid,
        isVerifyPassValid,
        isVerifyBirthdayValid,
        isVerifyEmailValid,
        isNameValid,
        isAddressValid,
        isNewPassValid,
      ];

  ValidateTextFieldState copyWith({
    String? phoneNumber,
    String? password,
    String? newPassword,
    String? verifyPass,
    String? birthdayDate,
    String? email,
    String? name,
    String? address,
    bool? isPhoneValid,
    bool? isPassValid,
    bool? isVerifyPassValid,
    bool? isVerifyBirthdayValid,
    bool? isVerifyEmailValid,
    bool? isNameValid,
    bool? isAddressValid,
    bool? isNewPassValid,
  }) {
    return ValidateTextFieldState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      newPassword: newPassword ?? this.newPassword,
      verifyPass: verifyPass ?? this.verifyPass,
      birthdayDate: birthdayDate ?? this.birthdayDate,
      email: email ?? this.email,
      name: name ?? this.name,
      address: address ?? this.address,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
      isPassValid: isPassValid ?? this.isPassValid,
      isVerifyPassValid: isVerifyPassValid ?? this.isVerifyPassValid,
      isVerifyBirthdayValid:
          isVerifyBirthdayValid ?? this.isVerifyBirthdayValid,
      isVerifyEmailValid: isVerifyEmailValid ?? this.isVerifyEmailValid,
      isNameValid: isNameValid ?? this.isNameValid,
      isAddressValid: isAddressValid ?? this.isAddressValid,
      isNewPassValid: isNewPassValid ?? this.isNewPassValid,
    );
  }
}
