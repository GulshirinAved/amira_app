// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amira_app/config/theme/constants.dart';
import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  final String title;
  final String value;
  final String groupValue;
  final Function(String?)? onChanged;
  final bool? isRight;
  const CustomRadioButton({
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.isRight = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      controlAffinity: isRight == false
          ? ListTileControlAffinity.trailing
          : ListTileControlAffinity.leading,
      dense: true,
      visualDensity: VisualDensity.compact,
      activeColor: AppColors.purpleColor,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: AppFonts.fontSize12,
        ),
      ),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }
}
