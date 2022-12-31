import 'package:budget_planner_flutter/screens/authenticate/login.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // check if user is signed in or not.
    // if signed in return dashboard else return to login.

    return const Login();
  }
}
