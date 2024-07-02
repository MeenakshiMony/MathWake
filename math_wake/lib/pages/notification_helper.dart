import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:math_wake/app_state.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:audioplayers/audioplayers.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin _notification =
  FlutterLocalNotificationsPlugin();
  static final AudioPlayer _audioPlayer = AudioPlayer();

  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await _notification.initialize(initializationSettings);
    tz.initializeTimeZones();

    // Initialize Android Alarm Manager
    await AndroidAlarmManager.initialize();
  }

  static Future<void> scheduledNotification(String title, String body) async {
    DateTime date = FFAppState().date ?? DateTime.now();
    TimeOfDay time = FFAppState().time != null
        ? TimeOfDay.fromDateTime(FFAppState().time!)
        : TimeOfDay.now();

    DateTime combinedDateTime =
    DateTime(date.year, date.month, date.day, time.hour, time.minute);
    tz.TZDateTime scheduledDateTime =
    tz.TZDateTime.from(combinedDateTime, tz.local);

    var androidDetails = AndroidNotificationDetails(
      'Wake Up',
      'My Channel',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('walk_in_the_forest'),
      autoCancel: false,
      enableVibration: true,
      fullScreenIntent: false,
      channelDescription: 'My Channel',
    );
    var iosDetails = const DarwinNotificationDetails();
    var notificationDetails =
    NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _notification.zonedSchedule(
        0,
        title,
        body,
        scheduledDateTime,
        notificationDetails,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);

    // Schedule the audio to play at the same time as the notification
    Duration delay = scheduledDateTime.difference(DateTime.now());
    Future.delayed(delay, () => _playSound());
  }

  static void _playSound() {
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
    _audioPlayer.setSourceAsset('assets/audios/walk_in_the_forest.mp3');
    _audioPlayer.resume();
  }

  static void cancelSound() {
    _audioPlayer.stop();
  }

  static Future<void> cancelAllNotifications() async {
    await _notification.cancelAll();
  }
}




