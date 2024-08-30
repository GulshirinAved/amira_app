import 'package:amira_app/app_localization.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

enum TextFieldStyle { search, withUnderLine, normal }

class CustomTextField extends StatelessWidget {
  final String hintText;

  final int? needPrefix;
  final Color? backgroundColor;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final bool? autofocus;
  final TextFieldStyle? textFieldStyle;
  final BuildContext context;
  final bool? isTextNumber;
  final TextEditingController? textController;
  final int? rangeNumber;
  final bool? textCenterAlign;
  final Color? borderColor;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixWidget;
  final FocusNode? focusNode;
  final bool? readOnly;
  final bool? isObscure;

  const CustomTextField({
    required this.hintText,
    required this.needPrefix,
    required this.context,
    this.textController,
    this.backgroundColor,
    this.onFieldSubmitted,
    this.onChanged,
    this.onTap,
    this.autofocus = false,
    this.textFieldStyle,
    this.isTextNumber = false,
    this.rangeNumber,
    this.textCenterAlign = false,
    this.borderColor,
    this.inputFormatters,
    this.isObscure,
    this.suffixWidget,
    this.focusNode,
    this.readOnly,
    super.key,
  });
  const CustomTextField._({
    required this.hintText,
    required this.context,
    this.needPrefix,
    this.backgroundColor,
    this.onFieldSubmitted,
    this.onChanged,
    this.onTap,
    this.autofocus,
    this.textController,
    this.textFieldStyle,
    this.isTextNumber,
    this.rangeNumber,
    this.textCenterAlign,
    this.borderColor,
    this.inputFormatters,
    this.isObscure,
    this.suffixWidget,
    this.readOnly,
    this.focusNode,
  });
  factory CustomTextField.search({
    required final BuildContext context,
    bool? autoFocus,
    VoidCallback? onTap,
    TextEditingController? controller,
    final Function(String)? onChanged,
    final Function(String?)? onFieldSubmitted,
  }) {
    return CustomTextField._(
      hintText: AppLocalization.of(context).getTransatedValues('search') ?? '',
      needPrefix: 1,
      autofocus: autoFocus ?? false,
      onTap: onTap,
      textController: controller,
      onChanged: onChanged,
      context: context,
      isTextNumber: false,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
  factory CustomTextField.normal(
      {required final BuildContext context,
      required String hintText,
      Color? backColor,
      final Function(String)? onFieldSubmitted,
      final Function(String)? onChanged,
      TextEditingController? controller,
      final bool? isTextNumber,
      final bool? isObscure,
      final int? rangeNumber,
      final int? needPrefix,
      final bool? textCenterAlign,
      final Color? borderColor,
      final FocusNode? focusNode,
      final List<TextInputFormatter>? inputFormatters,
      final Widget? suffixWidget,
      final bool? readnly}) {
    return CustomTextField._(
      hintText: hintText,
      autofocus: false,
      readOnly: readnly,
      backgroundColor: backColor ?? AppColors.whiteColor,
      needPrefix: needPrefix,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      textController: controller,
      context: context,
      isTextNumber: isTextNumber,
      rangeNumber: rangeNumber,
      textCenterAlign: textCenterAlign,
      borderColor: borderColor,
      inputFormatters: inputFormatters,
      isObscure: isObscure,
      suffixWidget: suffixWidget,
      focusNode: focusNode,
    );
  }

  @override
  Widget build(BuildContext context) {
    //needPrefix 1 is prefix icon,if 2 is null, if 3 is +993
    return TextFormField(
      readOnly: readOnly ?? false,
      obscureText: isObscure ?? false,
      cursorColor: AppColors.purpleColor,
      controller: textController,
      autofocus: autofocus ?? false,
      textAlign: textCenterAlign == true ? TextAlign.center : TextAlign.start,
      focusNode: focusNode,
      keyboardType:
          isTextNumber == true ? TextInputType.phone : TextInputType.text,
      inputFormatters: inputFormatters != []
          ? inputFormatters
          : rangeNumber == null
              ? []
              : [LengthLimitingTextInputFormatter(rangeNumber)],
      decoration: needPrefix == 3
          ? const InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            )
          : InputDecoration(
              border: textFieldStyle == TextFieldStyle.withUnderLine
                  ? const UnderlineInputBorder()
                  : OutlineInputBorder(
                      borderRadius: AppBorders.borderRadius10,
                      borderSide: borderColor == null
                          ? BorderSide.none
                          : BorderSide(color: borderColor!),
                    ),
              enabledBorder: textFieldStyle == TextFieldStyle.withUnderLine
                  ? const UnderlineInputBorder()
                  : OutlineInputBorder(
                      borderRadius: AppBorders.borderRadius10,
                      borderSide: borderColor == null
                          ? BorderSide.none
                          : BorderSide(
                              color: borderColor ?? AppColors.purpleColor),
                    ),
              focusedBorder: textFieldStyle == TextFieldStyle.withUnderLine
                  ? const UnderlineInputBorder()
                  : OutlineInputBorder(
                      borderRadius: AppBorders.borderRadius10,
                      borderSide: BorderSide(
                          color: borderColor ?? AppColors.purpleColor),
                    ),
              filled: true,
              fillColor: backgroundColor ?? AppColors.whiteColor,
              prefixIcon: needPrefix == 1
                  ? SvgPicture.asset(searchIcon, fit: BoxFit.scaleDown)
                  : null,
              suffixIcon: suffixWidget,
              hintText: hintText,
              hintStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: AppFonts.fontSize14,
                color: AppColors.greyColor,
              ),
            ),
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      onTapOutside: (event) => FocusScope.of(context).requestFocus(FocusNode()),
    );
  }
}

class DateTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Removing any character that isn't a number
    final newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    final textLength = newText.length;

    String formattedText = '';

    if (textLength >= 1) {
      formattedText += newText.substring(0, textLength.clamp(0, 4));
    }
    if (textLength >= 5) {
      formattedText += '-' + newText.substring(4, textLength.clamp(4, 6));
    }
    if (textLength >= 7) {
      formattedText += '-' + newText.substring(6, textLength.clamp(6, 8));
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
