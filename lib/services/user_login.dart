import 'package:budget_planner_flutter/models/login_request.dart';
import 'package:budget_planner_flutter/models/login_response.dart';
import 'package:http/http.dart' as http;

class AuthenticationService {
  Future<LoginResponse?> userLogin(LoginRequest login) async {
    var client = http.Client();

    var uri = Uri.parse(
        'https://budget-planner-2n99.onrender.com/api/v1/budget-planner/login');

    var response = await client.post(uri,
        body: login.toJson(), headers: {"Content-type": "application/json"});

    if (response.statusCode == 200) {
      var json = response.body;
      return loginResponseFromJson(json);
    }
    return null;
  }
}
