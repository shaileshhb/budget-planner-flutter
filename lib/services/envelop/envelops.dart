import 'package:budget_planner_flutter/models/envelop/envelop.dart';
import 'package:budget_planner_flutter/utils/user.shared_preference.dart';
import 'package:http/http.dart' as http;

import '../../utils/global.constant.dart';

class EnvelopService {
  Future<List<EnvelopModel>?> getUserEnvelops() async {
    var client = http.Client();

    var userID = UserSharedPreference.getUserID();
    var authorizationToken = UserSharedPreference.getAuthorizationToken();

    var uri = Uri.parse('${GlobalConstants.baseURL}/users/$userID/envelops');

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authorizationToken"
    };

    var response = await client.get(uri, headers: headers);

    if (response.statusCode == 200) {
      return envelopsFromJson(response.body);
    }
    return null;
  }

  Future<bool> addUserEnvelop(EnvelopModel envelop) async {
    var client = http.Client();

    var userID = UserSharedPreference.getUserID();
    var authorizationToken = UserSharedPreference.getAuthorizationToken();

    var uri = Uri.parse('${GlobalConstants.baseURL}/users/$userID/envelops');

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authorizationToken"
    };

    var body = envelopToJson(envelop);

    var response = await client.post(uri, body: body, headers: headers);

    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<bool> updateUserEnvelop(EnvelopModel envelop) async {
    var client = http.Client();

    var userID = UserSharedPreference.getUserID();
    var authorizationToken = UserSharedPreference.getAuthorizationToken();

    var uri = Uri.parse(
        '${GlobalConstants.baseURL}/users/$userID/envelops/${envelop.id}');

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authorizationToken"
    };

    var body = envelopToJson(envelop);

    var response = await client.put(uri, body: body, headers: headers);

    if (response.statusCode == 202) {
      return true;
    }
    return false;
  }

  Future<bool> deleteUserEnvelop(String envelopID) async {
    var client = http.Client();

    var userID = UserSharedPreference.getUserID();
    var authorizationToken = UserSharedPreference.getAuthorizationToken();

    var uri = Uri.parse(
        '${GlobalConstants.baseURL}/users/$userID/envelops/$envelopID');

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authorizationToken"
    };

    var response = await client.delete(uri, headers: headers);

    if (response.statusCode == 202) {
      return true;
    }
    return false;
  }
}
