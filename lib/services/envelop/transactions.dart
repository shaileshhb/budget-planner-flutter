import 'dart:convert';

import 'package:budget_planner_flutter/models/envelop/transactions.dart';

import 'package:budget_planner_flutter/utils/user.shared_preference.dart';
import 'package:http/http.dart' as http;

import '../../utils/global.constant.dart';

class TransactionService {
  Future<List<TransactionModel>?> getUserTransactions(
      Map<String, dynamic> queryparams) async {
    var client = http.Client();

    var userID = UserSharedPreference.getUserID();
    var authorizationToken = UserSharedPreference.getAuthorizationToken();

    var uri = Uri.parse('${GlobalConstants.baseURL}/users/$userID/transactions')
        .replace(queryParameters: queryparams);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authorizationToken"
    };

    var response = await client.get(uri, headers: headers);

    if (response.statusCode == 200) {
      return transactionsFromJson(response.body);
    }
    return null;
  }

  Future<bool> addUserTransaction(TransactionModel transaction) async {
    var client = http.Client();

    var userID = UserSharedPreference.getUserID();
    var authorizationToken = UserSharedPreference.getAuthorizationToken();

    var uri =
        Uri.parse('${GlobalConstants.baseURL}/users/$userID/transactions');

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authorizationToken"
    };

    var body = transactionToJson(transaction);

    var response = await client.post(uri, body: body, headers: headers);

    if (response.statusCode == 202) {
      return true;
    }
    return false;
  }
}
