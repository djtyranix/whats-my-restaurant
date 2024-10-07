import 'package:shared_preferences/shared_preferences.dart';
import 'package:whats_on_restaurant/modules/settings/settings_list.dart';

class PreferenceHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferenceHelper({
    required this.sharedPreferences
  });

  Future<bool> getBoolean({required Settings setting}) async {
    final prefs = await sharedPreferences;
    return prefs.getBool(setting.key()) ?? false;
  }

  void setBool({required Settings setting, required bool value}) async {
    final prefs = await sharedPreferences;
    prefs.setBool(setting.key(), value);
  }
}