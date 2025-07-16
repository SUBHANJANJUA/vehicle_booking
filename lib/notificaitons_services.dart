import 'dart:developer';
import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initializeNotifications() async {
    await _initLocalNotification();
    await _firebaseInit();
    requestNotificationPermission();
    getToken();
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('user granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('user granted provisional permission');
    } else {
      AppSettings.openAppSettings();
      log('user denied permission');
    }
  }

  void getToken() async {
    String? token = await messaging.getToken();
    log("FCM Token: $token");

    // Save token to Firestore (recommended: store inside each user's document)
  }

  Future<void> _firebaseInit() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      log("Notification clicked");
    });
  }

  Future<void> _initLocalNotification() async {
    const AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings =
        InitializationSettings(android: androidInitSettings);

    await flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'chat_channel',
      'Chat Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails details =
        NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title ?? 'New Message',
      message.notification?.body ?? '',
      details,
    );
  }
}
