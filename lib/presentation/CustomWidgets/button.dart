import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum ButtonStyle { iconButton, textButton }

class Button extends StatelessWidget {
  final double? width;
  final ButtonStyle buttonStyle;
  final String? title;
  final VoidCallback? onTap;
  final Color? backColor;
  const Button({
    required this.buttonStyle,
    required this.onTap,
    this.width,
    this.title,
    this.backColor,
    super.key,
  });
  const Button._({
    required this.buttonStyle,
    required this.onTap,
    this.width,
    this.title,
    this.backColor,
  });
  factory Button.iconButton({final double? width, final VoidCallback? onTap}) {
    return Button._(
      buttonStyle: ButtonStyle.iconButton,
      width: width,
      onTap: onTap,
    );
  }
  factory Button.textButton({
    final String? text,
    final VoidCallback? onTap,
    final Color? backColor,
  }) {
    return Button._(
      buttonStyle: ButtonStyle.textButton,
      title: text,
      onTap: onTap,
      backColor: backColor ?? AppColors.purpleColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: width ?? MediaQuery.of(context).size.width,
      onPressed: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: AppBorders.borderRadius10,
      ),
      color: backColor ?? AppColors.purpleColor,
      child: buttonStyle == ButtonStyle.iconButton
          ? GestureDetector(
              onTap: onTap,
              child: SvgPicture.asset(
                shopIcon,
                colorFilter: ColorFilter.mode(
                  AppColors.whiteColor,
                  BlendMode.srcIn,
                ),
              ),
            )
          : Text(
              title!,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: AppFonts.fontSize14,
                color: AppColors.lightPurpleColor,
              ),
            ),
    );
  }
}
