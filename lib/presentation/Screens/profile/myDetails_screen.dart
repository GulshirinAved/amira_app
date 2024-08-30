import 'package:amira_app/app_localization.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/constants.dart';
import 'package:amira_app/data/api_providers/auth_provider.dart';
import 'package:amira_app/presentation/CustomWidgets/customContainer_extension.dart';
import 'package:amira_app/presentation/CustomWidgets/custom_appbar.dart';
import 'package:amira_app/presentation/Screens/profile/changePass_screen.dart';
import 'package:amira_app/presentation/Screens/profile/components/custom_dialog.dart';
import 'package:amira_app/presentation/Screens/profile/components/userData_tile.dart';
import 'package:amira_app/presentation/Screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class MyDetailsScreen extends StatelessWidget {
  const MyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        topTitle: _localizedText(context, 'myDetails'),
      ),
      body: Column(
        children: [
          // Credentials Section
          _buildSection(
            context,
            'credentials',
            padding: const EdgeInsets.symmetric(horizontal: 20),
            textPadding: const EdgeInsets.symmetric(vertical: 20),
            _buildUserDataTiles(context),
          ),
          const SizedBox(height: 10),
          // Manage Account Section
          _buildSection(
            context,
            'manageAccaunt',
            padding:
                const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 20),
            textPadding: const EdgeInsets.only(top: 20, bottom: 6),
            GestureDetector(
              onTap: () =>
                  pushScreenWithoutNavBar(context, const LoginScreen()),
              child: AuthProvider().getAccessToken() != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildText(
                          onTap: () {
                            pushScreenWithNavBar(
                                context, const ChnagePassScreen());
                          },
                          textPadding: const EdgeInsets.only(top: 20),
                          AppLocalization.of(context)
                                  .getTransatedValues('changePass') ??
                              '',
                          AppColors.purpleColor,
                        ),
                        _buildText(
                          onTap: () async {
                            await customDialog(context);
                          },
                          textPadding: const EdgeInsets.only(top: 20),
                          AppLocalization.of(context)
                                  .getTransatedValues('logout') ??
                              '',
                          AppColors.redColor,
                        ),
                      ],
                    )
                  : _buildText(
                      AppLocalization.of(context)
                              .getTransatedValues('register') ??
                          '',
                      AppColors.purpleColor,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper to get localized text
  String _localizedText(BuildContext context, String key) {
    return AppLocalization.of(context).getTransatedValues(key) ?? '';
  }

  // Helper to create a UserDataTile
  UserDataTile _buildUserDataTile(
    BuildContext context,
    String fieldName,
    String? fieldValue, {
    bool isLast = false,
  }) {
    final isHintText = fieldValue == null || fieldValue.isEmpty;
    final title = AuthProvider().getAccessToken() != null && !isHintText
        ? fieldValue
        : _localizedText(context, fieldName);
    return UserDataTile(title: title, isHintText: isHintText, isLast: isLast);
  }

  // Build list of UserDataTiles
  Widget _buildUserDataTiles(BuildContext context) {
    final userData = AuthProvider().getUserData();
    return Column(
      children: [
        _buildUserDataTile(context, 'nameSurname', userData?.name),
        _buildUserDataTile(
          context,
          'birthday',
          userData?.birthday != null
              ? DateFormat('yyyy-MM-dd').format(
                  DateTime.parse(userData!.birthday!),
                )
              : null,
        ),
        _buildUserDataTile(context, 'phone', userData?.phone),
        _buildUserDataTile(context, 'post', userData?.email),
        _buildUserDataTile(
            context,
            'gender',
            AppLocalization.of(context)
                    .getTransatedValues(userData?.gender ?? '') ??
                '',
            isLast: true),
      ],
    );
  }

  // Helper to build a section with a title and child
  Widget _buildSection(
    BuildContext context,
    String titleKey,
    Widget child, {
    EdgeInsets? padding,
    EdgeInsets? textPadding,
  }) {
    return CustomContainer.buildContainer(
      width: double.infinity,
      alignment: Alignment.topLeft,
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildText(
            _localizedText(context, titleKey),
            textPadding: textPadding,
            AppColors.blackColor,
            fontSize: AppFonts.fontSize22,
            fontFamily: fontPeaceSans,
            fontWeight: FontWeight.w400,
          ),
          child,
        ],
      ),
    );
  }

  // Helper to build a text widget with common styles
  Widget _buildText(
    String text,
    Color color, {
    double? fontSize,
    FontWeight? fontWeight,
    String? fontFamily,
    EdgeInsets? textPadding,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: textPadding ?? EdgeInsets.zero,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: fontFamily ?? fontGilroy,
            color: color,
            fontWeight: fontWeight ?? FontWeight.w400,
            fontSize: fontSize ?? AppFonts.fontSize14,
          ),
        ),
      ),
    );
  }
}
