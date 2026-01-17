import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:developer' as dev;

import 'package:get/get.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // init
  static Future<void> init() async {
    final AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitializationSettings,
            iOS: darwinInitializationSettings);

    // init
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload != null) {
          // navigate to profile screen first because we haven't build notification page yet
          // just build notification service first
          dev.log('notification response : ${response.payload}');
          Get.toNamed('/ProfileScreen',
              arguments: jsonEncode(response.payload));
        }
      },
    );
    dev.log('notification service init');
  }

  // create notification
  static Future<void> createNotification() async {
    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel_id', 'channel name');
    final DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails();
    final NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    await flutterLocalNotificationsPlugin
        .show(0, 'title', 'body', notificationDetails, payload: 'payload');
  }

  // notification permission
  static Future<void> notificationPermission() async {
    final androidPlugin =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    if (androidPlugin != null) {
      await androidPlugin.requestNotificationsPermission();
      dev.log('notification permission');
    }
  }
}
