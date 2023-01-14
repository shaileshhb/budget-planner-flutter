// To parse this JSON data, do
//
//     final transactions = transactionsFromJson(jsonString);

import 'dart:convert';

import 'package:budget_planner_flutter/models/envelop/envelop.dart';

List<TransactionModel> transactionsFromJson(String str) =>
    List<TransactionModel>.from(
        json.decode(str).map((x) => TransactionModel.fromJson(x)));

String transactionsToJson(List<TransactionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String transactionToJson(TransactionModel data) => json.encode(data.toJson());

class TransactionModel {
  TransactionModel({
    this.id,
    this.description,
    this.envelop,
    required this.payee,
    required this.amount,
    required this.date,
    required this.transactionType,
    required this.envelopId,
  });

  String? id;
  String payee;
  double amount;
  String date;
  String transactionType;
  dynamic description;
  EnvelopModel? envelop;
  String envelopId;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json["id"],
        payee: json["payee"],
        amount: json["amount"].toDouble(),
        date: json["date"],
        transactionType: json["transactionType"],
        description: json["description"],
        envelop: EnvelopModel.fromJson(json["envelop"]),
        envelopId: json["envelopID"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "payee": payee,
        "amount": amount,
        "date": date,
        "transactionType": transactionType,
        "description": description,
        "envelop": envelop == null ? null : envelop!.toJson(),
        "envelopID": envelopId,
      };
}
