import 'package:amira_app/data/api_repositories/auth_repository.dart';
import 'package:amira_app/data/models/updateUserData_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'subscribe_notification_event.dart';
part 'subscribe_notification_state.dart';

class SubscribeNotificationBloc
    extends Bloc<SubscribeNotificationEvent, SubscribeNotificationState> {
  SubscribeNotificationBloc() : super(SubscribeNotificationInitial()) {
    final AuthRepository subscribeNotify = AuthRepository();
    on<Submit>((event, emit) async {
      try {
        final Data? notifyData = await subscribeNotify.subscribeNotification(
          fcmNotifications: event.fcmNotifications,
          emailNotifications: event.emailNotifications,
          smsNotifications: event.smsNotifications,
        );
        emit(SubscribeNotificationSuccess(notificationData: notifyData!));
      } catch (e) {
        emit(SubScribeFailure(error: e.toString()));
      }
    });
  }
}
