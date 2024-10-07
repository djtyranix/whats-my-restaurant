import 'dart:developer';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:whats_on_restaurant/common/extensions.dart';
import 'package:whats_on_restaurant/common/helper/background_service.dart';
import 'package:whats_on_restaurant/common/helper/date_time_helper.dart';
import 'package:whats_on_restaurant/common/preference/preference_provider.dart';

class SettingsViewModel extends ViewModel {
  PreferenceProvider preference;

  SettingsViewModel({
    required this.preference
  });

  bool _isNotificationScheduled = false;
  bool _isDarkTheme = false;

  bool get isNotificationScheduled => _isNotificationScheduled;
  bool get isDarkTheme => _isDarkTheme;

  void update(PreferenceProvider preference) {
    _isNotificationScheduled = preference.isNotificationScheduled;
    _isDarkTheme = preference.isDarkTheme;
    notifyListeners();
  }
  
  Future<void> setDarkTheme({required bool state}) async {
    _isDarkTheme = state;
    preference.setDarkTheme(state);
  }

  Future<bool> scheduleNotification({required bool state}) async {
    _isNotificationScheduled = state;
    preference.setNotificationScheduleStatus(state);

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