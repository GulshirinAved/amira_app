import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchField extends StatelessWidget {
  final String hintText;
  final bool? needPrefix;
  final Color? backgroundColor;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final bool? autofocus;

  final TextEditingController? textController;
  const SearchField({
    required this.hintText,
    required this.needPrefix,
    this.textController,
    this.backgroundColor,
    this.onFieldSubmitted,
    this.onChanged,
    this.onTap,
    this.autofocus = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      autofocus: autofocus!,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: AppBorders.borderRadius10,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
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
