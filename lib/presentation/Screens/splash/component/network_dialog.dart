import 'package:amira_app/app_localization.dart';
import 'package:amira_app/blocs/internetConnection/internet_connection_bloc.dart';
import 'package:amira_app/config/theme/constants.dart';
import 'package:amira_app/presentation/CustomWidgets/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> showingDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (contextt) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: AppBorders.borderRadius10,
        ),
        elevation: 1,
        backgroundColor: Colors.transparent,
        child: Container(
          alignment: Alignment.center,
          constraints: const BoxConstraints(minHeight: 190, maxHeight: 300),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: AppBorders.borderRadius10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Animations.nowifi,
              Container(
                margin: const EdgeInsets.symmetric(vertical: 7),
                child: Text(
                  AppLocalization.of(context)
                          .getTransatedValues('noConnection1') ??
                      '',
                  style: TextStyle(
                    fontSize: AppFonts.fontSize22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  textAlign: TextAlign.center,
                  AppLocalization.of(context)
                          .getTransatedValues('noConnection2') ??
                      '',
                  style: TextStyle(
                    fontSize: AppFonts.fontSize14,
                  ),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: AppBorders.borderRadius10,
                    ),
                  ),
                  backgroundColor: WidgetStatePropertyAll(
                    AppColors.purpleColor,
                  ),
                ),
                onPressed: () {
                  context
                      .read<InternetConnectionBloc>()
                      .add(const InternetListenEvent());
                },
                child: Text(
                  AppLocalization.of(context)
                          .getTransatedValues('noConnection3') ??
                      '',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: AppFonts.fontSize18,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
