import 'package:budget_planner_flutter/screens/skeleton/skeleton_builder.dart';
import 'package:flutter/material.dart';

import '../../models/envelop/envelop.dart';
import '../../services/envelop/envelops.dart';

class Envelop extends StatefulWidget {
  const Envelop({Key? key}) : super(key: key);

  @override
  State<Envelop> createState() => EnvelopState();
}

class EnvelopState extends State<Envelop> {
  List<Envelops>? envelops;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getUserEnvelops();
  }

  getUserEnvelops() async {
    try {
      var response = await EnvelopService().getUserEnvelops();
      if (response != null) {
        setState(() {
          envelops = response;
          isLoaded = true;
        });
      }
    } catch (err) {
      isLoaded = true;
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: const Text("Money Wisely"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 1,
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: isLoaded ? envelops!.length : 5,
        itemBuilder: (context, index) {
          return isLoaded ? envelopCard(index) : const SkeletonCardBuilder();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("floating action button clicked");
        },
        backgroundColor: Colors.grey[800],
        child: const Icon(Icons.add),
      ),
    );
  }

  Card envelopCard(int index) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
        child: envelopListTitle(index),
      ),
    );
  }

  ListTile envelopListTitle(int index) {
    return ListTile(
      onTap: () {
        print("card keyboard right arrow pressed for ${envelops![index].name}");
      },
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      leading: Container(
        padding: const EdgeInsets.only(
          right: 12.0,
        ),
        decoration: const BoxDecoration(
          border: Border(
            right: BorderSide(
              width: 1.0,
              color: Colors.white24,
            ),
          ),
        ),
        child: const Icon(
          Icons.account_balance_wallet,
          size: 40.0,
        ),
      ),
      title: Text(
        envelops![index].name,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 15.0,
        ),
      ),
      subtitle: Text(
        envelops![index].amount.toString(),
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 12.0,
        ),
      ),
    );
  }
}
