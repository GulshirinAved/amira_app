import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DeliveryAddressTile extends StatelessWidget {
  const DeliveryAddressTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selectedTileColor: AppColors.whiteColor,
      contentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset(mapPinIcon),
      title: Text(
        'Укажите место доставки',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: AppFonts.fontSize14,
          color: AppColors.blackColor,
        ),
      ),
      trailing: SvgPicture.asset(arrowRightIcon),
    );
  }
}
