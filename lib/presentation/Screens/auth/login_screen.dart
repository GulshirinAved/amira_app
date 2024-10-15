// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:amira_app/blocs/auth/login/login_bloc.dart';
import 'package:amira_app/blocs/auth/validateTextField/validate_text_field_bloc.dart';
import 'package:amira_app/presentation/CustomWidgets/custom_checkBox.dart';
import 'package:amira_app/presentation/Screens/auth/components/custom_textField.dart';
import 'package:amira_app/blocs/auth/passwordVisibility/password_obscure_cubit.dart';
import 'package:amira_app/presentation/Screens/auth/forgetPass_screen.dart';
import 'package:amira_app/presentation/Screens/auth/register_screen.dart';
import 'package:amira_app/presentation/Screens/bottomNavBar/bottomNavBar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:amira_app/app_localization.dart';
import 'package:amira_app/blocs/register/checkAgreement/check_agreement_cubit.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/constants.dart';
import 'package:amira_app/presentation/CustomWidgets/button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CheckAgreementCubit(),
        ),
        BlocProvider(
          create: (context) => ValidateTextFieldBloc(),
        ),
        BlocProvider(
          create: (context) => ObscureCubit(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
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
                          isPhone: true,
                          errorText: state.isPhoneValid
                              ? ''
                              : AppLocalization.of(context).getTransatedValues(
                                    'errorPhone',
                                  ) ??
                                  '',
                          rangeNumber: 8,
                          controller: phoneController,
                          onChanged: (value) {
                            context.read<ValidateTextFieldBloc>().add(
                                  PhoneNumberChanged(phoneNumber: value ?? ''),
                                );
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
                    //password
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
                              controller: passwordController,
                              onChanged: (value) {
                                context.read<ValidateTextFieldBloc>().add(
                                      PasswordChanged(passWord: value ?? ''),
                                    );
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: text(
                              context,
                              title: 'noAcc',
                              onTap: () {
                                pushScreenWithoutNavBar(
                                  context,
                                  const RegisterScreen(),
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: text(
                              context,
                              title: 'forgetPass',
                              onTap: () {
                                pushScreenWithoutNavBar(
                                  context,
                                  const ForgetPassScreen(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    //button get code
                    BlocListener<LoginBloc, LoginState>(
                      listener: (context, state) {
                        log('it is loginstate $state');
                        if (state is LoginLoaded) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            pushReplacementWithNavBar(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BottomNavBar(),
                              ),
                            );
                          });
                        } else if (state is LoginFailure) {
                          log(state.statusCode.toString());
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalization.of(context).getTransatedValues(
                                      state.statusCode == 602
                                          ? 'userExists'
                                          : state.statusCode == 603
                                              ? 'otpinvalid'
                                              : state.statusCode == 601
                                                  ? 'wrongPass'
                                                  : 'pass',
                                    ) ??
                                    '',
                              ),
                            ),
                          );
                        }
                      },
                      child: Button.textButton(
                        text: AppLocalization.of(context)
                                .getTransatedValues('login') ??
                            '',
                        onTap: () {
                          if (phoneController.text.length != 8 ||
                              passwordController.text.length < 6) {
                            context.read<ValidateTextFieldBloc>().add(
                                  PhoneNumberChanged(
                                    phoneNumber: phoneController.text,
                                  ),
                                );
                            context.read<ValidateTextFieldBloc>().add(
                                  PasswordChanged(
                                    passWord: passwordController.text,
                                  ),
                                );
                          } else {
                            context.read<LoginBloc>().add(
                                  LoginSubmitted(
                                    phoneNumber: '+993${phoneController.text}',
                                    password: passwordController.text,
                                  ),
                                );
                            context.read<LoginBloc>().add(const ResetLogin());
                          }
                        },
                      ),
                    ),
                    //agree for let you know about news
                    BlocBuilder<CheckAgreementCubit, bool>(
                      builder: (context, state) {
                        return CustomCheckBox(
                          value: state,
                          title: AppLocalization.of(context)
                                  .getTransatedValues('agreeForGettingNews') ??
                              '',
                          onChanged: (value) {
                            context.read<CheckAgreementCubit>().toggleCheck();
                          },
                        );
                      },
                    ),
                    AppLocalization.of(context).locale == 'tr'
                        ? russianText()
                        : turkmenText(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Text turkmenText() {
    return Text.rich(
      TextSpan(
        text: 'Hasaba girmegi dowam etdirmek bilen,',
        style: TextStyle(
          color: AppColors.greyColor,
          fontWeight: FontWeight.w500,
          fontSize: AppFonts.fontSize14,
        ),
        children: [
          TextSpan(
            text: 'gizlinlik ýörelgelerine, hyzmat şertlerine',
            style: TextStyle(
              color: AppColors.purple2Color,
              fontWeight: FontWeight.w500,
              fontSize: AppFonts.fontSize14,
            ),
          ),
          TextSpan(
            text: ' we ',
            style: TextStyle(
              color: AppColors.greyColor,
              fontWeight: FontWeight.w500,
              fontSize: AppFonts.fontSize14,
            ),
          ),
          TextSpan(
            text: 'haryt satuw şertlerine razy bolýarsyňyz',
            style: TextStyle(
              color: AppColors.purple2Color,
              fontWeight: FontWeight.w500,
              fontSize: AppFonts.fontSize14,
            ),
          ),
        ],
      ),
    );
  }

  Text russianText() {
    return Text.rich(
      TextSpan(
        text: 'Продолжая авторизацию, вы соглашаетесь с',
        style: TextStyle(
          color: AppColors.greyColor,
          fontWeight: FontWeight.w500,
          fontSize: AppFonts.fontSize14,
        ),
        children: [
          TextSpan(
            text: 'политикой конфиденциальности, условиями сервиса',
            style: TextStyle(
              color: AppColors.purple2Color,
              fontWeight: FontWeight.w500,
              fontSize: AppFonts.fontSize14,
            ),
          ),
          TextSpan(
            text: ' и ',
            style: TextStyle(
              color: AppColors.greyColor,
              fontWeight: FontWeight.w500,
              fontSize: AppFonts.fontSize14,
            ),
          ),
          TextSpan(
            text: 'условиями продажи товаров',
            style: TextStyle(
              color: AppColors.purple2Color,
              fontWeight: FontWeight.w500,
              fontSize: AppFonts.fontSize14,
            ),
          ),
        ],
      ),
    );
  }
}

Widget text(BuildContext context, {VoidCallback? onTap, String? title}) {
  return GestureDetector(
    onTap: onTap,
    child: Text(
      AppLocalization.of(context).getTransatedValues(title!) ?? '',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.greyColor,
        fontSize: AppFonts.fontSize14,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
