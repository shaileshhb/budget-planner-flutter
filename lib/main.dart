import 'package:budget_planner_flutter/screens/wrapper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Wisely',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const Wrapper(),
    );
  }
}
