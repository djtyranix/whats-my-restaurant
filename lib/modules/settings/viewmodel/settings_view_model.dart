import 'dart:developer';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:whats_on_restaurant/common/extensions.dart';
import 'package:whats_on_restaurant/common/helper/background_service.dart';
import 'package:whats_on_restaurant/common/helper/date_time_helper.dart';

class SettingsViewModel extends ViewModel {
  bool _isNotificationScheduled = false;

  bool get isNotificationScheduled => _isNotificationScheduled;

  Future<bool> scheduleNotification({required bool state}) async {
    _isNotificationScheduled = state;

    if (_isNotificationScheduled) {
      log('Notification schedule activated.');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(days: 1), 
        1, 
        BackgroundService.callback,
        startAt: DateTimeHelper.getNotificationShowTime(),
        exact: true,
        wakeup: true
      );
    } else {
      log('Notification schedule disabled.');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}