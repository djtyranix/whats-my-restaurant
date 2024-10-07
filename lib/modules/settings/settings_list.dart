import 'package:flutter/material.dart';
import 'package:whats_on_restaurant/common/helper/snackbar_helper.dart';
import 'package:whats_on_restaurant/main.dart';
import 'package:whats_on_restaurant/modules/settings/viewmodel/settings_view_model.dart';

enum SettingsType {
  darkMode,
  appVersion,
  localNotification;

  String title() {
    switch (this) {
      case SettingsType.darkMode:
        return 'Dark Mode';
      case SettingsType.appVersion:
        return 'App Version';
      case SettingsType.localNotification:
        return 'Scheduled Notification';
    }
  }

  String subtitle() {
    switch (this) {
      case SettingsType.darkMode:
        return 'View the app in dark mode.';
      case SettingsType.appVersion:
        return 'Current version of the app.';
      case SettingsType.localNotification:
        return 'Receive notification for restaurant recommendation.';
    }
  }

  SettingsAction actionType() {
    switch (this) {
      case SettingsType.darkMode:
        return SettingsAction.toggle;
      case SettingsType.appVersion:
        return SettingsAction.info;
      case SettingsType.localNotification:
        return SettingsAction.toggle;
    }
  }

  dynamic action(BuildContext context, {SettingsViewModel? viewModel}) {
    switch (this) {
      case SettingsType.darkMode:
        return Switch.adaptive(
          value: false, 
          onChanged: (isSwitchedOn) {
            
          }
        );
      case SettingsType.appVersion:
        return packageInfo.version;
      case SettingsType.localNotification:
        if (viewModel != null) {
          return Switch.adaptive(
            value: viewModel.isNotificationScheduled,
            onChanged: (isSwitchedOn) async {
              viewModel.scheduleNotification(state: isSwitchedOn);
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
  static List<SettingsType> androidList = [
    SettingsType.darkMode, 
    SettingsType.localNotification,
    SettingsType.appVersion
  ];

  // As Alarm Manager is only available in Android, iOS don't need the localNotification settings
  static List<SettingsType> iosList = [
    SettingsType.darkMode, 
    SettingsType.appVersion
  ];
}