import 'dart:developer';

import 'package:amira_app/blocs/auth/updateUserData/update_user_data_bloc.dart';
import 'package:amira_app/blocs/auth/userProfile/user_profile_bloc.dart';
import 'package:amira_app/blocs/auth/validateTextField/validate_text_field_bloc.dart';
import 'package:amira_app/presentation/CustomWidgets/animations.dart';
import 'package:amira_app/presentation/Screens/bottomNavBar/bottomNavBar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:amira_app/app_localization.dart';
import 'package:amira_app/blocs/register/selectGender/select_gender_cubit.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/constants.dart';
import 'package:amira_app/presentation/CustomWidgets/button.dart';
import 'package:amira_app/presentation/CustomWidgets/custom_textField.dart';
import 'package:amira_app/presentation/CustomWidgets/radio_button.dart';
import 'package:intl/intl.dart';

class PrivateDetailsScreen extends StatefulWidget {
  const PrivateDetailsScreen({
    super.key,
  });

  @override
  State<PrivateDetailsScreen> createState() => _PrivateDetailsScreenState();
}

class _PrivateDetailsScreenState extends State<PrivateDetailsScreen> {
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController birthdayController;
  late String? gender;
  late UserProfileBloc userBloc;

  @override
  void initState() {
    super.initState();
    userBloc = UserProfileBloc()..add(GetUserData());
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    birthdayController = TextEditingController();
  }

  @override
  void dispose() {
    userBloc.close();
    fullNameController.dispose();
    emailController.dispose();
    birthdayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SelectGenderCubit(),
        ),
        BlocProvider(
          create: (context) => ValidateTextFieldBloc(),
        ),
        BlocProvider(
          create: (context) => UpdateUserDataBloc(),
        ),
        BlocProvider.value(
          value: userBloc,
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<UserProfileBloc, UserProfileState>(
            builder: (context, state) {
              if (state is UserProfileLoaded) {
                fullNameController.text = state.userData?.name ?? '';
                emailController.text = state.userData?.email ?? '';
                gender = state.userData?.gender ?? genderList[0];
                birthdayController.text = state.userData?.birthday == null
                    ? ''
                    : DateFormat('yyyy-MM-dd')
                        .format(DateTime.parse(state.userData!.birthday!));
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                    children: [
                      // Image
                      Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          appLogoImage,
                          height: 90.h,
                          width: 89.w,
                        ),
                      ),
                      // Text enter phone
                      Padding(
                        padding: const EdgeInsets.only(top: 40, bottom: 10),
                        child: Text(
                          AppLocalization.of(context)
                                  .getTransatedValues('privateDetails') ??
                              '',
                          style: TextStyle(
                            fontFamily: fontPeaceSans,
                            fontSize: AppFonts.fontSize22,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),

                      CustomTextField.normal(
                        context: context,
                        controller: fullNameController,
                        isTextNumber: false,
                        hintText: AppLocalization.of(context)
                                .getTransatedValues('fullName') ??
                            '',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: CustomTextField.normal(
                          controller: emailController,
                          context: context,
                          hintText: AppLocalization.of(context)
                                  .getTransatedValues('post') ??
                              '',
                        ),
                      ),
                      BlocBuilder<ValidateTextFieldBloc,
                          ValidateTextFieldState>(
                        builder: (context, state) {
                          return CustomTextField.normal(
                            context: context,
                            controller: birthdayController,
                            inputFormatters: [DateTextInputFormatter()],
                            rangeNumber: 8,
                            hintText:
                                'yyyy-MM-dd ${AppLocalization.of(context).getTransatedValues('birthData') ?? ''}',
                            onChanged: (text) {
                              if (text.length == 10) {
                                try {
                                  final DateTime date = DateFormat('yyyy-MM-dd')
                                      .parseStrict(text);
                                  birthdayController.text =
                                      DateFormat('yyyy-MM-dd').format(date);
                                  birthdayController.selection =
                                      TextSelection.fromPosition(
                                    TextPosition(
                                      offset: birthdayController.text.length,
                                    ),
                                  );
                                } catch (e) {}
                                context
                                    .read<ValidateTextFieldBloc>()
                                    .add(BirthdayChanged(birthdayDate: text));
                              }
                            },
                          );
                        },
                      ),
                      // Gender selection
                      BlocBuilder<UserProfileBloc, UserProfileState>(
                        builder: (context, userState) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                Text(
                                  AppLocalization.of(context)
                                          .getTransatedValues('gender') ??
                                      '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: AppFonts.fontSize14,
                                    color: AppColors.greyColor,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: BlocBuilder<SelectGenderCubit, String>(
                                    builder: (context, state) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: List.generate(
                                          genderList.length,
                                          (index) => Flexible(
                                            fit: FlexFit.loose,
                                            child: CustomRadioButton(
                                              isRight: true,
                                              title: AppLocalization.of(context)
                                                      .getTransatedValues(
                                                    genderList[index],
                                                  ) ??
                                                  '',
                                              value: genderList[index],
                                              groupValue:
                                                  state == '' ? gender! : state,
                                              onChanged: (value) => context
                                                  .read<SelectGenderCubit>()
                                                  .selectGender(value ?? ''),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      BlocListener<UpdateUserDataBloc, UpdateUserDataState>(
                        listener: (context, state) {
                          log('it is update userbloc ${state}s');
                          if (state is UpdateUserDataFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  AppLocalization.of(context)
                                          .getTransatedValues('error') ??
                                      '',
                                ),
                              ),
                            );
                          } else if (state is UpdateUserDataLoaded) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BottomNavBar(),
                              ),
                              (route) => false,
                            );
                          }
                        },
                        child: BlocBuilder<SelectGenderCubit, String>(
                          builder: (context, state) {
                            return Button.textButton(
                              text: AppLocalization.of(context)
                                  .getTransatedValues('startShopping'),
                              onTap: () {
                                if (fullNameController.text == '') {
                                  context.read<ValidateTextFieldBloc>().add(
                                        NameChanged(
                                          name: fullNameController.text,
                                        ),
                                      );
                                } else {
                                  context.read<UpdateUserDataBloc>().add(
                                        UpdateUserDataSubmitted(
                                          name: fullNameController.text,
                                          birthday: birthdayController.text,
                                          email: emailController.text,
                                          gender: state,
                                        ),
                                      );
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Animations.loading;
              }
            },
          ),
        ),
      ),
    );
  }
}
