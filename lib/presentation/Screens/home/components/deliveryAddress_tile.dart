import 'package:amira_app/app_localization.dart';
import 'package:amira_app/blocs/addDeliveryLocation/location_add_bloc.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/constants.dart';
import 'package:amira_app/presentation/CustomWidgets/button.dart';
import 'package:amira_app/presentation/CustomWidgets/custom_textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DeliveryAddressTile extends StatefulWidget {
  const DeliveryAddressTile({super.key});

  @override
  State<DeliveryAddressTile> createState() => _DeliveryAddressTileState();
}

class _DeliveryAddressTileState extends State<DeliveryAddressTile> {
  late TextEditingController addressController;
  @override
  void initState() {
    super.initState();
    addressController = TextEditingController();
  }

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => addressDeliveryBottomSheet(context),
      selectedTileColor: AppColors.whiteColor,
      contentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset(mapPinIcon),
      title: BlocBuilder<LocationAddBloc, LocationAddState>(
        builder: (context, state) {
          return Text(
            state.savedLocation == ''
                ? AppLocalization.of(context)
                        .getTransatedValues('showDeliveryAddress') ??
                    ''
                : state.savedLocation,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: AppFonts.fontSize14,
              color: AppColors.blackColor,
            ),
          );
        },
      ),
      trailing: SvgPicture.asset(arrowRightIcon),
    );
  }

  //first bottomsheet
  Future<dynamic> addressDeliveryBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: AppColors.whiteColor,
      builder: (contextt) {
        return BlocProvider.value(
          value: BlocProvider.of<LocationAddBloc>(context),
          child: SizedBox(
            height: 200.h,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalization.of(context)
                          .getTransatedValues('deliveryAddress') ??
                      '',
                  style: TextStyle(
                    fontFamily: fontPeaceSans,
                    fontWeight: FontWeight.w400,
                    fontSize: AppFonts.fontSize22,
                  ),
                ),
                //botton for writing address
                GestureDetector(
                  onTap: () => bottomsheetSelectionAddress(context),
                  child: Container(
                    height: 44.h,
                    margin: const EdgeInsets.all(20),
                    padding: EdgeInsets.only(left: 16.w),
                    decoration: BoxDecoration(
                      color: AppColors.lightGreyColor,
                      borderRadius: AppBorders.borderRadius10,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalization.of(context)
                              .getTransatedValues('showStreetAndHouseNumber') ??
                          '',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: AppFonts.fontSize14,
                      ),
                    ),
                  ),
                ),
                //close button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Button.textButton(
                    text: AppLocalization.of(context)
                            .getTransatedValues('close') ??
                        '',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //second bottomsheet
  Future<dynamic> bottomsheetSelectionAddress(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: AppColors.whiteColor,
      showDragHandle: true,
      context: context,
      builder: (contextt) {
        return BlocProvider.value(
          value: BlocProvider.of<LocationAddBloc>(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalization.of(context)
                        .getTransatedValues('deliveryAddress') ??
                    '',
                style: TextStyle(
                  fontFamily: fontPeaceSans,
                  fontWeight: FontWeight.w400,
                  fontSize: AppFonts.fontSize22,
                ),
              ),
              //text fields for writing address
              BlocBuilder<LocationAddBloc, LocationAddState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomTextField.normal(
                      context: context,
                      controller: addressController,
                      hintText: AppLocalization.of(context).getTransatedValues(
                            'showStreetAndHouseNumber',
                          ) ??
                          '',
                      isTextNumber: false,
                      onFieldSubmitted: (value) {
                        context
                            .read<LocationAddBloc>()
                            .add(SaveAddressEvent(value));
                        context
                            .read<LocationAddBloc>()
                            .add(ShowSavedAddressEvent(value));
                      },
                      backColor: AppColors.lightGreyColor,
                    ),
                  );
                },
              ),
              // writen addreses
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: BlocBuilder<LocationAddBloc, LocationAddState>(
                  builder: (context, state) {
                    return SizedBox(
                      height: state.locationList.isNotEmpty ? 110.h : 0,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            context.read<LocationAddBloc>().add(
                                  SelectAddressEvent(
                                    state.locationList[index],
                                    index,
                                    state.locationList,
                                  ),
                                );
                          },
                          child: BlocBuilder<LocationAddBloc, LocationAddState>(
                            builder: (context, state) {
                              return Text(
                                state.locationList[index],
                                style: TextStyle(
                                  fontWeight: state.selectedIndex == index
                                      ? FontWeight.bold
                                      : FontWeight.w400,
                                  color: state.selectedIndex == index
                                      ? AppColors.purpleColor
                                      : AppColors.greyColor,
                                ),
                              );
                            },
                          ),
                        ),
                        separatorBuilder: (context, index) => Divider(
                          color: AppColors.greyColor,
                        ),
                        itemCount: state.locationList.length,
                      ),
                    );
                  },
                ),
              ),
              //save button
              Padding(
                padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: kBottomNavigationBarHeight)
                    .copyWith(top: 0),
                child: BlocBuilder<LocationAddBloc, LocationAddState>(
                  builder: (context, state) {
                    return Button.textButton(
                      text: AppLocalization.of(context).getTransatedValues(
                            'apply',
                          ) ??
                          '',
                      onTap: () {
                        context
                            .read<LocationAddBloc>()
                            .add(SaveAddressEvent(addressController.text));
                        context
                            .read<LocationAddBloc>()
                            .add(OnButtonPressedAddressEvent(
                              state.locationList[state.selectedIndex!],
                              state.locationList,
                            ));

                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
