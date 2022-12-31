import 'package:budget_planner_flutter/models/auth/register_request.dart';
import 'package:budget_planner_flutter/screens/authenticate/components/signup_dropdown.dart';
import 'package:budget_planner_flutter/screens/authenticate/login.dart';
import 'package:budget_planner_flutter/screens/home/dashboard.dart';
import 'package:budget_planner_flutter/services/auth.dart';
import 'package:flutter/material.dart';

import '../../utils/user.shared_preference.dart';
import 'components/date_of_birth.dart';
import 'components/login_button.dart';
import 'components/login_form_field.dart';

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

  void userRegister() async {
    try {
      var userDetails = RegisterRequest(
        name: nameController.text,
        email: emailController.text,
        username: usernameController.text,
        password: passwordController.text,
        contact: contactController.text,
        gender: selectedValue,
        dateOfBirth: dateOfBirthController.text,
      );

      var loginResponse = await AuthenticationService().register(userDetails);

      if (loginResponse != null) {
        // store token in shared preferences.
        _setAuthorizationToken(loginResponse.token);

        // navigate to dashboard
        if (mounted) {
          _navigateToDashboard(context);
        }
      }
    } catch (err) {
      print(err);
    }
  }

  void _setAuthorizationToken(String token) async {
    await UserSharedPreference.setAuthorizationToken(token);
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }

  void _navigateToDashboard(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Dashboard()));
  }

  @override
  void initState() {
    super.initState();
    genderListState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
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
                  "Welcome! Start tracking your spending!!",
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

                const SizedBox(height: 15),

                LoginFormField(
                  controller: usernameController,
                  hintText: "Username",
                  obscureText: false,
                ),

                const SizedBox(height: 15),

                LoginFormField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),

                const SizedBox(height: 15),

                LoginFormField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
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
                ),

                const SizedBox(height: 15),

                LoginFormField(
                  controller: contactController,
                  hintText: "Contact",
                  obscureText: false,
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
                LoginButton(onTap: userRegister, buttonLabel: "Register"),

                const SizedBox(height: 30),

                // redirect to register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Color.fromRGBO(97, 97, 97, 1),
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () => _navigateToLogin(context),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
