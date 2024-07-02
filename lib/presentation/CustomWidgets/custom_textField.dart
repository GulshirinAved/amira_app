import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:flutter/material.dart';
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

  final TextEditingController? textController;
  const CustomTextField({
    required this.hintText,
    required this.needPrefix,
    this.textController,
    this.backgroundColor,
    this.onFieldSubmitted,
    this.onChanged,
    this.onTap,
    this.autofocus = false,
    this.textFieldStyle,
    super.key,
  });
  const CustomTextField._({
    required this.hintText,
    this.needPrefix,
    this.backgroundColor,
    this.onFieldSubmitted,
    this.onChanged,
    this.onTap,
    this.autofocus,
    this.textController,
    this.textFieldStyle,
  });
  factory CustomTextField.search({
    bool? autoFocus,
    VoidCallback? onTap,
    TextEditingController? controller,
    final Function(String)? onChanged,
  }) {
    return CustomTextField._(
      hintText: 'Поиск',
      needPrefix: true,
      autofocus: autoFocus ?? false,
      onTap: onTap,
      textController: controller,
      onChanged: onChanged,
    );
  }
  factory CustomTextField.normal({
    final String? hintText,
    Color? backColor,
    final Function(String)? onFieldSubmitted,
    TextEditingController? controller,
  }) {
    return CustomTextField._(
      hintText: hintText!,
      autofocus: false,
      backgroundColor: backColor ?? AppColors.whiteColor,
      needPrefix: false,
      onFieldSubmitted: onFieldSubmitted,
      textController: controller,
    );
  }
  factory CustomTextField.withUnderLine({
    final String? hintText,
    TextEditingController? controller,
    final Color? color,
  }) {
    return CustomTextField._(
      hintText: hintText!,
      autofocus: false,
      needPrefix: false,
      textController: controller,
      textFieldStyle: TextFieldStyle.withUnderLine,
      backgroundColor: Colors.transparent,
    );
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      autofocus: autofocus ?? false,
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
    );
  }
}
