import 'package:budget_planner_flutter/models/envelop/transactions.dart';
import 'package:budget_planner_flutter/services/envelop/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../skeleton/skeleton_builder.dart';
import 'add_transaction.dart';

class ViewTransactions extends StatefulWidget {
  const ViewTransactions({Key? key}) : super(key: key);

  @override
  State<ViewTransactions> createState() => _ViewTransactionsState();
}

class _ViewTransactionsState extends State<ViewTransactions> {
  List<Transaction>? transactions;
  bool isLoaded = false;
  int monthIndex = 0;

  getUserTransactions() async {
    // get user transactions
    try {
      DateTime date = DateTime.now();
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      DateTime toDate = DateTime(date.year, date.month + (monthIndex + 1), 0);
      DateTime fromDate = DateTime(date.year, date.month + monthIndex, 1);

      var queryparams = {
        'fromDate': formatter.format(fromDate),
        'toDate': formatter.format(toDate),
      };

      var response =
          await TransactionService().getUserTransactions(queryparams);
      if (response != null) {
        setState(() {
          transactions = response;
          print("transactions -> $transactions");
          isLoaded = true;
          return;
        });
      }
      setState(() {
        isLoaded = true;
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  void initState() {
    super.initState();
    getUserTransactions();
  }

  void _navigateToAddTransaction(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AddTransaction()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: isLoaded ? transactions!.length : 10,
          itemBuilder: (context, index) {
            return isLoaded
                ? transactionCard(index)
                : const SkeletonCardBuilder();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddTransaction(context);
        },
        backgroundColor: Colors.grey[800],
        child: const Icon(Icons.add),
      ),
    );
  }

  Card transactionCard(int index) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
        child: transactionsListTitle(index),
      ),
    );
  }

  ListTile transactionsListTitle(int index) {
    return ListTile(
      onTap: () {
        print(
            "card keyboard right arrow pressed for ${transactions![index].id}");
      },
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      leading: Container(
        padding: const EdgeInsets.only(
          right: 12.0,
        ),
        decoration: const BoxDecoration(
          border: Border(
            right: BorderSide(
              width: 1.0,
              color: Colors.white24,
            ),
          ),
        ),
        child: const Icon(
          Icons.monetization_on,
          size: 40.0,
        ),
      ),
      title: Text(
        transactions![index].payee,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 15.0,
        ),
      ),
      subtitle: Text(
        transactions![index].amount.toString(),
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 12.0,
        ),
      ),
    );
  }
}
