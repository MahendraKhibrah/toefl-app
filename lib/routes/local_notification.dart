import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
      required FlutterLocalNotificationsPlugin fln}) async {
    AndroidNotificationDetails androidPlatformChannelSpesifics =
        new AndroidNotificationDetails('channelId1', 'channelName',
            playSound: true,
            importance: Importance.max,
            priority: Priority.high);

    var not = NotificationDetails(
        android: androidPlatformChannelSpesifics,
        iOS: DarwinNotificationDetails());
    await fln.show(0, title, body, not);
  }

  
  

  
}
// <<<<<<< HEAD
// import 'dart:async';
// // import 'dart:js_interop';

// import 'package:flutter/material.dart';
// =======
// >>>>>>> efc7c776abe75efe98a6405c4d476f7658beefda
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationHelper {
//   static Future initialize(
//       FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
//     var androidInitialize = new AndroidInitializationSettings('mipmap/logo');
//     var iosInitialize = new DarwinInitializationSettings();

// <<<<<<< HEAD
//   static final onNotifications = BehaviorSubject<String?>();
//   static StreamController<NotificationResponse> onClickNotification =
//       StreamController();

//   static Future<void> init({bool initScheduled = false}) async {
//     final android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     final iOS = DarwinInitializationSettings();
//     final settings = InitializationSettings(android: android, iOS: iOS);

//     await _notification.initialize(
//       settings,
//       onDidReceiveNotificationResponse:
//           (NotificationResponse notificationResponse) async {
//         final String? payload = notificationResponse.payload;
//         if (payload != null) {
//           onNotifications.add(payload);
//         }
//       },
//     );

//     if (initScheduled) {
//       tz.initializeTimeZones();
//       tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));
//     }
//   }

//   static Future<void> showNotification({
//     var id = 0,
//     required String title,
//     required String body,
//     required String payload,
//   }) async {
//     var details = await _notificationDetails();
//     await _notification.show(
//       id,
//       title,
//       body,
//       details,
//       payload: payload,
//     );
//   }

//   static Future<void> showScheduledDailyNotification({
//     var id = 0,
//     required String title,
//     required String body,
//     required String payload,
//   }) async {
//     final now = tz.TZDateTime.now(tz.local);
//     // final scheduledDate = _nextInstanceOfTime(21, 04);

//     await _notification.zonedSchedule(
//       id,
//       title,
//       body,
//       _nextInstanceOfTime(7, 00),
//       await _notificationDetails(),
//       payload: payload,
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       matchDateTimeComponents: DateTimeComponents.time,
//     );
//     // print('Scheduled notification time: $scheduledDate');
//   }

//   static Future<NotificationDetails> _notificationDetails() async {
//     return const NotificationDetails(
//       android: AndroidNotificationDetails(
//           'daily_notification_channel_id', 'Daily Notifications',
//           channelDescription: 'This channel is used for daily notifications',
//           importance: Importance.max,
//           priority: Priority.high,
//           ticker: 'ticker'),
//       iOS: DarwinNotificationDetails(),
//     );
//   }

//   static tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
//     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduledDate =
//         tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }
//     return scheduledDate;
//   }
// =======
//     var initializationsSettings = new InitializationSettings(
//         android: androidInitialize, iOS: iosInitialize);

//     await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
//   }

//   static Future showBigTextNotification(
//       {var id = 0,
//       required String title,
//       required String body,
//       var payload,
//       required FlutterLocalNotificationsPlugin fln}) async {
//     AndroidNotificationDetails androidPlatformChannelSpesifics =
//         new AndroidNotificationDetails('channelId1', 'channelName',
//             playSound: true,
//             importance: Importance.max,
//             priority: Priority.high);

//     var not = NotificationDetails(
//         android: androidPlatformChannelSpesifics,
//         iOS: DarwinNotificationDetails());
//     await fln.show(0, title, body, not);
//   }

  
  

  
// >>>>>>> efc7c776abe75efe98a6405c4d476f7658beefda
// }

// // class NotificationHelper {
// //   static final FlutterLocalNotificationsPlugin _notification =
// //       FlutterLocalNotificationsPlugin();

// //   static final onNotifications = BehaviorSubject<String?>();

// //   static StreamController<NotificationResponse> onClickNotification =
// //       StreamController();

// //   // static Future initializeNotifications({bool scheduled = false}) async {
// //   //   var initAndroidSettings =
// //   //       AndroidInitializationSettings('@mipmap/ic_launcher');
// //   //   var ios = DarwinInitializationSettings();

// //   //   // _flutterLocalNotificationsPlugin.initialize(initializationSettings,
// //   //   //     onDidReceiveNotificationResponse: onNotificationTap,
// //   //   //     onDidReceiveBackgroundNotificationResponse: onNotificationTap);

// //   //   // // Request permissions for iOS
// //   //   // _flutterLocalNotificationsPlugin
// //   //   //     .resolvePlatformSpecificImplementation<
// //   //   //         IOSFlutterLocalNotificationsPlugin>()
// //   //   //     ?.requestPermissions(
// //   //   //       alert: true,
// //   //   //       badge: true,
// //   //   //       sound: true,
// //   //   //     );
// //   //   final settings =
// //   //       InitializationSettings(android: initAndroidSettings, iOS: ios);
// //   //   await _notification.initialize(settings);

// //   static void onNotificationTap(NotificationResponse notificationResponse) {
// //     onClickNotification.add(notificationResponse);
// //   }

// //   static Future<void> initializeNotifications() async {
// //     InitializationSettings settings = const InitializationSettings(
// //         android: AndroidInitializationSettings('@mipmap/ic_launcher'),
// //         iOS: DarwinInitializationSettings());

// //     _notification.initialize(settings,
// //         onDidReceiveBackgroundNotificationResponse: onNotificationTap,
// //         onDidReceiveNotificationResponse: onNotificationTap);
// //   }

// //   static notificationDetails() async {
// //     return const NotificationDetails(
// //       android: AndroidNotificationDetails('channelId 0', 'channelName',
// //           channelDescription: 'channelDesc',
// //           importance: Importance.max,
// //           priority: Priority.high,
// //           ticker: 'ticker'),
// //       iOS: DarwinNotificationDetails(),
// //     );
// //   }

// //   // static Future init({bool initScheduled = false}) async {
// //   //   final android = AndroidInitializationSettings('@mipmap/ic_launcher');
// //   //   final iOS = DarwinInitializationSettings();
// //   //   final settings = InitializationSettings(android: android, iOS: iOS);

// //   //   await _notification.initialize(settings, onDidReceiveNotificationResponse:
// //   //       (NotificationResponse notificationResponse) async {
// //   //     final String? payload = notificationResponse.payload;
// //   //     onNotifications.add(payload);
// //   //   });
// //   // }

// //   static Future<void> showNotification({
// //     var id = 0,
// //     required String title,
// //     required String body,
// //     required String payload,
// //   }) async {
// //     var details = await notificationDetails();
// //     await _notification.show(id, title, body, details, payload: payload);
// //   }

// //   static Future showScheduleNotification({
// //     var id = 1,
// //     required String title,
// //     required String body,
// //     required String payload,
// //     required DateTime scheduleTime,
// //   }) async {
// //     var details = await notificationDetails();
// //     await _notification.zonedSchedule(
// //       id,
// //       title,
// //       body,
// //       tz.TZDateTime.from(scheduleTime, tz.local),
// //       details,
// //       payload: payload,
// //       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
// //       uiLocalNotificationDateInterpretation:
// //           UILocalNotificationDateInterpretation.absoluteTime,
// //     );
// //   }

// //   static Future showScheduleDailyNotification({
// //     var id = 2,
// //     required String title,
// //     required String body,
// //     required String payload,
// //   }) async {
// //     tz.initializeTimeZones();
// //     var details = await notificationDetails();
// //     var scheduledTime = _scheduledDaily(DateTime(
// //         DateTime.now().year, DateTime.now().month, DateTime.now().day, 10, 08));
// //     print('Scheduling notification at: $scheduledTime');

// //     await _notification.zonedSchedule(
// //       id,
// //       title,
// //       body,
// //       scheduledTime,
// //       details,
// //       payload: payload,
// //       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
// //       uiLocalNotificationDateInterpretation:
// //           UILocalNotificationDateInterpretation.absoluteTime,
// //       matchDateTimeComponents: DateTimeComponents.time,
// //     );
// //   }

// //   static tz.TZDateTime _scheduledDaily(DateTime time) {
// //     final accra = tz.getLocation('Asia/Jakarta');
// //     final now = tz.TZDateTime.now(tz.local);
// //     print('$now');
// //     final scheduledTime = tz.TZDateTime(accra, now.year, now.month, now.day,
// //         time.hour, time.minute, time.second);

// //     final tz.TZDateTime finalTime = scheduledTime.isBefore(now)
// //         ? scheduledTime.add(const Duration(days: 1))
// //         : scheduledTime;

// //     print('Scheduled notification time: $finalTime');
// //     return finalTime;
// //   }

// //   // static scheduledNotification(String title, String body) async {
// //   //   var androidDetails = const AndroidNotificationDetails(
// //   //       'important_notifications', 'My Channel',
// //   //       importance: Importance.max, priority: Priority.high);

// //   //   var iosDetails = const DarwinNotificationDetails();

// //   //   var notificationDetails =
// //   //       NotificationDetails(android: androidDetails, iOS: iosDetails);

// //   //   await _notification.zonedSchedule(
// //   //       0,
// //   //       title,
// //   //       body,
// //   //       tz.TZDateTime.now(tz.local).add(const Duration(
// //   //         seconds: 1,
// //   //       )),
// //   //       notificationDetails,
// //   //       uiLocalNotificationDateInterpretation:
// //   //           UILocalNotificationDateInterpretation.absoluteTime,
// //   //       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
// //   // }
// // }

// //     // try {
// //     //   print("Initializing time zones");
// //     //   tz.initializeTimeZones();

// //     //   print("Scheduling notification");
// //     //   await _flutterLocalNotificationsPlugin.zonedSchedule(
// //     //     1,
// //     //     title,
// //     //     body,
// //     //     tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
// //     //     const NotificationDetails(
// //     //       android: AndroidNotificationDetails(
// //     //         'channelId 1',
// //     //         'channelName',
// //     //         channelDescription: 'channelDesc',
// //     //         importance: Importance.max,
// //     //         priority: Priority.high,
// //     //         ticker: 'ticker',
// //     //       ),
// //     //     ),
// //     //     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
// //     //     uiLocalNotificationDateInterpretation:
// //     //         UILocalNotificationDateInterpretation.absoluteTime,
// //     //     payload: payload,
// //     //   );
// //     //   print("Notification scheduled successfully.");
// //     // } catch (e) {
// //     //   print("Error scheduling notification: $e");
// //     // }