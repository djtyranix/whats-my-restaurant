import 'package:flutter/material.dart';
import 'package:whats_on_restaurant/common/helper/preference_helper.dart';
import 'package:whats_on_restaurant/modules/settings/settings_list.dart';
import 'package:whats_on_restaurant/modules/settings/viewmodel/settings_view_model.dart';

class PreferenceProvider extends ChangeNotifier {
  PreferenceHelper helper;

  PreferenceProvider({
    required this.helper
  }) {
    _getTheme();
    _getNotificationScheduleStatus();
  }

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  bool _isNotificationScheduled = false;

  SettingsViewModel? preference;
  bool get isNotificationScheduled => _isNotificationScheduled;

  void _getTheme() async {
    _isDarkTheme = await helper.getBoolean(setting: Settings.darkMode);
    notifyListeners();
  }

  void _getNotificationScheduleStatus() async {
    _isNotificationScheduled = await helper.getBoolean(setting: Settings.localNotification);
    notifyListeners();
  }

  void setDarkTheme(bool isEnabled) {
    helper.setBool(setting: Settings.darkMode, value: isEnabled);
    _getTheme();
  }

  void setNotificationScheduleStatus(bool isEnabled) {
    helper.setBool(setting: Settings.localNotification, value: isEnabled);
    _getNotificationScheduleStatus();
  }
}