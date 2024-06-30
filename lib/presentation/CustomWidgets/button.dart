import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

enum ButtonStyle { iconButton, textButton }

class Button extends StatelessWidget {
  final double? width;
  final ButtonStyle buttonStyle;
  final String? title;
  final VoidCallback onTap;
  const Button({
    required this.buttonStyle,
    required this.onTap,
    this.width,
    this.title,
    super.key,
  });
  const Button._({
    required this.buttonStyle,
    this.width,
    this.title,
    required this.onTap,
  });
  factory Button.iconButton(final double width, final VoidCallback onTap) {
    return Button._(
      buttonStyle: ButtonStyle.iconButton,
      width: width,
      onTap: onTap,
    );
  }
  factory Button.textButton(final String text, final VoidCallback onTap) {
    return Button._(
      buttonStyle: ButtonStyle.textButton,
      title: text,
      onTap: onTap,
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
      color: AppColors.purpleColor,
      child: buttonStyle == ButtonStyle.iconButton
          ? SvgPicture.asset(
              shopIcon,
              colorFilter: ColorFilter.mode(
                AppColors.whiteColor,
                BlendMode.srcIn,
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
