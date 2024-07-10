import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/presentation/CustomWidgets/button.dart';
import 'package:amira_app/presentation/CustomWidgets/custom_textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Login'),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: CustomTextField.normal(
                    context: context,
                    backColor: AppColors.whiteColor,
                    hintText: '+993000004',
                    isTextNumber: true,
                  ),
                ),
                CustomTextField.normal(
                  context: context,
                  backColor: AppColors.whiteColor,
                  hintText: 'password',
                  isTextNumber: true,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Button.textButton(
                        backColor: AppColors.purpleColor,
                        text: 'Ulgama girmek',
                        onTap: () {},
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Button.textButton(
                        backColor: AppColors.purpleColor,
                        text: 'Agza bolmak',
                        onTap: () {},
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
