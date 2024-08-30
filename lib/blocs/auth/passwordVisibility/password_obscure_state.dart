// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'password_obscure_cubit.dart';

class ObscureState extends Equatable {
  final bool isPasswordObscured;
  final bool? isNewPassObscured;

  const ObscureState(
      {required this.isPasswordObscured, this.isNewPassObscured});

  @override
  List<Object> get props => [isPasswordObscured, isNewPassObscured ?? true];

  ObscureState copyWith({
    bool? isPasswordObscured,
    bool? isNewPassObscured,
  }) {
    return ObscureState(
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
      isNewPassObscured: isNewPassObscured ?? this.isNewPassObscured,
    );
  }
}
