// To parse this JSON data, do
//
//     final envelops = envelopsFromJson(jsonString);

import 'dart:convert';

List<Envelops> envelopsFromJson(String str) =>
    List<Envelops>.from(json.decode(str).map((x) => Envelops.fromJson(x)));

String envelopsToJson(List<Envelops> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Envelops {
  Envelops({
    required this.id,
    required this.name,
    required this.userId,
    required this.amount,
  });

  String id;
  String name;
  String userId;
  double amount;

  factory Envelops.fromJson(Map<String, dynamic> json) => Envelops(
        id: json["id"],
        name: json["name"],
        userId: json["userID"],
        amount: json["amount"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "userID": userId,
        "amount": amount,
      };
}
