import 'package:amira_app/app_localization.dart';
import 'package:amira_app/blocs/auth/removeAccaunt/remove_accaunt_bloc.dart';
import 'package:amira_app/config/theme/constants.dart';
import 'package:amira_app/presentation/CustomWidgets/button.dart';
import 'package:amira_app/presentation/Screens/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<dynamic> customDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (contextt) => BlocProvider(
      create: (context) => RemoveAccauntBloc(),
      child: Builder(
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: AppBorders.borderRadius10),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              width: 390,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(contextt);
                      },
                      icon: Icon(
                        Icons.close,
                        color: AppColors.greyColor,
                      ),
                    ),
                  ),
                  Text(
                    AppLocalization.of(context)
                            .getTransatedValues('logoutTitle') ??
                        '',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: AppFonts.fontSize18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Button.textButton(
                          backColor: AppColors.greenColor,
                          text: AppLocalization.of(context)
                              .getTransatedValues('no'),
                          onTap: () {
                            Navigator.pop(contextt);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Button.textButton(
                          backColor: AppColors.redColor,
                          text: AppLocalization.of(context)
                              .getTransatedValues('yes'),
                          onTap: () {
                            context
                                .read<RemoveAccauntBloc>()
                                .add(RemoveAccauntSubmitted());
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SplashScreen(),
                              ),
                              (route) => false,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}
