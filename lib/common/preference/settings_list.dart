import 'package:flutter/material.dart';
import 'package:whats_on_restaurant/common/helper/snackbar_helper.dart';
import 'package:whats_on_restaurant/main.dart';
import 'package:whats_on_restaurant/modules/settings/viewmodel/settings_view_model.dart';

enum Settings {
  darkMode,
  appVersion,
  localNotification;

  String key() {
    switch (this) {
      case Settings.darkMode:
        return 'DARK_MODE';
      case Settings.appVersion:
        return 'APP_VERSION';
      case Settings.localNotification:
        return 'LOCAL_NOTIFICATION';
    }
  }

  String title() {
    switch (this) {
      case Settings.darkMode:
        return 'Dark Mode';
      case Settings.appVersion:
        return 'App Version';
      case Settings.localNotification:
        return 'Scheduled Notification';
    }
  }

  String subtitle() {
    switch (this) {
      case Settings.darkMode:
        return 'View the app in dark mode.';
      case Settings.appVersion:
        return 'Current version of the app.';
      case Settings.localNotification:
        return 'Receive notification for restaurant recommendation.';
    }
  }

  SettingsAction actionType() {
    switch (this) {
      case Settings.darkMode:
        return SettingsAction.toggle;
      case Settings.appVersion:
        return SettingsAction.info;
      case Settings.localNotification:
        return SettingsAction.toggle;
    }
  }

  dynamic action(BuildContext context, {SettingsViewModel? viewModel}) {
    switch (this) {
      case Settings.darkMode:
        if (viewModel != null) {
          return Switch.adaptive(
            value: viewModel.isDarkTheme, 
            onChanged: (isSwitchedOn) async {
              await viewModel.setDarkTheme(state: isSwitchedOn);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                SnackbarHelper.handleSuccess(
                  context: context,
                  message: 'Dark theme is turned ${isSwitchedOn ? 'on' : 'off'}'
                );
              });
            }
          );
        }
      case Settings.appVersion:
        return packageInfo.version;
      case Settings.localNotification:
        if (viewModel != null) {
          return Switch.adaptive(
            value: viewModel.isNotificationScheduled,
            onChanged: (isSwitchedOn) async {
              await viewModel.scheduleNotification(state: isSwitchedOn);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                SnackbarHelper.handleSuccess(
                  context: context,
                  message: 'Local notification is turned ${isSwitchedOn ? 'on' : 'off'}'
                );
              });
            }
          );
        } else {
          return Container();
        }
    }
  }
}

enum SettingsAction {
  info,
  toggle
}

class SettingsList {
  // Available setting list, top down.
  static List<Settings> androidList = [
    Settings.darkMode, 
    Settings.localNotification,
    Settings.appVersion
  ];

  // As Alarm Manager is only available in Android, iOS don't need the localNotification settings
  static List<Settings> iosList = [
    Settings.darkMode, 
    Settings.appVersion
  ];
}