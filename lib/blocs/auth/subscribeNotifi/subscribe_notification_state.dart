part of 'subscribe_notification_bloc.dart';

sealed class SubscribeNotificationState extends Equatable {
  const SubscribeNotificationState();

  @override
  List<Object> get props => [];
}

final class SubscribeNotificationInitial extends SubscribeNotificationState {}

final class SubscribeNotificationSuccess extends SubscribeNotificationState {
  final Data notificationData;

  const SubscribeNotificationSuccess({required this.notificationData});
  @override
  List<Object> get props => [notificationData];
}

final class SubScribeFailure extends SubscribeNotificationState {
  final String error;

  const SubScribeFailure({required this.error});
  @override
  List<Object> get props => [error];
}
