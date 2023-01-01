import 'package:budget_planner_flutter/models/envelop/transactions.dart';
import 'package:budget_planner_flutter/screens/transaction/view_transaction.dart';
import 'package:budget_planner_flutter/services/envelop/transactions.dart';
import 'package:budget_planner_flutter/utils/user.shared_preference.dart';
import 'package:flutter/material.dart';

import '../../models/envelop/envelop.dart';
import '../../services/envelop/envelops.dart';
import '../components/custom_date_field.dart';
import '../components/custom_dropdown_field.dart';
import '../components/custom_submit_button.dart';
import '../components/custom_text_field.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

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

  List<Envelops>? envelops;
  List<String> envelopNames = [];
  List<String> envelopIds = [];
  List<String> transactionType = ["Income", "Expense"];
  String? selectedTransactionType = "";
  String? selectedEnvelopId;

  void initializeTransactionType() {
    setState(() {
      selectedTransactionType = transactionType[0];
    });
  }

  void processEnvelops() {
    setState(() {
      envelopNames = [];
      envelopIds = [];
      for (var i = 0; i < envelops!.length; i++) {
        envelopNames.add(envelops![i].name);
        envelopIds.add(envelops![i].id!);
      }
    });
  }

  void initializeEnvelop() {
    setState(() {
      selectedEnvelopId = envelopIds[0];
      envelopIDController.text = selectedEnvelopId!;
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
      selectedEnvelopId = envelopIds[index];
      envelopIDController.text = selectedEnvelopId!;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserEnvelops();
    initializeTransactionType();
    setState(() {
      userIDController.text = UserSharedPreference.getUserID()!;
    });
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
      addUserTransaction(context);
    }
  }

  void addUserTransaction(context) async {
    try {
      var transaction = Transaction(
        payee: payeeController.text,
        amount: double.parse(amountController.text),
        date: dateController.text,
        transactionType: selectedTransactionType!,
        envelopId: envelopIDController.text,
      );

      var response = await TransactionService().addUserTransaction(transaction);

      if (response) {
        _navigateToViewTransaction(context);
        formGlobalKey.currentState!.reset();
      }

      print(transaction);
    } catch (err) {
      print(err);
    }
  }

  void _navigateToViewTransaction(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ViewTransactions()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: const Text("Add Transaction"),
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
                    "I am proud of you. Keep tracking your spenings!!",
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
