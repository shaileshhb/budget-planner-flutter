import 'package:budget_planner_flutter/screens/authenticate/components/loginButton.dart';
import 'package:budget_planner_flutter/screens/authenticate/components/loginFormField.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // controllers for formfield
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void userLogin() {
    try {} catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: const Color.fromRGBO(108, 189, 255, 1),
    //     title: const Text("Money Wisely"),
    //     centerTitle: true,
    //     elevation: 1,
    //   ),
    //   body: Stack(
    //     children: <Widget>[
    //       Container(
    //         decoration: const BoxDecoration(
    //           image: DecorationImage(
    //             image: AssetImage("images/coins.jpg"),
    //             fit: BoxFit.cover,
    //           ),
    //         ),
    //       ),
    //       const Center(
    //         child: Card(
    //           elevation: 2,
    //         ),
    //       ),
    //     ],
    //   ),
    // );

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

              const SizedBox(height: 10),

              LoginFormField(
                controller: passwordController,
                hintText: "Password",
                obscureText: true,
              ),

              const SizedBox(height: 25),

              // login button
              LoginButton(onTap: userLogin),

              const SizedBox(height: 200),

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
