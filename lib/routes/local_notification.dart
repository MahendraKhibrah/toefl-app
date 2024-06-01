import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin _notification =
      FlutterLocalNotificationsPlugin();

  static StreamController<NotificationResponse> onClickNotification =
      StreamController();

  static void onNotificationTap(NotificationResponse notificationResponse) {
    onClickNotification.add(notificationResponse);
  }

  static Future<void> initializeNotifications() async {
    InitializationSettings settings = const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings()
    );

    _notification.initialize(settings,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap,
        onDidReceiveNotificationResponse: onNotificationTap);
  }

  static Future<void> showNotification({
    var id = 0,
    required String title,
    required String body,
    required String payload,
  }) async {
    var details = await notificationDetails();
    await _notification.show(id, title, body, details, payload: payload);
  }

  static Future showScheduleNotification({
    var id = 1,
    required String title,
    required String body,
    required String payload,
    required DateTime scheduleTime,
  }) async {
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
    var id = 2,
    required String title,
    required String body,
    required String payload,
  }) async {
    tz.initializeTimeZones();
    var details = await notificationDetails();
    var scheduledTime = _scheduledDaily(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 05, 44));
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
    final jakarta = tz.getLocation('Asia/Jakarta');
    final now = tz.TZDateTime.now(jakarta);
    print('$now');
    final scheduledTime = tz.TZDateTime(jakarta, now.year, now.month, now.day,
        time.hour, time.minute, time.second);

    final tz.TZDateTime finalTime = scheduledTime.isBefore(now)
        ? scheduledTime.add(const Duration(days: 1))
        : scheduledTime;

    print('Scheduled notification time: $finalTime');
    return finalTime;
  }

  static notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channelId 0', 'channelName',
          channelDescription: 'channelDesc',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker'),
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
