// To parse this JSON data, do
//
//     final envelops = envelopsFromJson(jsonString);

import 'dart:convert';

List<Envelops> envelopsFromJson(String str) =>
    List<Envelops>.from(json.decode(str).map((x) => Envelops.fromJson(x)));

Envelops envelopFromJson(String str) => Envelops.fromJson(json.decode(str));

String envelopsToJson(List<Envelops> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String envelopToJson(Envelops data) => json.encode(data.toJson());

class Envelops {
  Envelops({
    this.id,
    this.userId,
    required this.name,
    required this.amount,
  });

  String? id;
  String name;
  String? userId;
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
