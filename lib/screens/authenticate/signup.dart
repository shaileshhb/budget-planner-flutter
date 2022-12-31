import 'package:budget_planner_flutter/screens/authenticate/components/signupDropdown.dart';
import 'package:flutter/material.dart';

import 'components/loginFormField.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final genderController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final contactController = TextEditingController();

  final genderList = ["Male", "Female", "Other"];

  genderListState() {
    selectedValue = genderList[0];
  }

  String? selectedValue = "";

  onGenderChange(String? gender) {
    setState(() {
      selectedValue = gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // const SizedBox(height: 25),

              // logo
              const Icon(
                Icons.lock,
                size: 60,
              ),

              const SizedBox(height: 20),

              // welcome message
              Text(
                "Welcome back! you've been missed!",
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
              ),

              const SizedBox(height: 10),

              LoginFormField(
                controller: usernameController,
                hintText: "Username",
                obscureText: false,
              ),

              const SizedBox(height: 10),

              LoginFormField(
                controller: emailController,
                hintText: "Email",
                obscureText: false,
              ),

              const SizedBox(height: 10),

              LoginFormField(
                controller: passwordController,
                hintText: "Password",
                obscureText: true,
              ),

              const SizedBox(height: 10),

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
              ),

              const SizedBox(height: 10),

              LoginFormField(
                controller: contactController,
                hintText: "Contact",
                obscureText: false,
              ),

              const SizedBox(height: 10),

              LoginFormField(
                controller: dateOfBirthController,
                hintText: "Date of birth",
                obscureText: false,
              ),

              const SizedBox(height: 20),

              // login button
              // LoginButton(onTap: userLogin),

              const SizedBox(height: 30),

              // redirect to register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Color.fromRGBO(97, 97, 97, 1),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Register Now",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
