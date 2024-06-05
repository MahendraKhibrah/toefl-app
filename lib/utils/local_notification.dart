import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = new AndroidInitializationSettings('mipmap/logo');
    var iosInitialize = new DarwinInitializationSettings();

    var initializationsSettings = new InitializationSettings(
        android: androidInitialize, iOS: iosInitialize);

    await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  }

  static Future showBigTextNotification(
      {var id = 0,
      required String title,
      required String body,
      var payload,
      required FlutterLocalNotificationsPlugin fln,
      required DateTime scheduledDateTime}) async {
    AndroidNotificationDetails androidPlatformChannelSpesifics =
        new AndroidNotificationDetails('channelId1', 'channelName',
            playSound: true,
            importance: Importance.max,
            priority: Priority.high);

    var not = NotificationDetails(
        android: androidPlatformChannelSpesifics,
        iOS: DarwinNotificationDetails());
    // Konversi scheduledDateTime ke waktu zona lokal
    final tz.TZDateTime scheduledTZDateTime =
        tz.TZDateTime.from(scheduledDateTime, tz.local);

    await fln.zonedSchedule(
      id,
      title,
      body,
      scheduledTZDateTime,
      not,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
    ;
  }
}