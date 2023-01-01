// To parse this JSON data, do
//
//     final transactions = transactionsFromJson(jsonString);

import 'dart:convert';

import 'package:budget_planner_flutter/models/envelop/envelop.dart';

List<Transaction> transactionsFromJson(String str) => List<Transaction>.from(
    json.decode(str).map((x) => Transaction.fromJson(x)));

String transactionsToJson(List<Transaction> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String transactionToJson(Transaction data) => json.encode(data.toJson());

class Transaction {
  Transaction({
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
  Envelops? envelop;
  String envelopId;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        payee: json["payee"],
        amount: json["amount"].toDouble(),
        date: json["date"],
        transactionType: json["transactionType"],
        description: json["description"],
        envelop: Envelops.fromJson(json["envelop"]),
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
