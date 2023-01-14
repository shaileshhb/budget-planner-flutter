import 'package:budget_planner_flutter/models/envelop/transactions.dart';
import 'package:budget_planner_flutter/screens/home/dashboard.dart';
import 'package:budget_planner_flutter/screens/transaction/view_transaction.dart';
import 'package:budget_planner_flutter/services/envelop/transactions.dart';
import 'package:budget_planner_flutter/utils/user.shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/envelop/envelop.dart';
import '../../services/envelop/envelops.dart';
import '../components/custom_date_field.dart';
import '../components/custom_dropdown_field.dart';
import '../components/custom_submit_button.dart';
import '../components/custom_text_field.dart';

class AddTransaction extends StatefulWidget {
  final bool isUpdate;
  final TransactionModel? transaction;

  const AddTransaction({
    Key? key,
    this.isUpdate = false,
    this.transaction,
  }) : super(key: key);

  const AddTransaction.add({
    Key? key,
    this.isUpdate = false,
    this.transaction,
  }) : super(key: key);

  const AddTransaction.update({
    Key? key,
    this.isUpdate = true,
    required this.transaction,
  }) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final payeeController = TextEditingController();
  final amountController = TextEditingController();
  final dateController = TextEditingController();
  final transactionTypeController = TextEditingController();
  final descriptionController = TextEditingController();
  final envelopIDController = TextEditingController();
  final userIDController = TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();

  List<EnvelopModel>? envelops;
  List<String> envelopNames = [];
  List<String> envelopIDs = [];
  List<String> transactionType = ["Income", "Expense"];
  String? selectedTransactionType = "";
  String? selectedEnvelopName;

  void initializeTransactionType() {
    setState(() {
      selectedTransactionType = transactionType[0];
      if (widget.isUpdate) {
        selectedTransactionType = widget.transaction!.transactionType;
      }
    });
  }

  void processEnvelops() {
    setState(() {
      envelopNames = [];
      envelopIDs = [];
      for (var i = 0; i < envelops!.length; i++) {
        envelopNames.add(envelops![i].name);
        envelopIDs.add(envelops![i].id!);
      }

      selectedEnvelopName = envelopNames[0];

      if (widget.isUpdate) {
        selectedEnvelopName = envelopNames[
            envelopNames.indexOf(widget.transaction!.envelop!.name)];
      }
    });
  }

  void initializeEnvelop() {
    setState(() {
      envelopIDController.text = envelopIDs[0];
    });
  }

  void onTransactionTypeChange(String? transactionType) {
    setState(() {
      selectedTransactionType = transactionType;
    });
  }

  void onEnvelopChange(String? envelopName) {
    setState(() {
      var index = envelopNames.indexOf(envelopName!);
      envelopIDController.text = envelopIDs[index];
    });
  }

  @override
  void initState() {
    super.initState();
    getUserEnvelops();
    initializeTransactionType();
    setState(() {
      userIDController.text = UserSharedPreference.getUserID()!;
      if (widget.isUpdate) {
        payeeController.text = widget.transaction!.payee;
        amountController.text = widget.transaction!.amount.toString();
        dateController.text = formatDate(widget.transaction!.date);
        envelopIDController.text = widget.transaction!.envelopID;
      }
    });
  }

  String formatDate(String date) {
    return DateFormat('yyyy-MM-dd').format(DateTime.parse(date));
  }

  void getUserEnvelops() async {
    try {
      var response = await EnvelopService().getUserEnvelops();
      if (response != null) {
        setState(() {
          envelops = response;
          processEnvelops();
          initializeEnvelop();
        });
      }
    } catch (err) {
      print(err);
    }
  }

  void validateUserTransaction() {
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState!.save();
      if (widget.isUpdate) {
        updateUserTransaction(context);
        return;
      }
      addUserTransaction(context);
    }
  }

  void addUserTransaction(context) async {
    try {
      var transaction = TransactionModel(
        payee: payeeController.text,
        amount: double.parse(amountController.text),
        date: dateController.text,
        transactionType: selectedTransactionType!,
        envelopID: envelopIDController.text,
      );

      var response = await TransactionService().addUserTransaction(transaction);

      if (response) {
        _navigateToTransaction(context);
        formGlobalKey.currentState!.reset();
      }
    } catch (err) {
      print(err);
    }
  }

  void updateUserTransaction(context) async {
    try {
      var transaction = TransactionModel(
        id: widget.transaction!.id,
        payee: payeeController.text,
        amount: double.parse(amountController.text),
        date: dateController.text,
        transactionType: selectedTransactionType!,
        envelopID: envelopIDController.text,
      );

      var response =
          await TransactionService().updateUserTransaction(transaction);

      if (response) {
        _navigateToTransaction(context);
        formGlobalKey.currentState!.reset();
      }
    } catch (err) {
      print(err);
    }
  }

  void _navigateToTransaction(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Dashboard(
          selectedIndex: 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        title: Text(widget.isUpdate ? "Update Transaction" : "Add Transaction"),
        // automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 1,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formGlobalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 30),
                  Text(
                    "I am proud of you. Keep tracking your spendings!!",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: payeeController,
                    hintText: "Payee",
                    validator: (payee) {
                      if (payee!.isEmpty) {
                        return "Payee must be specified";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: amountController,
                    hintText: "Amount",
                    validator: (amount) {
                      if (amount!.isEmpty ||
                          !RegExp(r'[0-9]+$').hasMatch(amount)) {
                        return "Invalid amount specified";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomDateField(
                    controller: dateController,
                    hintText: "Date",
                    validator: (date) {
                      if (date!.isEmpty) {
                        return "Date must be specified";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomDropdownField(
                    // controller: transactionTypeController,
                    onChanged: onTransactionTypeChange,
                    items: transactionType,
                    selectedValue: selectedTransactionType,
                    hintText: "Transaction type",
                    validator: (transactionType) {
                      if (transactionType!.isEmpty) {
                        return "Transaction type must be specified";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomDropdownField(
                    // controller: transactionTypeController,
                    onChanged: onEnvelopChange,
                    items: envelops != null ? envelopNames : [],
                    hintText: "Envelop",
                    selectedValue: selectedEnvelopName,
                    validator: (envelop) {
                      if (envelop!.isEmpty) {
                        return "Envelop must be selected";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  CustomSubmitButton(
                    onTap: validateUserTransaction,
                    buttonLabel: "Save",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
