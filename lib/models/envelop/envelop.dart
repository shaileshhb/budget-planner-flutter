// To parse this JSON data, do
//
//     final envelops = envelopsFromJson(jsonString);

import 'dart:convert';

List<EnvelopModel> envelopsFromJson(String str) => List<EnvelopModel>.from(
    json.decode(str).map((x) => EnvelopModel.fromJson(x)));

EnvelopModel envelopFromJson(String str) =>
    EnvelopModel.fromJson(json.decode(str));

String envelopsToJson(List<EnvelopModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String envelopToJson(EnvelopModel data) => json.encode(data.toJson());

class EnvelopModel {
  EnvelopModel({
    this.id,
    this.userId,
    required this.name,
    required this.amount,
    this.amountSpent,
  });

  String? id;
  String name;
  String? userId;
  double amount;
  double? amountSpent;

  factory EnvelopModel.fromJson(Map<String, dynamic> json) => EnvelopModel(
        id: json["id"],
        name: json["name"],
        userId: json["userID"],
        amount: json["amount"].toDouble(),
        amountSpent: json["amountSpent"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "userID": userId,
        "amount": amount,
        "amountSpent": amountSpent,
      };
}
