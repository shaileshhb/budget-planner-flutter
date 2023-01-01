import 'package:budget_planner_flutter/models/auth/user.dart';
import 'package:budget_planner_flutter/screens/authenticate/components/signup_dropdown.dart';
import 'package:budget_planner_flutter/services/auth/auth.dart';
import 'package:flutter/material.dart';

import '../authenticate/components/date_of_birth.dart';
import '../authenticate/components/login_button.dart';
import '../authenticate/components/login_form_field.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final genderController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final contactController = TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();

  final genderList = ["Select gender", "Male", "Female", "Other"];

  genderListState() {
    selectedValue = genderList[0];
  }

  String? selectedValue = "";

  onGenderChange(String? gender) {
    setState(() {
      selectedValue = gender;
    });
  }

  User? user;

  getUser() async {
    try {
      var response = await AuthenticationService().getUser();
      if (response != null) {
        setState(() {
          user = response;

          nameController.text = user!.name;
          usernameController.text = user!.username;
          emailController.text = user!.email;
          contactController.text = user!.contact;
          dateOfBirthController.text = user!.dateOfBirth;
          genderController.text = user!.gender ?? genderList[0];
        });
      }
    } catch (err) {
      print(err);
    }
  }

  void validateUserRegister() {
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState!.save();
      updateUser();
    }
  }

  void updateUser() async {
    try {
      var userDetails = User(
        id: user!.id,
        name: nameController.text,
        email: emailController.text,
        username: usernameController.text,
        contact: contactController.text,
        gender: selectedValue,
        dateOfBirth: dateOfBirthController.text,
        isVerified: user!.isVerified,
      );

      var loginResponse = await AuthenticationService().updateUser(userDetails);

      if (loginResponse != null) {
        // successfully update user
        getUser();
      }
    } catch (err) {
      print(err);
    }
  }

  // void _navigateToDashboard(BuildContext context) {
  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (context) => const Dashboard()));
  // }

  @override
  void initState() {
    super.initState();
    genderListState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: const Text("Money Wisely"),
        automaticallyImplyLeading: false,
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
                  const SizedBox(height: 50),

                  // // logo
                  // const Icon(
                  //   Icons.lock,
                  //   size: 60,
                  // ),

                  const SizedBox(height: 20),

                  // welcome message
                  Text(
                    user != null ? "Welcome! ${user!.name}" : "Welcome!",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // register form
                  LoginFormField(
                    controller: nameController,
                    hintText: "Name",
                    obscureText: false,
                    validator: (name) {
                      if (name!.isEmpty ||
                          !RegExp(r'[a-zA-Z ]+$').hasMatch(name)) {
                        return "Invalid name";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 15),

                  LoginFormField(
                    controller: usernameController,
                    hintText: "Username",
                    obscureText: false,
                    validator: (username) {
                      if (username!.isEmpty ||
                          !RegExp(r'[a-zA-Z0-9]+$').hasMatch(username)) {
                        return "Invalid username";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 15),

                  LoginFormField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false,
                    validator: (email) {
                      if (email!.isEmpty) {
                        return "Invalid email";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 15),

                  // LoginFormField(
                  //   controller: genderController,
                  //   hintText: "Gender",
                  //   obscureText: false,
                  // ),

                  // controller: genderController,
                  DropdownField(
                    items: genderList,
                    selectedValue: selectedValue,
                    hintText: "Gender",
                    onChanged: onGenderChange,
                    validator: null,
                  ),

                  const SizedBox(height: 15),

                  LoginFormField(
                    controller: contactController,
                    hintText: "Contact",
                    obscureText: false,
                    validator: null,
                  ),

                  const SizedBox(height: 15),

                  // LoginFormField(
                  // controller: dateOfBirthController,
                  // hintText: "Date of birth",
                  //   obscureText: false,
                  // ),

                  DateOfBirthField(
                    controller: dateOfBirthController,
                    hintText: "Date of birth",
                  ),

                  const SizedBox(height: 20),

                  // login button
                  LoginButton(
                    onTap: validateUserRegister,
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
