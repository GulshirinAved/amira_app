part of 'change_pass_bloc.dart';

sealed class ChangePassEvent extends Equatable {
  const ChangePassEvent();

  @override
  List<Object> get props => [];
}

class ChangePassSubmitted extends ChangePassEvent {
  final String? oldPassword;
  final String? newPassword;

  const ChangePassSubmitted(
      {required this.oldPassword, required this.newPassword});
  @override
  List<Object> get props => [oldPassword ?? '', newPassword ?? ''];
}

class ResetPass extends ChangePassEvent {
  const ResetPass();
}
