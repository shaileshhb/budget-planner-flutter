import 'package:budget_planner_flutter/screens/authenticate/login.dart';
import 'package:budget_planner_flutter/screens/home/dashboard.dart';
import 'package:budget_planner_flutter/utils/user.shared_preference.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  Wrapper({Key? key}) : super(key: key);

  final bool isLoggedIn = UserSharedPreference.getAuthorizationToken() != null;

  @override
  Widget build(BuildContext context) {
    // check if user is signed in or not.
    // if signed in return dashboard else return to login.

    return isLoggedIn ? const Dashboard() : const Login();
  }
}
