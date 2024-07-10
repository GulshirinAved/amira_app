import 'package:amira_app/app_localization.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

enum TextFieldStyle { search, withUnderLine, normal }

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool? needPrefix;
  final Color? backgroundColor;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final bool? autofocus;
  final TextFieldStyle? textFieldStyle;
  final BuildContext context;
  final bool? isTextNumber;
  final TextEditingController? textController;
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
  });
  factory CustomTextField.search({
    required final BuildContext context,
    bool? autoFocus,
    VoidCallback? onTap,
    TextEditingController? controller,
    final Function(String)? onChanged,
  }) {
    return CustomTextField._(
      hintText: AppLocalization.of(context).getTransatedValues('search') ?? '',
      needPrefix: true,
      autofocus: autoFocus ?? false,
      onTap: onTap,
      textController: controller,
      onChanged: onChanged,
      context: context,
      isTextNumber: false,
    );
  }
  factory CustomTextField.normal({
    required final BuildContext context,
    final String? hintText,
    Color? backColor,
    final Function(String)? onFieldSubmitted,
    TextEditingController? controller,
    final bool? isTextNumber,
    final bool? isObscure,
  }) {
    return CustomTextField._(
      hintText: hintText!,
      autofocus: false,
      backgroundColor: backColor ?? AppColors.whiteColor,
      needPrefix: false,
      onFieldSubmitted: onFieldSubmitted,
      textController: controller,
      context: context,
      isTextNumber: isTextNumber,
    );
  }
  factory CustomTextField.withUnderLine({
    required final BuildContext context,
    final String? hintText,
    TextEditingController? controller,
    final Color? color,
    final bool? isTextNumber,
  }) {
    return CustomTextField._(
      hintText: hintText!,
      autofocus: false,
      needPrefix: false,
      context: context,
      textController: controller,
      textFieldStyle: TextFieldStyle.withUnderLine,
      backgroundColor: Colors.transparent,
      isTextNumber: isTextNumber,
    );
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      autofocus: autofocus ?? false,
      keyboardType:
          isTextNumber == true ? TextInputType.phone : TextInputType.text,
      decoration: InputDecoration(
        border: textFieldStyle == TextFieldStyle.withUnderLine
            ? const UnderlineInputBorder()
            : OutlineInputBorder(
                borderRadius: AppBorders.borderRadius10,
                borderSide: BorderSide.none,
              ),
        focusedBorder: textFieldStyle == TextFieldStyle.withUnderLine
            ? const UnderlineInputBorder()
            : OutlineInputBorder(
                borderRadius: AppBorders.borderRadius10,
                borderSide: BorderSide(color: AppColors.purpleColor),
              ),
        filled: true,
        fillColor: backgroundColor ?? AppColors.whiteColor,
        prefixIcon: needPrefix == false
            ? null
            : SvgPicture.asset(
                searchIcon,
                fit: BoxFit.scaleDown,
              ),
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
      onTapOutside: (event) =>
          FocusScope.of(context).requestFocus(new FocusNode()),
    );
  }
}
