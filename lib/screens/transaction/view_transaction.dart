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
  List<TransactionModel>? transactions;
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
          isLoaded = true;
          return;
        });
      }
    } catch (err) {
      print(err);
    } finally {
      setState(() {
        isLoaded = true;
      });
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
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        title: const Text("Money Wisely"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 1,
      ),
      body: SafeArea(
        child: isLoaded && transactions != null && transactions!.isEmpty
            ? const Center(
                child: Text(
                  "No Transactions found!!",
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
              )
            : ListView.builder(
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
        backgroundColor: Colors.blueGrey[400],
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
          color: Colors.grey[200],
        ),
        child: transactionsListTitle(index),
      ),
    );
  }

  void _navigateToUpdateTransaction(
      BuildContext context, TransactionModel transaction) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTransaction.update(
          isUpdate: true,
          transaction: transaction,
        ),
      ),
    );
  }

  ListTile transactionsListTitle(int index) {
    return ListTile(
      onTap: () {
        // print("card keyboard right arrow pressed for ${transactions![index].id}");
        _navigateToUpdateTransaction(context, transactions![index]);
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
      trailing: Container(
        padding: const EdgeInsets.only(
          right: 12.0,
        ),
        // decoration: const BoxDecoration(
        // ),
        child: IconButton(
          onPressed: () => onDeleteTransactionClick(transactions![index].id!),
          icon: const Icon(Icons.delete),
          color: const Color(0xFFDB0F00),
          iconSize: 30.0,
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
          color: Colors.blueGrey,
          fontSize: 12.0,
        ),
      ),
    );
  }

  void onDeleteTransactionClick(String transactionID) {
    deleteUserTransaction(transactionID);
  }

  void deleteUserTransaction(String transactionID) async {
    try {
      var response =
          await TransactionService().deleteUserTransaction(transactionID);

      if (response) {
        setState(() {
          transactions = [];
          isLoaded = false;
          getUserTransactions();
        });
      }
    } catch (err) {
      print(err);
    }
  }
}
