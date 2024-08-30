import 'package:amira_app/app_localization.dart';
import 'package:amira_app/blocs/auth/forgetPass/forget_pass_bloc.dart';
import 'package:amira_app/blocs/auth/validateTextField/validate_text_field_bloc.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/constants.dart';
import 'package:amira_app/presentation/CustomWidgets/button.dart';
import 'package:amira_app/presentation/Screens/auth/components/custom_textField.dart';
import 'package:amira_app/blocs/auth/passwordVisibility/password_obscure_cubit.dart';
import 'package:amira_app/presentation/Screens/auth/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({super.key});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  late TextEditingController phoneController;

  late TextEditingController passController;
  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    passController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ValidateTextFieldBloc(),
        ),
        BlocProvider(
          create: (context) => ObscureCubit(),
        ),
        BlocProvider(
          create: (context) => ForgetPassBloc(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return SafeArea(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(20.0),
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
                    //text enter phone
                    Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 10),
                      child: Text(
                        AppLocalization.of(context)
                                .getTransatedValues('enterPhone') ??
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
                              .getTransatedValues('enterPhoneForContinue') ??
                          '',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: AppFonts.fontSize14,
                        color: AppColors.greyColor,
                      ),
                    ),
                    //phone textfield
                    BlocBuilder<ValidateTextFieldBloc, ValidateTextFieldState>(
                      builder: (context, state) {
                        return BaseTextField(
                          hintText: '',
                          errorText: state.isPhoneValid
                              ? ''
                              : AppLocalization.of(context).getTransatedValues(
                                    'errorPhone',
                                  ) ??
                                  '',
                          rangeNumber: 8,
                          isPhone: true,
                          controller: phoneController,
                          onChanged: (value) {
                            context.read<ValidateTextFieldBloc>().add(
                                PhoneNumberChanged(phoneNumber: value ?? ''));
                            return null;
                          },
                          isTextNumber: true,
                          prefixWidget: Text(
                            ' +993  ',
                            style: TextStyle(
                              fontSize: AppFonts.fontSize14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      },
                    ),
                    BlocBuilder<ValidateTextFieldBloc, ValidateTextFieldState>(
                      builder: (context, state) {
                        return BlocBuilder<ObscureCubit, ObscureState>(
                          builder: (context, obscureState) {
                            return BaseTextField(
                              rangeNumber: 8,
                              topPadding: 15,
                              hintText: AppLocalization.of(context)
                                      .getTransatedValues('password') ??
                                  '',
                              errorText: state.isPassValid
                                  ? ''
                                  : AppLocalization.of(context)
                                          .getTransatedValues('errorPass') ??
                                      '',
                              controller: passController,
                              onChanged: (value) {
                                context.read<ValidateTextFieldBloc>().add(
                                    PasswordChanged(passWord: value ?? ''));
                                return null;
                              },
                              isTextNumber: false,
                              prefixWidget: const SizedBox.shrink(),
                              isObscure: obscureState.isPasswordObscured,
                              suffixWidget: GestureDetector(
                                onTap: () {
                                  context
                                      .read<ObscureCubit>()
                                      .togglePasswordObscure();
                                },
                                child: SvgPicture.asset(
                                  obscureState.isPasswordObscured
                                      ? eyeOffIcon
                                      : eyeIcon,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),

                    //button get code
                    BlocListener<ForgetPassBloc, ForgetPassState>(
                      listener: (context, state) {
                        if (state is ForgetPassLoaded) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            pushScreenWithoutNavBar(
                              context,
                              OtpScreen(
                                phoneNumber: phoneController.text,
                              ),
                            );
                          });
                        } else if (state is ForgetPassFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(AppLocalization.of(context)
                                      .getTransatedValues(
                                          state.statusCode == 602
                                              ? 'userExists'
                                              : state.statusCode == 603
                                                  ? 'otpinvalid'
                                                  : 'error') ??
                                  ''),
                            ),
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Button.textButton(
                          text: AppLocalization.of(context)
                                  .getTransatedValues('login') ??
                              '',
                          onTap: () {
                            if (phoneController.text.length != 8 ||
                                passController.text.length < 6) {
                              context.read<ValidateTextFieldBloc>().add(
                                    PhoneNumberChanged(
                                        phoneNumber: phoneController.text),
                                  );
                              context.read<ValidateTextFieldBloc>().add(
                                    PasswordChanged(
                                        passWord: passController.text),
                                  );
                            } else {
                              context.read<ForgetPassBloc>().add(
                                    ForgetPassSubmitted(
                                      phoneNumber:
                                          '+993${phoneController.text}',
                                      password: passController.text,
                                    ),
                                  );
                              context
                                  .read<ForgetPassBloc>()
                                  .add(ResetForgetPass());
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
