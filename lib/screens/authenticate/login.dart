import 'package:budget_planner_flutter/screens/authenticate/components/loginButton.dart';
import 'package:budget_planner_flutter/screens/authenticate/components/loginFormField.dart';
import 'package:budget_planner_flutter/screens/authenticate/signup.dart';
import 'package:budget_planner_flutter/services/auth.dart';
import 'package:budget_planner_flutter/utils/user.shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/auth/login_request.dart';
import '../../models/auth/login_response.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // controllers for formfield
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void userLogin() async {
    try {
      var loginRequest = LoginRequest(
        username: usernameController.text,
        password: passwordController.text,
      );

      var loginResponse = await AuthenticationService().userLogin(loginRequest);

      if (loginResponse != null) {
        // store token in shared preferences.
        await UserSharedPreference.setAuthorizationToken(loginResponse.token);

        // navigate to dashboard
      }
    } catch (err) {
      print(err);
    }
  }

  void _navigateToSignup(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Register()));
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
                ),

                const SizedBox(height: 20),

                LoginFormField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),

                const SizedBox(height: 30),

                // login button
                LoginButton(onTap: userLogin, buttonLabel: "Login In"),

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
    );
  }
}
