// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.userId,
    required this.name,
    required this.email,
    required this.token,
  });

  String userId;
  String name;
  String email;
  String token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        userId: json["userID"],
        name: json["name"],
        email: json["email"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "userID": userId,
        "name": name,
        "email": email,
        "token": token,
      };
}
