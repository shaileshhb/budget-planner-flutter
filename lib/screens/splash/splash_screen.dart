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
    _navigateToFirstPage();
  }

  _navigateToFirstPage() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {
      bool isLoggedIn = UserSharedPreference.getAuthorizationToken() != null;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  isLoggedIn ? const Dashboard() : const Login()));
    });
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
