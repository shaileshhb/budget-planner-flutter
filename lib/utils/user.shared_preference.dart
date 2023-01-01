import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreference {
  static late SharedPreferences _preferences;

  static const _keyAuthToken = "Authorization";
  static const _keyUserID = "UserID";

  static Future init() async =>
      {_preferences = await SharedPreferences.getInstance()};

  static Future setAuthorizationToken(String token) async {
    await _preferences.setString(_keyAuthToken, token);
  }

  static String? getAuthorizationToken() {
    return _preferences.getString(_keyAuthToken);
  }

  static Future setUserID(String userID) async {
    await _preferences.setString(_keyUserID, userID);
  }

  static String? getUserID() {
    return _preferences.getString(_keyUserID);
  }

  static void removeAuthorizationToken() async {
    await _preferences.remove(_keyAuthToken);
  }

  static void removeUserID() async {
    await _preferences.remove(_keyUserID);
  }
}
