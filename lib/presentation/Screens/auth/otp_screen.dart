import 'package:amira_app/app_localization.dart';
import 'package:amira_app/blocs/auth/otp/otp_bloc.dart';
import 'package:amira_app/blocs/auth/saveOtpInput/save_otp_input_bloc.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/constants.dart';
import 'package:amira_app/presentation/CustomWidgets/button.dart';
import 'package:amira_app/presentation/CustomWidgets/custom_textField.dart';
import 'package:amira_app/presentation/Screens/bottomNavBar/bottomNavBar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({required this.phoneNumber, super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());
  late SaveOtpInputBloc saveOtpInputBloc;
  late OtpBloc otpBloc;

  @override
  void initState() {
    super.initState();
    saveOtpInputBloc = SaveOtpInputBloc();
    otpBloc = OtpBloc();
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    otpBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SaveOtpInputBloc>.value(
          value: saveOtpInputBloc,
        ),
        BlocProvider<OtpBloc>.value(
          value: otpBloc,
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                //image
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    appLogoImage,
                    height: 90.h,
                    width: 89.w,
                  ),
                ),
                //text otp
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 10),
                  child: Text(
                    AppLocalization.of(context)
                            .getTransatedValues('enterOtp') ??
                        '',
                    style: TextStyle(
                      fontFamily: fontPeaceSans,
                      fontSize: AppFonts.fontSize22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                //text desc
                Text(
                  AppLocalization.of(context)
                          .getTransatedValues('enterOtpForContinue') ??
                      '',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: AppFonts.fontSize14,
                    color: AppColors.greyColor,
                  ),
                ),
                //code textfield
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(
                    controllers.length,
                    (index) => Container(
                      width: 56,
                      height: 50,
                      margin: const EdgeInsets.only(right: 11, top: 10),
                      child: CustomTextField.normal(
                        hintText: '',
                        needPrefix: 2,
                        context: context,
                        rangeNumber: 1,
                        isTextNumber: true,
                        controller: controllers[index],
                        textCenterAlign: true,
                        focusNode: focusNodes[index],
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            if (index < controllers.length - 1) {
                              FocusScope.of(context)
                                  .requestFocus(focusNodes[index + 1]);
                            } else {
                              focusNodes[index].unfocus();
                            }
                            saveOtpInputBloc.add(AddCodeEvent(otpCode: value));
                          } else if (value.isEmpty && index > 0) {
                            FocusScope.of(context)
                                .requestFocus(focusNodes[index - 1]);
                            saveOtpInputBloc
                                .add(RemoveCodeEvent(otpCode: value));
                          }
                        },
                        onFieldSubmitted: (value) {
                          if (index < controllers.length - 1) {
                            FocusScope.of(context)
                                .requestFocus(focusNodes[index + 1]);
                          } else {
                            focusNodes[index].unfocus();
                          }
                        },
                      ),
                    ),
                  ),
                ),
                //button
                BlocListener<OtpBloc, OtpState>(
                  listener: (context, state) {
                    if (state is OtpFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(AppLocalization.of(context)
                                  .getTransatedValues(state.statusCode == 602
                                      ? 'userExists'
                                      : state.statusCode == 603
                                          ? 'otpinvalid'
                                          : 'error') ??
                              ''),
                        ),
                      );
                    } else if (state is OtpSuccess) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        pushReplacementWithNavBar(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BottomNavBar(),
                            ));
                      });
                    }
                  },
                  child: BlocBuilder<SaveOtpInputBloc, SaveOtpInputState>(
                    builder: (context, inputState) {
                      return BlocBuilder<OtpBloc, OtpState>(
                        builder: (context, state) {
                          return Button.textButton(
                            text: AppLocalization.of(context)
                                    .getTransatedValues('continue') ??
                                '',
                            onTap: () {
                              if (inputState.otpCode!.length != 4) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      AppLocalization.of(context)
                                              .getTransatedValues(
                                                  'mustBeFour') ??
                                          '',
                                    ),
                                  ),
                                );
                              } else {
                                otpBloc.add(
                                  SendOtp(
                                    widget.phoneNumber,
                                    int.parse(inputState.otpCode ?? ''),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
