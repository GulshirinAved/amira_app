import 'dart:developer';

import 'package:amira_app/app_localization.dart';
import 'package:amira_app/blocs/auth/register/register_bloc.dart';
import 'package:amira_app/blocs/auth/validateTextField/validate_text_field_bloc.dart';
import 'package:amira_app/blocs/register/selectGender/select_gender_cubit.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/constants.dart';
import 'package:amira_app/presentation/CustomWidgets/button.dart';
import 'package:amira_app/presentation/CustomWidgets/custom_textField.dart';
import 'package:amira_app/presentation/CustomWidgets/radio_button.dart';
import 'package:amira_app/presentation/Screens/auth/components/custom_textField.dart';
import 'package:amira_app/blocs/auth/passwordVisibility/password_obscure_cubit.dart';
import 'package:amira_app/presentation/Screens/auth/login_screen.dart';
import 'package:amira_app/presentation/Screens/auth/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController phoneController;
  late TextEditingController nameController;
  late TextEditingController addressController;
  late TextEditingController dateController;
  late TextEditingController passController;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    nameController = TextEditingController();
    addressController = TextEditingController();
    dateController = TextEditingController();
    passController = TextEditingController();
  }

  @override
  void dispose() {
    phoneController.dispose();
    nameController.dispose();
    addressController.dispose();
    dateController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ValidateTextFieldBloc(),
        ),
        BlocProvider(
          create: (context) => SelectGenderCubit(),
        ),
        BlocProvider(
          create: (context) => ObscureCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
      ],
      child: SafeArea(
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
                      rangeNumber: 8,
                      isPhone: true,
                      errorText: state.isPhoneValid
                          ? ''
                          : AppLocalization.of(context).getTransatedValues(
                                'errorPhone',
                              ) ??
                              '',
                      controller: phoneController,
                      onChanged: (value) {
                        context
                            .read<ValidateTextFieldBloc>()
                            .add(PhoneNumberChanged(phoneNumber: value ?? ''));
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
                //name
                BlocBuilder<ValidateTextFieldBloc, ValidateTextFieldState>(
                  builder: (context, state) {
                    return BaseTextField(
                      hintText: AppLocalization.of(context)
                              .getTransatedValues('name') ??
                          '',
                      topPadding: 15,
                      errorText: state.isNameValid
                          ? ''
                          : AppLocalization.of(context)
                                  .getTransatedValues('noName') ??
                              '',
                      controller: nameController,
                      onChanged: (value) {
                        context
                            .read<ValidateTextFieldBloc>()
                            .add(NameChanged(name: value ?? ''));
                        return null;
                      },
                      isTextNumber: false,
                      prefixWidget: const SizedBox.shrink(),
                    );
                  },
                ),
                //address
                BlocBuilder<ValidateTextFieldBloc, ValidateTextFieldState>(
                  builder: (context, state) {
                    return BaseTextField(
                      hintText: AppLocalization.of(context)
                              .getTransatedValues('address') ??
                          '',
                      topPadding: 15,
                      errorText: state.isAddressValid
                          ? ''
                          : AppLocalization.of(context)
                                  .getTransatedValues('noAddress') ??
                              '',
                      controller: addressController,
                      onChanged: (value) {
                        context
                            .read<ValidateTextFieldBloc>()
                            .add(AddressChanged(address: value ?? ''));
                        return null;
                      },
                      isTextNumber: false,
                      prefixWidget: const SizedBox.shrink(),
                    );
                  },
                ),
                //birthday
                BlocBuilder<ValidateTextFieldBloc, ValidateTextFieldState>(
                  builder: (context, state) {
                    return BaseTextField(
                      hintText: 'yyyy-MM-dd',
                      topPadding: 15,
                      errorText: state.isVerifyBirthdayValid
                          ? ''
                          : AppLocalization.of(context)
                                  .getTransatedValues('birthdayError') ??
                              '',
                      inputFormatters: [DateTextInputFormatter()],
                      controller: dateController,
                      rangeNumber: 8,
                      onChanged: (text) {
                        if (text!.length == 10) {
                          try {
                            final DateTime date =
                                DateFormat('yyyy-MM-dd').parseStrict(text);
                            dateController.text =
                                DateFormat('yyyy-MM-dd').format(date);
                            dateController.selection =
                                TextSelection.fromPosition(
                              TextPosition(
                                offset: dateController.text.length,
                              ),
                            );
                            return dateController.text;
                          } catch (e) {}
                          context
                              .read<ValidateTextFieldBloc>()
                              .add(BirthdayChanged(birthdayDate: text));
                        }
                        return null;
                      },
                      isTextNumber: true,
                      prefixWidget: const SizedBox.shrink(),
                    );
                  },
                ),
                BlocBuilder<ValidateTextFieldBloc, ValidateTextFieldState>(
                  builder: (context, state) {
                    return BlocBuilder<ObscureCubit, ObscureState>(
                      builder: (context, obscureState) {
                        return BaseTextField(
                          topPadding: 15,
                          rangeNumber: 8,
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
                            context
                                .read<ValidateTextFieldBloc>()
                                .add(PasswordChanged(passWord: value ?? ''));
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
                //gender selection
                BlocBuilder<SelectGenderCubit, String>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(
                        genderList.length,
                        (index) => Flexible(
                          fit: FlexFit.loose,
                          child: CustomRadioButton(
                            isRight: true,
                            title: AppLocalization.of(context)
                                    .getTransatedValues(genderList[index]) ??
                                '',
                            value: genderList[index],
                            groupValue: state == '' ? genderList[0] : state,
                            onChanged: (value) => context
                                .read<SelectGenderCubit>()
                                .selectGender(value ?? ''),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                //have acc button
                Align(
                  alignment: Alignment.topLeft,
                  child: text(
                    context,
                    title: 'haveAcc',
                    onTap: () {
                      pushScreenWithoutNavBar(context, const LoginScreen());
                    },
                  ),
                ),
                //button for register
                BlocListener<RegisterBloc, RegisterState>(
                  listener: (context, registerState) {
                    log(registerState.toString());
                    if (registerState is RegisterLoaded) {
                      log(registerState.statusCode.toString());
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        pushScreenWithoutNavBar(
                          context,
                          OtpScreen(
                            phoneNumber: phoneController.text,
                          ),
                        );
                      });
                    } else if (registerState is RegisterFailure) {
                      log('it is failure ${registerState.toString()}');

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            AppLocalization.of(context).getTransatedValues(
                                  registerState.statusCode == 602
                                      ? 'userExists'
                                      : registerState.statusCode == 603
                                          ? 'otpinvalid'
                                          : 'error',
                                ) ??
                                '',
                          ),
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<SelectGenderCubit, String>(
                    builder: (context, genderState) {
                      return Button.textButton(
                        text: AppLocalization.of(context)
                                .getTransatedValues('register') ??
                            '',
                        onTap: () {
                          log("""${phoneController.text.length != 8} ||
                              ${passController.text.length < 6} ||
                              ${nameController.text == ''}||
                              ${addressController.text == ''} ||
                              ${dateController.text.length != 10}""");
                          if (phoneController.text.length != 8 ||
                              passController.text.length < 6 ||
                              nameController.text == '' ||
                              addressController.text == '' ||
                              dateController.text.length != 10) {
                            context.read<ValidateTextFieldBloc>().add(
                                  PhoneNumberChanged(
                                    phoneNumber: phoneController.text,
                                  ),
                                );
                            context.read<ValidateTextFieldBloc>().add(
                                  PasswordChanged(
                                    passWord: passController.text,
                                  ),
                                );
                            context.read<ValidateTextFieldBloc>().add(
                                  NameChanged(
                                    name: nameController.text,
                                  ),
                                );
                            context.read<ValidateTextFieldBloc>().add(
                                  AddressChanged(
                                    address: addressController.text,
                                  ),
                                );
                            context.read<ValidateTextFieldBloc>().add(
                                  BirthdayChanged(
                                    birthdayDate: dateController.text,
                                  ),
                                );
                          } else {
                            context.read<RegisterBloc>().add(
                                  RegisterSubmitted(
                                    phoneNumber: '+993${phoneController.text}',
                                    password: passController.text,
                                    address: addressController.text,
                                    birthday: dateController.text,
                                    name: nameController.text,
                                    gender: genderState == ''
                                        ? genderList[0]
                                        : genderState,
                                  ),
                                );
                            context.read<RegisterBloc>().add(
                                  ResetRegister(),
                                );
                          }
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
