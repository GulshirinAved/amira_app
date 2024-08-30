import 'package:amira_app/app_localization.dart';
import 'package:amira_app/blocs/profile/expandDropDown/expand_drop_down_cubit.dart';

import 'package:amira_app/presentation/CustomWidgets/customContainer_extension.dart';
import 'package:amira_app/presentation/CustomWidgets/custom_appbar.dart';
import 'package:amira_app/presentation/Screens/profile/components/language_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExpandDropDownCubit(),
      child: Scaffold(
        appBar: CustomAppBar(
          topTitle:
              AppLocalization.of(context).getTransatedValues('settings') ?? '',
        ),
        body: CustomContainer.buildContainer(
          width: double.infinity,
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(20),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LanguageTile(),
            ],
          ),
        ),
      ),
    );
  }
}
