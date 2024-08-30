import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'notification_check_box_state.dart';

class NotificationCheckBoxCubit extends Cubit<Map<String, bool>> {
  NotificationCheckBoxCubit()
      : super({
          'sale_sms': false,
          'sale_post': false,
          'sending_sms': false,
          'sending_post': false,
        });

  void toggleCheckbox(String key) {
    final newState = Map<String, bool>.from(state);
    newState[key] = !newState[key]!;
    emit(newState);
  }
}
