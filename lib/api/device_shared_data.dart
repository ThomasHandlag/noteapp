import 'package:shared_preferences/shared_preferences.dart';

class DeviceSharedData {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance = await SharedPreferences.getInstance();
  static late SharedPreferences _prefsInstance;

  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static Future<String> getTokens() async {
    // return prefs.getString('tokens');
    return "wrong token";
  }
}
