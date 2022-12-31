import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreference {
  static late SharedPreferences _preferences;

  static const _keyAuthToken = "Authorization";

  static Future init() async =>
      {_preferences = await SharedPreferences.getInstance()};

  static Future setAuthorizationToken(String token) async {
    await _preferences.setString(_keyAuthToken, token);
  }

  static String? getAuthorizationToken() {
    return _preferences.getString(_keyAuthToken);
  }
}
