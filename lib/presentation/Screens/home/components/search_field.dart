import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: AppBorders.borderRadius10,
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: AppColors.whiteColor,
        prefixIcon: SvgPicture.asset(
          searchIcon,
          fit: BoxFit.scaleDown,
        ),
        hintText: 'Поиск',
        hintStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: AppFonts.fontSize14,
          color: AppColors.greyColor,
        ),
      ),
    );
  }
}
