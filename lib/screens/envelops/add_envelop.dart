import 'package:budget_planner_flutter/models/envelop/envelop.dart';
import 'package:budget_planner_flutter/screens/envelops/envelop.dart';
import 'package:budget_planner_flutter/services/envelop/envelops.dart';
import 'package:flutter/material.dart';

import '../../utils/user.shared_preference.dart';
import '../components/custom_submit_button.dart';
import '../components/custom_text_field.dart';

class AddEnvelop extends StatefulWidget {
  const AddEnvelop({Key? key}) : super(key: key);

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
    });
  }

  validateUserEnvelop() {
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState!.save();
      addUserEnvelop(context);
    }
  }

  void addUserEnvelop(context) async {
    try {
      var envelop = Envelops(
        amount: double.parse(amountController.text),
        name: nameController.text,
      );

      var response = await EnvelopService().addUserEnvelop(envelop);

      if (response) {
        _navigateToViewEnvelop(context);
        formGlobalKey.currentState!.reset();
      }
    } catch (err) {
      print(err);
    }
  }

  void _navigateToViewEnvelop(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ViewEnvelop()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        title: const Text("Add Envelop"),
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
