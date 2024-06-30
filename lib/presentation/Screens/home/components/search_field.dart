import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchField extends StatelessWidget {
  final String hintText;
  final bool? needPrefix;
  final Color? backgroundColor;
  final Function(String)? onFieldSubmitted;
  final TextEditingController textController;
  const SearchField({
    required this.hintText,
    required this.needPrefix,
    required this.onFieldSubmitted,
    required this.textController,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: AppBorders.borderRadius10,
          borderSide: BorderSide.none,
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
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
