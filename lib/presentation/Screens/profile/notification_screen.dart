import 'package:amira_app/app_localization.dart';
import 'package:amira_app/blocs/profile/notificationCheckBox/notification_check_box_cubit.dart';
import 'package:amira_app/presentation/CustomWidgets/customContainer_extension.dart';
import 'package:amira_app/presentation/CustomWidgets/custom_appbar.dart';
import 'package:amira_app/presentation/Screens/profile/components/notification_checkBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationCheckBoxCubit(),
      child: Scaffold(
        appBar: CustomAppBar(
          topTitle:
              AppLocalization.of(context).getTransatedValues('notification') ??
                  '',
        ),
        body: ListView(
          children: [
            //checkboxes
            CustomContainer.buildContainer(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 6.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //checkbox for sale
                  NotificationCheckBox(
                    topTitle: AppLocalization.of(context)
                            .getTransatedValues('saleAndPromotion') ??
                        '',
                    noti1Type: 'sale_sms',
                    noti2Type: 'sale_post',
                  ),
                  //checkbox for sending
                  NotificationCheckBox(
                    topTitle: AppLocalization.of(context)
                            .getTransatedValues('sendingLetter') ??
                        '',
                    noti1Type: 'sending_sms',
                    noti2Type: 'sending_post',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
