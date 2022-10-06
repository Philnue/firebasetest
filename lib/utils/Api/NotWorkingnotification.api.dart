import 'dart:io';

import 'package:firebasetest/utils/Models/appointment.dart';
import 'package:firebasetest/utils/format.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notifications.show(id, title, body, await _notificationDetails(),
          payload: payload);

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        //'channel id2',
        'channel name',
        playSound: false,
        priority: Priority.max,

        importance:
            Importance.max, //wenn angezeitgt werden soll sonst imc enter
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future init({bool initScheduled = false}) async {
    const android = AndroidInitializationSettings("@mipmap/ic_launcher");
    const iOS = IOSInitializationSettings(
      defaultPresentSound: false,
    );
    const settings = InitializationSettings(android: android, iOS: iOS);

    //When App Closed
    final details = await _notifications.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      onNotifications.add(details.payload);
    }

    await _notifications.initialize(
      settings,
      onSelectNotification: (payload) async {
        onNotifications.add(payload);
      },
    );

    if (initScheduled) {
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  static Future showNotificationSchedule({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledTime,
  }) async =>
      scheduledTime.isAfter(DateTime.now()) == true
          ? _notifications.zonedSchedule(
              id,
              title,
              body,

              //_scheduleDaily(Time(8)),
              //_scheduleWeekly(Time(8), days [DateTime.monday, DateTime.tuesday])
              tz.TZDateTime.from(scheduledTime, tz.local),
              await _notificationDetails(),
              payload: payload,
              androidAllowWhileIdle: true,
              uiLocalNotificationDateInterpretation:
                  UILocalNotificationDateInterpretation.absoluteTime,
              //matchDateTimeComponents: DateTimeComponents.time
              // matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime
            )
          : null;

  static tz.TZDateTime _scheduleDaily(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduleDate = tz.TZDateTime(tz.local, now.year, now.month, now.day,
        time.hour, time.minute, time.second);

    return scheduleDate.isBefore(now)
        ? scheduleDate.add(const Duration(days: 1))
        : scheduleDate;
  }

  static tz.TZDateTime _scheduleWeek(Time time, {required List<int> days}) {
    tz.TZDateTime scheduledDate = _scheduleDaily(time);

    while (!days.contains(scheduledDate.weekday)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  static void cancel(int id) => _notifications.cancel(id);
  static void cancelAll() => _notifications.cancelAll();

  static void showNotificationWithTermin(Appointment termin) {
    var days = 1; //Dummy

    var time = "1"; // dummy

    cancel(123); //!machen

    DateTime finished = DateTime(2022);
    if (days == 0) {
      //! ändern
      finished = Format.getDateTimeObejectWithoutDuration(
          termin.time.day.toString(), time);
    } else {
      finished = Format.getDateTimeObejectWithMinusDuration(
          termin.time.day.toString(), time, Duration(days: days));
    }

    var bodyGenerator = Format.bodyGenerator(days);
    //wenn n.A. drinnen ist

    var isAndroid = Platform.isAndroid;

    if (isAndroid) {
      finished = DateTime(
          termin.terminAsDateTimeWithoutTime.year,
          termin.terminAsDateTimeWithoutTime.month,
          termin.terminAsDateTimeWithoutTime.day,
          08,
          00);
    }

    //var test = DateTime.now().add(Duration(seconds: 8));
    print(finished);
    NotificationApi.showNotificationSchedule(
      scheduledTime: finished,
      //! auch
      body: "Dieser Termin fängt $bodyGenerator um ${termin.time.day}",
      id: 123, //! muss noch gemacht werden
      payload: termin.id.toString(),
      title: termin.name,
    );
  }
}
