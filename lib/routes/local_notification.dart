import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationHelper {
  static final _notification = FlutterLocalNotificationsPlugin();

  // static init() {
  //   _notification.initialize(const InitializationSettings(
  //       android: AndroidInitializationSettings('@mipmap/ic_launcher'),
  //       iOS: DarwinInitializationSettings()));
  //   tz.initializeTimeZones();
  // }

  static Future initializeNotifications({bool scheduled = false}) async {
    var initAndroidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = DarwinInitializationSettings();

    // _flutterLocalNotificationsPlugin.initialize(initializationSettings,
    //     onDidReceiveNotificationResponse: onNotificationTap,
    //     onDidReceiveBackgroundNotificationResponse: onNotificationTap);

    // // Request permissions for iOS
    // _flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         IOSFlutterLocalNotificationsPlugin>()
    //     ?.requestPermissions(
    //       alert: true,
    //       badge: true,
    //       sound: true,
    //     );
    final settings =
        InitializationSettings(android: initAndroidSettings, iOS: ios);
    await _notification.initialize(settings);
  }

  static Future showNotification({
    var id = 0,
    var title,
    var body,
    var payload,
  }) async {
    var details = await notificationDetails();
    await _notification.show(id, title, body, details, payload: payload);
  }

  static Future showScheduleNotification({
    var id = 0,
    var title,
    var body,
    var payload,
    required DateTime scheduleTime,
  }) async {
    // try {
    //   print("Initializing time zones");
    //   tz.initializeTimeZones();

    //   print("Scheduling notification");
    //   await _flutterLocalNotificationsPlugin.zonedSchedule(
    //     1,
    //     title,
    //     body,
    //     tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
    //     const NotificationDetails(
    //       android: AndroidNotificationDetails(
    //         'channelId 1',
    //         'channelName',
    //         channelDescription: 'channelDesc',
    //         importance: Importance.max,
    //         priority: Priority.high,
    //         ticker: 'ticker',
    //       ),
    //     ),
    //     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    //     uiLocalNotificationDateInterpretation:
    //         UILocalNotificationDateInterpretation.absoluteTime,
    //     payload: payload,
    //   );
    //   print("Notification scheduled successfully.");
    // } catch (e) {
    //   print("Error scheduling notification: $e");
    // }
    var details = await notificationDetails();
    await _notification.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduleTime, tz.local),
      details,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future showScheduleDailyNotification({
    var id = 0,
    var title,
    var body,
    var payload,
  }) async {
    var details = await notificationDetails();
    var scheduledTime = _scheduledDaily(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 14, 08));
    print('Scheduling notification at: $scheduledTime');
    await _notification.zonedSchedule(
      id,
      title,
      body,
      scheduledTime,
      details,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static tz.TZDateTime _scheduledDaily(DateTime time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledTime = tz.TZDateTime(tz.local, now.year, now.month, now.day,
        time.hour, time.minute, time.second);

    final tz.TZDateTime finalTime = scheduledTime.isBefore(now)
        ? scheduledTime.add(const Duration(days: 1))
        : scheduledTime;

    print('Scheduled notification time: $finalTime');
    return finalTime;
  }

  static notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channelId 1', 'channelName',
          importance: Importance.max),
      iOS: DarwinNotificationDetails(),
    );
  }

  // static scheduledNotification(String title, String body) async {
  //   var androidDetails = const AndroidNotificationDetails(
  //       'important_notifications', 'My Channel',
  //       importance: Importance.max, priority: Priority.high);

  //   var iosDetails = const DarwinNotificationDetails();

  //   var notificationDetails =
  //       NotificationDetails(android: androidDetails, iOS: iosDetails);

  //   await _notification.zonedSchedule(
  //       0,
  //       title,
  //       body,
  //       tz.TZDateTime.now(tz.local).add(const Duration(
  //         seconds: 1,
  //       )),
  //       notificationDetails,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime,
  //       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
  // }
}
