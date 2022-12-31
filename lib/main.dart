import 'package:budget_planner_flutter/screens/wrapper.dart';
import 'package:budget_planner_flutter/utils/user.shared_preference.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSharedPreference.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // title: 'Money Wisely',
      // theme: ThemeData(
      //   primarySwatch: Colors.lightBlue,
      // ),
      home: Wrapper(),
    );
  }
}
