import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

// Notification configuration class with safeguards against null values
class FCMConfig {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

// Initialize Awesome Notifications with proper error handling
  Future<void> initAwesomeNotification() async {
    try {
      await AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white,
            importance: NotificationImportance.Max,
            channelShowBadge: true,
            locked: true,
            defaultRingtoneType: DefaultRingtoneType.Notification,
          ),
        ],
        channelGroups: [
          NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group',
          ),
        ],
        debug: true,
      );
    } catch (e) {
      debugPrint('Failed to initialize Awesome Notifications: $e');
    }
  }

// Request permissions for notifications
  Future<void> requestPermission() async {
    try {
      bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    } catch (e) {
      debugPrint('Error requesting notification permissions: $e');
    }
  }

  int _notificationId = 0;

// Safely send notifications with default values for null cases
  Future<void> sendNotification({String? title, String? body}) async {
    _notificationId++;
    try {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: _notificationId,
          channelKey: 'basic_channel',
          title: title ?? 'No title provided',
          body: body ?? 'No body provided',
          notificationLayout: NotificationLayout.BigText,
          wakeUpScreen: true,
        ),
      );
    } catch (e) {
      debugPrint('Error creating notification: $e');
    }
  }

// Subscribe to a topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      debugPrint('Subscribed to topic: $topic');
    } catch (e) {
      debugPrint('Error subscribing to topic: $e');
    }
  }
}
