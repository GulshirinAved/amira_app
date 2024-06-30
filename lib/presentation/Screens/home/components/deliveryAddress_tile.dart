import 'package:amira_app/blocs/addDeliveryLocation/location_add_bloc.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/presentation/CustomWidgets/button.dart';
import 'package:amira_app/presentation/Screens/home/components/search_field.dart';
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
            state.savedLocation,
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
                  'Адрес доставки',
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
                      'Введите улицу и номер дома',
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
                  child: Button.textButton('Закрыть', () {
                    Navigator.pop(context);
                  }),
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
          child: SizedBox(
            height: 300.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Адрес доставки',
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
                      child: SearchField(
                        textController: addressController,
                        needPrefix: false,
                        hintText: 'Введите улицу и номер дома',
                        backgroundColor: AppColors.lightGreyColor,
                        onFieldSubmitted: (value) {
                          context
                              .read<LocationAddBloc>()
                              .add(SaveAddressEvent(value));
                          context
                              .read<LocationAddBloc>()
                              .add(ShowSavedAddressEvent(value));
                        },
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
                        height: 110.h,
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
                            child:
                                BlocBuilder<LocationAddBloc, LocationAddState>(
                              builder: (context, state) {
                                return Text(
                                  state.locationList[index],
                                  style: TextStyle(
                                    fontWeight: state.selectedIndex == index
                                        ? FontWeight.w800
                                        : FontWeight.w400,
                                    color: state.selectedIndex == index
                                        ? AppColors.purpleColor
                                        : AppColors.blackColor,
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
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: BlocBuilder<LocationAddBloc, LocationAddState>(
                    builder: (context, state) {
                      return Button.textButton(
                        'Применить',
                        () {
                          context.read<LocationAddBloc>().add(
                                OnButtonPressedAddressEvent(
                                  state.locationList[state.selectedIndex!],
                                  state.locationList,
                                ),
                              );

                          Navigator.pop(context);
                        },
                      );
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
}
