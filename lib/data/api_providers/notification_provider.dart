import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter/foundation.dart';

class FirebaseNotificationService {
  const FirebaseNotificationService({
    required FirebaseMessaging firebaseMessaging,
    required AndroidNotificationChannel androidNotificationChannel,
    required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  })  : _firebaseMessaging = firebaseMessaging,
        _androidNotificationChannel = androidNotificationChannel,
        _flutterLocalNotificationsPlugin = flutterLocalNotificationsPlugin;

  final FirebaseMessaging _firebaseMessaging;
  final AndroidNotificationChannel _androidNotificationChannel;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    debugPrint(message.notification?.title);
  }

  Future<void> initLocalNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(
      android: android,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        if (response.payload == null) return;

        final message = RemoteMessage.fromMap(
            jsonDecode(response.payload!) as Map<String, dynamic>);
        handleMessage(message);
      },
    );

    final platform =
        _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidNotificationChannel);
  }

  Future<void> initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    unawaited(
        FirebaseMessaging.instance.getInitialMessage().then(handleMessage));
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(
      (message) {
        final notification = message.notification;
        final android = message.notification?.android;
        if (notification == null || android == null) return;

        _flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidNotificationChannel.id,
              _androidNotificationChannel.name,
              channelDescription: _androidNotificationChannel.description,
              icon: '@mipmap/ic_launcher',
            ),
          ),
          payload: jsonEncode(message.toMap()),
        );
      },
    );
  }

  Future<void> initNotifications() async {
    // Check if permissions are already granted
    NotificationSettings settings =
        await _firebaseMessaging.getNotificationSettings();
    if (settings.authorizationStatus == AuthorizationStatus.notDetermined) {
      await _firebaseMessaging.requestPermission();
    }
    unawaited(initPushNotifications());
    unawaited(initLocalNotifications());
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // Handle background messages
    debugPrint("Handling a background message: ${message.messageId}");
  }
}
