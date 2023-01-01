import 'dart:convert';

import 'package:budget_planner_flutter/models/auth/login_request.dart';
import 'package:budget_planner_flutter/models/auth/login_response.dart';
import 'package:budget_planner_flutter/models/auth/register_request.dart';
import 'package:budget_planner_flutter/models/auth/user.dart';
import 'package:budget_planner_flutter/utils/global.constant.dart';
import 'package:budget_planner_flutter/utils/user.shared_preference.dart';
import 'package:http/http.dart' as http;

class AuthenticationService {
  Future<LoginResponse?> userLogin(LoginRequest login) async {
    var client = http.Client();

    var uri = Uri.parse('${GlobalConstants.baseURL}/login');

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    var body = jsonEncode(login);

    var response = await client.post(uri, body: body, headers: headers);

    if (response.statusCode == 200) {
      var json = response.body;
      return loginResponseFromJson(json);
    }
    return null;
  }

  Future<LoginResponse?> register(RegisterRequest userDetails) async {
    var client = http.Client();

    var uri = Uri.parse('${GlobalConstants.baseURL}/register');

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    var body = jsonEncode(userDetails);

    var response = await client.post(uri, body: body, headers: headers);

    if (response.statusCode == 200) {
      var json = response.body;
      return loginResponseFromJson(json);
    }
    return null;
  }

  Future<User?> getUser() async {
    var client = http.Client();

    var authorizationToken = UserSharedPreference.getAuthorizationToken();
    var userID = UserSharedPreference.getUserID();

    var uri = Uri.parse('${GlobalConstants.baseURL}/users/$userID');

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authorizationToken"
    };

    var response = await client.get(uri, headers: headers);

    if (response.statusCode == 200) {
      return userFromJson(response.body);
    }
    return null;
  }

  Future<Object?> updateUser(User user) async {
    var client = http.Client();

    var authorizationToken = UserSharedPreference.getAuthorizationToken();
    var userID = UserSharedPreference.getUserID();
    var body = jsonEncode(user);

    var uri = Uri.parse('${GlobalConstants.baseURL}/users/$userID');

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authorizationToken"
    };

    var response = await client.put(uri, body: body, headers: headers);

    if (response.statusCode == 202) {
      return null;
    }
    return null;
  }
}
