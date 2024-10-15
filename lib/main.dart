import 'dart:developer';
import 'dart:io';

import 'package:amira_app/app_localization.dart';
import 'package:amira_app/blocs/profile/language/language_bloc.dart';

import 'package:amira_app/config/theme/constants.dart';
import 'package:amira_app/config/theme/lightTheme.dart';
import 'package:amira_app/data/api_providers/auth_provider.dart';
import 'package:amira_app/data/api_providers/customHttp_provider.dart';
import 'package:amira_app/data/api_providers/notification_provider.dart';
import 'package:amira_app/presentation/Screens/splash/splash_screen.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> backgroundNotificationHandler(RemoteMessage message) async {
  if (message.notification != null) {
    await FCMConfig().sendNotification(
      body: message.notification?.body ?? 'No body',
      title: message.notification?.title ?? 'No title',
    );
  } else {
    debugPrint('Received data-only message: ${message.data}');
  }
}

void main() async {
  HttpOverrides.global = CustomHttpOverrides();
  final dio = Dio();
  dio.httpClientAdapter = IOHttpClientAdapter()
    ..onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

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
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBUDrziHCcOGg3RVCu15bvdhIzIYtIXpzs',
      appId: '1:307466942594:android:f0f31c5feb85a912951c9b',
      messagingSenderId: '307466942594',
      projectId: 'amira-a318b',
    ),
  );

  await Hive.initFlutter();
  await Hive.openBox('lang');
  await Hive.openBox('addressBox');
  await Hive.openBox('homeProducts');
  await Hive.openBox('homeData');
  await Hive.openBox('cartBox');
  await Hive.openBox('favBox');
  await Hive.openBox('auth');

  final Box homeBox = Hive.box('homeProducts');
  final Box homeDataBox = Hive.box('homeData');

  await homeBox.clear();
  await homeDataBox.clear();

  // Initialize FCMConfig and handle errors if any occur
  await FCMConfig().requestPermission();
  await FCMConfig().initAwesomeNotification();

  // Register the background message handler at the top level
  FirebaseMessaging.onBackgroundMessage(backgroundNotificationHandler);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    print(AuthProvider().getAccessToken());
    FCMConfig().requestPermission();
    FCMConfig().subscribeToTopic('Amira');
    FirebaseMessaging.instance.getToken().then((value) {
      final String? token = value;
      log('it is fcmtoken $token');
    });

    // Listen for foreground messages and handle notifications safely
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        FCMConfig().sendNotification(
          body: message.notification?.body ?? 'No body',
          title: message.notification?.title ?? 'No title',
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Phoenix(
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
    );
  }
}
