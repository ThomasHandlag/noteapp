import 'package:shared_preferences/shared_preferences.dart';

class DeviceSharedData {
  static Future<bool?> isUsedBefore() async {
    SharedPreferences _prefsInstance = await SharedPreferences.getInstance();
    bool? value = _prefsInstance.getBool('isUsedBefore');
    if (value != null) {
      return value;
    } else {
      return false;
    }
  }

  static Future<void> setUsedBefore() async {
   SharedPreferences _prefsInstance = await SharedPreferences.getInstance();
    _prefsInstance.setBool('isUsedBefore', true);
  }

  static Future<String> getTokens() async {
    // return prefs.getString('tokens');
    return "wrong token";
  }
}
