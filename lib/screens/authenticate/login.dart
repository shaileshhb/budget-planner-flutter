import 'package:budget_planner_flutter/screens/authenticate/components/login_button.dart';
import 'package:budget_planner_flutter/screens/authenticate/components/login_form_field.dart';
import 'package:budget_planner_flutter/screens/authenticate/signup.dart';
import 'package:budget_planner_flutter/services/auth/auth.dart';
import 'package:budget_planner_flutter/utils/user.shared_preference.dart';
import 'package:flutter/material.dart';

import '../../models/auth/login_request.dart';
import '../home/dashboard.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // controllers for formfield
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();

  void validateUserLogin() {
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState!.save();
      userLogin();
    }
  }

  void userLogin() async {
    try {
      var loginRequest = LoginRequest(
        username: usernameController.text,
        password: passwordController.text,
      );

      var loginResponse = await AuthenticationService().userLogin(loginRequest);

      if (loginResponse != null) {
        // store token in shared preferences.
        _setAuthorizationToken(loginResponse.token);
        _setUserID(loginResponse.userId);

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

  void _setUserID(String userID) async {
    await UserSharedPreference.setUserID(userID);
  }

  void _navigateToSignup(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Register()));
  }

  void _navigateToDashboard(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Dashboard()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formGlobalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 50),

                  // logo
                  const Icon(
                    Icons.lock,
                    size: 100,
                  ),

                  const SizedBox(height: 50),

                  // welcome message
                  Text(
                    "Welcome back! you've been missed!",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 50),

                  // username, password
                  LoginFormField(
                    controller: usernameController,
                    hintText: "Username",
                    obscureText: false,
                    validator: (username) {
                      if (username!.isEmpty ||
                          !RegExp(r'^[a-z A-Z]+$').hasMatch(username)) {
                        return "Invalid username";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  LoginFormField(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true,
                    validator: (password) {
                      if (password!.isEmpty || password.length < 6) {
                        return "Invalid password";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 30),

                  // login button
                  LoginButton(
                    onTap: validateUserLogin,
                    buttonLabel: "LogIn",
                  ),

                  const SizedBox(height: 200),

                  // redirect to register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Color.fromRGBO(97, 97, 97, 1),
                        ),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () => _navigateToSignup(context),
                        child: const Text(
                          "Register Now",
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
      ),
    );
  }
}
