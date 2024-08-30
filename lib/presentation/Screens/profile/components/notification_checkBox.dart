import 'package:amira_app/app_localization.dart';
import 'package:amira_app/blocs/profile/notificationCheckBox/notification_check_box_cubit.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/constants.dart';
import 'package:amira_app/presentation/CustomWidgets/custom_checkBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationCheckBox extends StatelessWidget {
  final String topTitle;
  final String noti1Type;
  final String noti2Type;

  const NotificationCheckBox({
    required this.topTitle,
    required this.noti1Type,
    required this.noti2Type,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          topTitle,
          style: TextStyle(
            fontFamily: fontPeaceSans,
            fontWeight: FontWeight.w400,
            fontSize: AppFonts.fontSize14,
          ),
        ),
        BlocBuilder<NotificationCheckBoxCubit, Map<String, bool>>(
          builder: (context, state) {
            return CustomCheckBox(
              title: AppLocalization.of(context)
                  .getTransatedValues(notificationList[0]),
              value: state[noti1Type],
              onChanged: (value) {
                context
                    .read<NotificationCheckBoxCubit>()
                    .toggleCheckbox(noti1Type);
              },
            );
          },
        ),
        BlocBuilder<NotificationCheckBoxCubit, Map<String, bool>>(
          builder: (context, state) {
            return CustomCheckBox(
              title: AppLocalization.of(context)
                  .getTransatedValues(notificationList[1]),
              value: state[noti2Type],
              onChanged: (value) {
                context
                    .read<NotificationCheckBoxCubit>()
                    .toggleCheckbox(noti2Type);
              },
            );
          },
        ),
      ],
    );
  }
}
