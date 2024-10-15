import 'package:amira_app/app_localization.dart';
import 'package:amira_app/blocs/auth/changePass/change_pass_bloc.dart';
import 'package:amira_app/blocs/auth/passwordVisibility/password_obscure_cubit.dart';
import 'package:amira_app/blocs/auth/validateTextField/validate_text_field_bloc.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/presentation/CustomWidgets/button.dart';
import 'package:amira_app/presentation/Screens/auth/components/custom_textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ChnagePassScreen extends StatefulWidget {
  const ChnagePassScreen({super.key});

  @override
  State<ChnagePassScreen> createState() => _ChnagePassScreenState();
}

class _ChnagePassScreenState extends State<ChnagePassScreen> {
  late TextEditingController oldPassController;
  late TextEditingController newPassController;
  @override
  void initState() {
    super.initState();
    oldPassController = TextEditingController();
    newPassController = TextEditingController();
  }

  @override
  void dispose() {
    oldPassController.dispose();
    newPassController.dispose();
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
          create: (context) => ObscureCubit(),
        ),
        BlocProvider(
          create: (context) => ChangePassBloc(),
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
                              controller: oldPassController,
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
                    BlocBuilder<ValidateTextFieldBloc, ValidateTextFieldState>(
                      builder: (context, state) {
                        return BlocBuilder<ObscureCubit, ObscureState>(
                          builder: (context, obscureState) {
                            return BaseTextField(
                              rangeNumber: 8,
                              topPadding: 15,
                              hintText: AppLocalization.of(context)
                                      .getTransatedValues('newPass') ??
                                  '',
                              errorText: state.isNewPassValid
                                  ? ''
                                  : AppLocalization.of(context)
                                          .getTransatedValues('errorPass') ??
                                      '',
                              controller: newPassController,
                              onChanged: (value) {
                                context.read<ValidateTextFieldBloc>().add(
                                      NewPasswordChanged(
                                        newPassWord: value ?? '',
                                      ),
                                    );
                                return null;
                              },
                              isTextNumber: false,
                              prefixWidget: const SizedBox.shrink(),
                              isObscure: obscureState.isNewPassObscured,
                              suffixWidget: GestureDetector(
                                onTap: () {
                                  context
                                      .read<ObscureCubit>()
                                      .toggleNewPasswordObscure();
                                },
                                child: SvgPicture.asset(
                                  obscureState.isNewPassObscured!
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
                    BlocListener<ChangePassBloc, ChangePassState>(
                      listener: (context, state) {
                        if (state is ChangePassLoaded) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.pop(context);
                          });
                        } else if (state is ChangePassFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalization.of(context).getTransatedValues(
                                      'error',
                                    ) ??
                                    '',
                              ),
                            ),
                          );
                        }
                      },
                      child: Button.textButton(
                        text: AppLocalization.of(context)
                                .getTransatedValues('changePass') ??
                            '',
                        onTap: () {
                          if (newPassController.text.length < 6 ||
                              oldPassController.text.length < 6 ||
                              oldPassController.text ==
                                  newPassController.text) {
                            context.read<ValidateTextFieldBloc>().add(
                                  NewPasswordChanged(
                                    newPassWord: newPassController.text,
                                  ),
                                );
                            context.read<ValidateTextFieldBloc>().add(
                                  PasswordChanged(
                                    passWord: oldPassController.text,
                                  ),
                                );
                          } else {
                            context.read<ChangePassBloc>().add(
                                  ChangePassSubmitted(
                                    oldPassword: oldPassController.text,
                                    newPassword: newPassController.text,
                                  ),
                                );
                            context
                                .read<ChangePassBloc>()
                                .add(const ResetPass());
                          }
                        },
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
