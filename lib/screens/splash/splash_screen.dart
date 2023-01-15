import 'package:budget_planner_flutter/services/auth/auth.dart';
import 'package:flutter/material.dart';

import '../../utils/user.shared_preference.dart';
import '../authenticate/login.dart';
import '../home/dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    try {
      var response = await AuthenticationService().getUser();

      if (response != null) {
        _navigateToDashboard();
        return;
      }
      _navigateToLogin();
    } catch (err) {
      print(err);
      _navigateToLogin();
    }
  }

  void _navigateToDashboard() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const Dashboard(selectedIndex: 0)));
  }

  _navigateToLogin() async {
    // await Future.delayed(const Duration(milliseconds: 1500), () {
    // });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text(
        "Money Wisely",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    ));
  }
}
