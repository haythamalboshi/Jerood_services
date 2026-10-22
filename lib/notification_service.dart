import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<bool> scheduleWaterReminder({
    required DateTime deliveryDateTime,
    required String neighborhood,
  }) async {
    // Schedule exactly 8 hours before delivery
    final scheduledTime = deliveryDateTime.subtract(const Duration(hours: 8));
    final now = DateTime.now();

    final effectiveTime = scheduledTime.isBefore(now)
        ? now.add(const Duration(seconds: 10))
        : scheduledTime;

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'jerood_water_channel',
      'تنبيهات أدوار المياه - جيرود',
      importance: Importance.max,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final tzTime = tz.TZDateTime.from(effectiveTime, tz.local);

    await _notificationsPlugin.zonedSchedule(
      1001,
      'تذكير دور المياه - $neighborhood',
      'مياه الشرب ستبدأ بالضخ في $neighborhood خلال 8 ساعات. يرجى تجهيز الخزانات والمضخات.',
      tzTime,
      const NotificationDetails(android: androidDetails, iOS: iosDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'water_$neighborhood',
    );
    return true;
  }
}
