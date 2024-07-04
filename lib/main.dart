import 'package:amira_app/app_localization.dart';
import 'package:amira_app/blocs/language/language_bloc.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/presentation/Screens/bottomNavBar/bottomNavBar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('lang');
  await Hive.openBox('addressBox');
  await Hive.openBox('categoryBox');
  final Box categoryBox = Hive.box('categoryBox');
  await categoryBox.clear();

  runApp(
    BlocProvider(
      create: (context) => LanguageBloc()..add(InitialLanguageEvent()),
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        ensureScreenSize: true,
        minTextAdapt: true,
        child: BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, state) {
            String? locale;
            if (state is ChangeLanguageState) {
              locale = state.languageCode;
            }
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Amira app',
              theme: ThemeData(
                colorScheme:
                    ColorScheme.fromSeed(seedColor: AppColors.whiteColor),
                scaffoldBackgroundColor: AppColors.lightGreyColor,
                appBarTheme: AppBarTheme(
                  backgroundColor: AppColors.whiteColor,
                  surfaceTintColor: AppColors.whiteColor,
                ),
                fontFamily: fontGilroy,
                useMaterial3: true,
              ),
              home: const BottomNavBar(),
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: TextScaler.noScaling),
                child: child!,
              ),
              locale: Locale(locale ?? 'tr'),
              supportedLocales: const [
                Locale('ru'),
                Locale('tr'),
              ],
              localizationsDelegates: const [
                AppLocalization.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              localeResolutionCallback: (deviceLocale, supportedLocales) {
                for (var locale in supportedLocales) {
                  if (deviceLocale != null) {
                    if (deviceLocale.languageCode == locale.languageCode) {
                      return deviceLocale;
                    }
                  }
                }
                return supportedLocales.first;
              },
            );
          },
        ),
      ),
    ),
  );
}
