part of 'change_pass_bloc.dart';

sealed class ChangePassState extends Equatable {
  const ChangePassState();

  @override
  List<Object> get props => [];
}

final class ChangePassInitial extends ChangePassState {}

final class ChangePassLoaded extends ChangePassState {
  final int statusCode;

  const ChangePassLoaded({required this.statusCode});
  @override
  List<Object> get props => [statusCode];
}

final class ChangePassFailure extends ChangePassState {
  final int statusCode;

  const ChangePassFailure({required this.statusCode});
  @override
  List<Object> get props => [statusCode];
}
