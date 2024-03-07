import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
/*
// 최초 한번 초기화
void initState(){
  LocalNotification.initialize();
}
// Push Notification
LocalNotification.notify("title","body");
* */
class LocalNotification {
  LocalNotification._();
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  static AndroidNotificationChannel get channel => AndroidNotificationChannel('octosys', 'octosys');
  // InitState에서 최초 초기화 필요
  static initialize() async{
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings("mipmap/ic_launcher");
    DarwinInitializationSettings initializationSettingsIOS =
    const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
  static void requestPermission(){
    if(Platform.isAndroid){
      _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }
    else if(Platform.isIOS) {
      _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }
  static Future<void> notify(String title, String body) async{
    const AndroidNotificationDetails androidPlatformChannelSpecifics=
    AndroidNotificationDetails('channelId - octosys', 'channelName - octosys',
        channelDescription: 'channel description',
        importance: Importance.max,
        priority: Priority.max,
        showWhen: true
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android : androidPlatformChannelSpecifics,
        iOS : DarwinNotificationDetails( badgeNumber: 5,)
    );
    await _flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics,
        payload: 'item x'
    );
  }
}