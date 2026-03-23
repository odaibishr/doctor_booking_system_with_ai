import 'dart:developer';

import 'package:doctor_booking_system_with_ai/core/database/api/dio_consumer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FcmService {
  final DioConsumer _dioConsumer;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static const _channel = AndroidNotificationChannel(
    'high_importance_channel',
    'إشعارات مهمة',
    description: 'إشعارات الحجوزات والمواعيد',
    importance: Importance.high,
    playSound: true,
  );

  FcmService(this._dioConsumer);

  Future<void> initialize() async {
    final settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      log('FCM: Permission denied');
      return;
    }

    await _setupLocalNotifications();

    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);
    FirebaseMessaging.instance.onTokenRefresh.listen(_handleTokenRefresh);

    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessageOpenedApp(initialMessage);
    }
  }

  Future<void> _setupLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/launcher_icon',
    );

    const initSettings = InitializationSettings(android: androidSettings);

    await _localNotifications.initialize(initSettings);

    final androidPlugin = _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    await androidPlugin?.createNotificationChannel(_channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<String?> getToken() async {
    try {
      return await FirebaseMessaging.instance.getToken().timeout(const Duration(seconds: 3));
    } catch (e) {
      log('FCM: Failed to get token: $e');
      return null;
    }
  }

  Future<void> updateTokenOnServer(String token) async {
    try {
      await _dioConsumer.post(
        'notification/update-token',
        data: {'fcm_token': token},
      );
      log('FCM: Token updated on server');
    } catch (e) {
      log('FCM: Failed to update token: $e');
    }
  }

  void _handleForegroundMessage(RemoteMessage message) {
    log('FCM foreground message: ${message.notification?.title} | ${message.data}');

    final title =
        message.notification?.title ?? message.data['title'] as String?;
    final body = message.notification?.body ?? message.data['body'] as String?;

    if (title != null && body != null) {
      try {
        _localNotifications.show(
          message.hashCode,
          title,
          body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _channel.id,
              _channel.name,
              channelDescription: _channel.description,
              importance: Importance.high,
              priority: Priority.high,
              icon: '@mipmap/launcher_icon',
            ),
          ),
        );
      } catch (e) {
        log('FCM: Failed to show local notification: $e');
      }
    }
  }

  void _handleMessageOpenedApp(RemoteMessage message) {
    log('FCM opened app: ${message.data}');
  }

  void _handleTokenRefresh(String token) {
    log('FCM: Token refreshed');
    updateTokenOnServer(token);
  }

  Future<void> clearToken() async {
    await FirebaseMessaging.instance.deleteToken();
  }
}
