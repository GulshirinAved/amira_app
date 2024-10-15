part of 'subscribe_notification_bloc.dart';

sealed class SubscribeNotificationEvent extends Equatable {
  const SubscribeNotificationEvent();

  @override
  List<Object> get props => [];
}

final class Submit extends SubscribeNotificationEvent {
  final bool fcmNotifications;
  final bool emailNotifications;
  final bool smsNotifications;

  const Submit({
    required this.fcmNotifications,
    required this.emailNotifications,
    required this.smsNotifications,
  });
  @override
  List<Object> get props => [
        fcmNotifications,
        emailNotifications,
        smsNotifications,
      ];
}
