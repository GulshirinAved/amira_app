import 'package:amira_app/app_localization.dart';
import 'package:amira_app/blocs/profile/language/language_bloc.dart';

import 'package:amira_app/config/theme/constants.dart';
import 'package:amira_app/config/theme/lightTheme.dart';
import 'package:amira_app/data/api_providers/auth_provider.dart';
import 'package:amira_app/data/api_providers/notification_provider.dart';
import 'package:amira_app/presentation/Screens/splash/splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: true,
      systemNavigationBarContrastEnforced: true,
      systemNavigationBarColor: AppColors.whiteColor,
      statusBarColor: AppColors.whiteColor,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: 'AIzaSyBUDrziHCcOGg3RVCu15bvdhIzIYtIXpzs',
        appId: '1:307466942594:android:f0f31c5feb85a912951c9b',
        messagingSenderId: '307466942594',
        projectId: 'amira-a318b'),
  );
  await Hive.initFlutter();
  await Hive.openBox('lang');
  await Hive.openBox('addressBox');
  await Hive.openBox('homeProducts');
  await Hive.openBox('homeData');
  await Hive.openBox('cartBox');
  await Hive.openBox('favBox');
  await Hive.openBox('auth');
  await Hive.openBox('userBox');

  final Box homeBox = Hive.box('homeProducts');
  final Box homeDataBox = Hive.box('homeData');
  print(AuthProvider().getUserData());

  await homeBox.clear();
  await homeDataBox.clear();
  print(AuthProvider().getAccessToken());
  await Firebase.initializeApp();

  // Initialize Notification Channel (this should be the same as defined in your notification service)
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // name
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  // Initialize Flutter Local Notifications Plugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize Firebase Messaging
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Initialize Notification Service
  final FirebaseNotificationService notificationService =
      FirebaseNotificationService(
    firebaseMessaging: messaging,
    androidNotificationChannel: channel,
    flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
  );

  // Initialize the notification service
  await notificationService.initNotifications();

  runApp(
    Phoenix(
      child: BlocProvider(
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
                theme: lightTheme(),
                home: const SplashScreen(),
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
    ),
  );
}
