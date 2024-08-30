import 'package:amira_app/config/theme/constants.dart';
import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final bool? value;
  final String? title;
  final Function(bool?)? onChanged;
  const CustomCheckBox({
    super.key,
    this.value,
    this.title,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      tileColor: Colors.transparent,
      checkColor: AppColors.whiteColor,
      fillColor: WidgetStatePropertyAll(
        value ?? false ? AppColors.purpleColor : AppColors.whiteColor,
      ),
      checkboxShape: RoundedRectangleBorder(
        side: BorderSide(
          color: value ?? false ? AppColors.purpleColor : AppColors.grey1Color,
        ),
      ),
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
      dense: true,
      value: value ?? false,
      title: Text(
        title ?? '',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: AppFonts.fontSize14,
          color: AppColors.blackColor,
        ),
      ),
      onChanged: onChanged,
    );
  }
}
