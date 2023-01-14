import 'package:budget_planner_flutter/models/envelop/envelop.dart';
import 'package:budget_planner_flutter/screens/home/dashboard.dart';
import 'package:budget_planner_flutter/services/envelop/envelops.dart';
import 'package:flutter/material.dart';

import '../../utils/user.shared_preference.dart';
import '../components/custom_submit_button.dart';
import '../components/custom_text_field.dart';

class AddEnvelop extends StatefulWidget {
  final bool isUpdate;
  final EnvelopModel? envelop;

  const AddEnvelop({
    Key? key,
    this.isUpdate = false,
    this.envelop,
  }) : super(key: key);

  const AddEnvelop.add({
    Key? key,
    this.isUpdate = false,
    this.envelop,
  }) : super(key: key);

  const AddEnvelop.update({
    Key? key,
    this.isUpdate = true,
    required this.envelop,
  }) : super(key: key);

  @override
  State<AddEnvelop> createState() => _AddEnvelopState();
}

class _AddEnvelopState extends State<AddEnvelop> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final userIDController = TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      userIDController.text = UserSharedPreference.getUserID()!;
      if (widget.isUpdate) {
        print(widget.envelop!.toJson());
        nameController.text = widget.envelop!.name;
        amountController.text = widget.envelop!.amount.toString();
      }
    });
  }

  validateUserEnvelop() {
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState!.save();
      if (widget.isUpdate) {
        updateUserEnvelop(context);
        return;
      }
      addUserEnvelop(context);
    }
  }

  void addUserEnvelop(BuildContext context) async {
    try {
      var envelop = EnvelopModel(
        amount: double.parse(amountController.text),
        name: nameController.text,
      );

      var response = await EnvelopService().addUserEnvelop(envelop);

      if (response) {
        if (mounted) {
          _navigateToViewEnvelop(context);
        }
        formGlobalKey.currentState!.reset();
      }
    } catch (err) {
      print(err);
    }
  }

  void updateUserEnvelop(BuildContext context) async {
    try {
      var envelop = EnvelopModel(
        id: widget.envelop!.id,
        amount: double.parse(amountController.text),
        name: nameController.text,
      );

      var response = await EnvelopService().updateUserEnvelop(envelop);

      if (response) {
        if (mounted) {
          _navigateToViewEnvelop(context);
        }
        formGlobalKey.currentState!.reset();
      }
    } catch (err) {
      print(err);
    }
  }

  void _navigateToViewEnvelop(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Dashboard(selectedIndex: 0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        title: Text(widget.isUpdate ? "Update Envelop" : "Add Envelop"),
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
                    "Woah!! This is just the beginning!!",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: nameController,
                    hintText: "Name",
                    validator: (payee) {
                      if (payee!.isEmpty) {
                        return "Name must be specified";
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
                  const SizedBox(height: 30),
                  CustomSubmitButton(
                    onTap: validateUserEnvelop,
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
