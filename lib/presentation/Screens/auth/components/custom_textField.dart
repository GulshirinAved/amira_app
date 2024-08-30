import 'package:amira_app/config/theme/constants.dart';
import 'package:amira_app/presentation/CustomWidgets/custom_textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseTextField extends StatelessWidget {
  final String hintText;
  final String errorText;
  final TextEditingController controller;
  final String? Function(String?)? onChanged;
  final Widget? prefixWidget;
  final bool? isTextNumber;
  final List<TextInputFormatter>? inputFormatters;
  final int? rangeNumber;
  final bool? isPhone;
  final double? topPadding;
  final Widget? suffixWidget;
  final bool? isObscure;
  final Color? backColor;
  final Color? borderColor;
  final bool? readOnly;

  const BaseTextField({
    required this.hintText,
    required this.errorText,
    required this.controller,
    required this.onChanged,
    this.prefixWidget,
    this.isTextNumber,
    this.inputFormatters,
    this.rangeNumber,
    this.isPhone = false,
    this.topPadding,
    this.suffixWidget,
    this.isObscure = false,
    this.backColor,
    this.borderColor,
    this.readOnly,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding ?? 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isPhone == true
              ? Container(
                  height: 44.h,
                  padding: const EdgeInsets.only(left: 7),
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: AppBorders.borderRadius10,
                    border: Border.all(
                      color: AppColors.purple2Color,
                    ),
                  ),
                  child: Row(
                    children: [
                      prefixWidget!,
                      Expanded(
                        child: CustomTextField.normal(
                          hintText: hintText,
                          context: context,
                          needPrefix: 3,
                          rangeNumber: rangeNumber,
                          isTextNumber: isTextNumber,
                          controller: controller,
                          onChanged: onChanged,
                          inputFormatters: inputFormatters,
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox(
                  height: 44.h,
                  child: CustomTextField.normal(
                    hintText: hintText,
                    context: context,
                    isObscure: isObscure,
                    needPrefix: 2,
                    borderColor: borderColor ?? AppColors.purple2Color,
                    rangeNumber: rangeNumber,
                    isTextNumber: isTextNumber,
                    controller: controller,
                    onChanged: onChanged,
                    inputFormatters: inputFormatters,
                    suffixWidget: suffixWidget,
                    backColor: backColor,
                    readnly: readOnly ?? false,
                  ),
                ),
          if (errorText.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 8),
              child: Text(
                errorText,
                style: TextStyle(color: AppColors.redColor),
              ),
            ),
        ],
      ),
    );
  }
}
