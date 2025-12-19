import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

@singleton
class NotificationService {
  final notificationPlagin = FlutterLocalNotificationsPlugin();

  bool isGranted = false;

  Future<void> init() async {
    await _configureLocalTimeZone();

    const AndroidInitializationSettings initSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initSettingsIOS =
        DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
          requestCriticalPermission: true,
        );

    final InitializationSettings initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );

    isGranted = await _isPermissionGranted();

    await notificationPlagin.initialize(initSettings);
  }

  Future<void> _configureLocalTimeZone() async {
    if (kIsWeb || Platform.isLinux) {
      return;
    }
    tz.initializeTimeZones();
    if (Platform.isWindows) {
      return;
    }
    var timeZoneInfo = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneInfo.identifier));
  }

  NotificationDetails notificationDetails() {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'flinder_dayly_chanel_id',
        'Daily Notifications',
        channelDescription: 'Flinder Daily Notification',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    notificationPlagin.show(id, title, body, notificationDetails());
  }

  Future<void> scheduleNotification({
    int id = 1,
    required String title,
    required String body,
  }) async {
    /*final now = tz.TZDateTime.now(tz.local);

    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
      0,
    );*/

    await cancelAllNotification();

    if (!isGranted) {
      await _requestPermissions();
      isGranted = await _isPermissionGranted();
    }

    // Ставим напоминание через 3 дня.
    var scheduledDate = tz.TZDateTime.now(
      tz.local,
    ).add(const Duration(days: 3));

    await notificationPlagin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  Future<void> cancelAllNotification() async {
    // Очищаем все напоминания.

    await notificationPlagin.cancelAll();
  }

  Future<bool> _isPermissionGranted() async {
    if (Platform.isAndroid) {
      final status = await notificationPlagin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.areNotificationsEnabled();
      return status ?? false;
    } else if (Platform.isIOS) {
      final status = await Permission.notification.status;
      return status.isGranted;
    }
    return false;
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS) {
      await notificationPlagin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      await notificationPlagin
          .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          notificationPlagin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();

      await androidImplementation?.requestNotificationsPermission();
    }
  }
}
