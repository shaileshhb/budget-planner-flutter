// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    this.dateOfBirth,
    this.gender,
    this.contact,
    this.profileImage,
    required this.isVerified,
  });

  String id;
  String name;
  String username;
  String email;
  dynamic dateOfBirth;
  dynamic gender;
  dynamic contact;
  dynamic profileImage;
  bool isVerified;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        dateOfBirth: json["dateOfBirth"],
        gender: json["gender"],
        contact: json["contact"],
        profileImage: json["profileImage"],
        isVerified: json["isVerified"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "dateOfBirth": dateOfBirth,
        "gender": gender,
        "contact": contact,
        "profileImage": profileImage,
        "isVerified": isVerified,
      };
}
