import 'dart:developer' as developer;
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';
import 'package:whats_on_restaurant/common/di.dart';
import 'package:whats_on_restaurant/common/helper/notification_helper.dart';
import 'package:whats_on_restaurant/main.dart';
import 'package:whats_on_restaurant/modules/home/data/home_repository.dart';

final ReceivePort port = ReceivePort();


class BackgroundService {
  static const String _isolateName = 'isolate';

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName
    );
  }

  static Future<void> callback() async {
    developer.log('Alarm is fired.');
    final NotificationHelper notificationHelper = DependencyInjection.getInstance();
    final HomeRepository homeRepository = DependencyInjection.getInstance();
    final Random random = Random();
    var restaurantList = await homeRepository.getRestaurants();
    var restaurantToShow = restaurantList[random.nextInt(restaurantList.length)];

    await notificationHelper.showNotification(
      flutterLocalNotificationsPlugin, 
      restaurantToShow
    );
  }
}