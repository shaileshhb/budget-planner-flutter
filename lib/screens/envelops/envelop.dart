import 'package:budget_planner_flutter/screens/envelops/add_envelop.dart';
import 'package:budget_planner_flutter/screens/skeleton/skeleton_builder.dart';
import 'package:flutter/material.dart';

import '../../models/envelop/envelop.dart';
import '../../services/envelop/envelops.dart';
import '../transaction/add_transaction.dart';

class ViewEnvelop extends StatefulWidget {
  const ViewEnvelop({Key? key}) : super(key: key);

  @override
  State<ViewEnvelop> createState() => ViewEnvelopState();
}

class ViewEnvelopState extends State<ViewEnvelop> {
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

  void _navigateToAddEnvelop(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AddEnvelop()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        title: const Text("Money Wisely"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 1,
      ),
      body: SafeArea(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: isLoaded ? envelops!.length : 5,
          itemBuilder: (context, index) {
            return isLoaded ? envelopCard(index) : const SkeletonCardBuilder();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddEnvelop(context);
        },
        backgroundColor: Colors.blueGrey[400],
        child: const Icon(Icons.add),
      ),
    );
  }

  Card envelopCard(int index) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.all(10.0),
      child: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            gradient: LinearGradient(
              colors: ((envelops![index].amountSpent! /
                              envelops![index].amount) *
                          100 <=
                      50.0)
                  ? [
                      const Color.fromARGB(255, 125, 219, 161),
                      const Color.fromARGB(255, 121, 221, 166)
                    ]
                  : ((envelops![index].amountSpent! / envelops![index].amount) *
                              100 <=
                          75.0)
                      ? [
                          const Color.fromARGB(255, 241, 241, 78),
                          const Color.fromARGB(255, 241, 241, 71)
                        ]
                      : [Colors.pink, Colors.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color:
                    ((envelops![index].amountSpent! / envelops![index].amount) *
                                100 <=
                            50.0)
                        ? Colors.green
                        : ((envelops![index].amountSpent! /
                                        envelops![index].amount) *
                                    100 <=
                                75.0)
                            ? Colors.yellow
                            : Colors.red,
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
            // color: Colors.blueGrey[300],
          ),
          child: envelopListTitle(index),
        ),
      ]),
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
          color: Colors.black,
          fontSize: 12.0,
        ),
      ),
    );
  }
}
