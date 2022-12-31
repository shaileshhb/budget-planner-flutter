// To parse this JSON data, do
//
//     final registerRequest = registerRequestFromJson(jsonString);

import 'dart:convert';

RegisterRequest registerRequestFromJson(String str) =>
    RegisterRequest.fromJson(json.decode(str));

String registerRequestToJson(RegisterRequest data) =>
    json.encode(data.toJson());

class RegisterRequest {
  RegisterRequest({
    required this.name,
    required this.email,
    required this.username,
    required this.password,
    this.gender,
    this.contact,
    this.dateOfBirth,
    this.profileImage,
    isVerified,
  });

  String name;
  String email;
  String username;
  String password;
  String? gender;
  String? contact;
  String? dateOfBirth;
  String? profileImage;
  bool isVerified = false;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      RegisterRequest(
        name: json["name"],
        email: json["email"],
        username: json["username"],
        password: json["password"],
        gender: json["gender"],
        contact: json["contact"],
        dateOfBirth: json["dateOfBirth"],
        profileImage: json["profileImage"],
        isVerified: json["isVerified"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "username": username,
        "password": password,
        "gender": gender,
        "contact": contact,
        "dateOfBirth": dateOfBirth,
        "profileImage": profileImage,
        "isVerified": isVerified,
      };
}
