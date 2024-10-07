import 'dart:convert';
import 'dart:developer';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:whats_on_restaurant/common/navigation.dart';
import 'package:whats_on_restaurant/domain/models/response/restaurant_response.dart';
import 'package:whats_on_restaurant/domain/models/restaurant.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  Future<void> initNotifications(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitSettings = const AndroidInitializationSettings(
      '@mipmap/ic_launcher'
    );

    var iosInitSettings = const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true
    );

    var initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iosInitSettings
    );

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationDetails) async {
        final payload = notificationDetails.payload;

        if (payload != null) {
          log('Notification Payload: $payload');
        }

        selectNotificationSubject.add(payload ?? '');
      }
    );
  }

  Future<void> showNotification(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, RestaurantListResponse restaurant) async {
    var channelId = '1';
    var channelName = 'restaurant_channel';
    var channelDescription = 'Restaurant Notification Channel';

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'Restaurant Recommendation',
      styleInformation: const DefaultStyleInformation(true, true)
    );

    var iosPlatformChannelSpecifics = const DarwinNotificationDetails();
    
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics
    );

    var notificationTitle = '<b>New Restaurant Recommendation</b>';
    var notificationBody = 'Check out ${restaurant.name}!';

    await flutterLocalNotificationsPlugin.show(
      0, 
      notificationTitle, 
      notificationBody, 
      platformChannelSpecifics,
      payload: jsonEncode(restaurant)
    );
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = RestaurantList.fromResponse(
          RestaurantListResponse.fromJson(jsonDecode(payload))
        );
        Navigation.navigate(toRoute: route, arguments: data.id);
      }
    );
  }
}