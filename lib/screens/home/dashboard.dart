import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(108, 189, 255, 1),
        title: const Text("Money Wisely"),
        centerTitle: true,
        elevation: 1,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text("Welcome to Money wisely"),
        ],
      ),
    );
  }
}
