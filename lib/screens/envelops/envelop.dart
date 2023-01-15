import 'package:budget_planner_flutter/screens/envelops/add_envelop.dart';
import 'package:budget_planner_flutter/screens/skeleton/skeleton_builder.dart';
import 'package:flutter/material.dart';

import '../../models/envelop/envelop.dart';
import '../../services/envelop/envelops.dart';

class ViewEnvelop extends StatefulWidget {
  const ViewEnvelop({Key? key}) : super(key: key);

  @override
  State<ViewEnvelop> createState() => ViewEnvelopState();
}

class ViewEnvelopState extends State<ViewEnvelop> {
  List<EnvelopModel>? envelops;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      envelops = [];
    });
    getUserEnvelops();
  }

  getUserEnvelops() async {
    try {
      var response = await EnvelopService().getUserEnvelops();
      print("response -> $response");
      if (response != null) {
        setState(() {
          envelops = response;
        });

        // if (mounted) {
        //   const message = "Envelops fetched";
        //   const snackBar = SnackBar(content: Text(message));

        //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // }
      }
    } catch (err) {
      print(err);
    } finally {
      setState(() {
        isLoaded = true;
      });
    }
  }

  void _navigateToAddEnvelop(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const AddEnvelop.add(isUpdate: false)));
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
        //
        child: isLoaded && envelops != null && envelops!.isEmpty
            ? const Center(
                child: Text(
                  "No Envelops found!!",
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: isLoaded ? envelops!.length : 5,
                itemBuilder: (context, index) {
                  return isLoaded
                      ? envelopCard(index)
                      : const SkeletonCardBuilder();
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
                      const Color(0xFF9FC97F),
                      const Color(0xFF54B435),
                    ]
                  : ((envelops![index].amountSpent! / envelops![index].amount) *
                              100 <=
                          75.0)
                      ? [const Color(0xFFFFE988), const Color(0xFFF49D1A)]
                      : [const Color(0xFFFF8B8B), const Color(0xFFEB4747)],
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

  void _navigateToUpdateEnvelop(BuildContext context, EnvelopModel envelop) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEnvelop.update(
          isUpdate: true,
          envelop: envelop,
        ),
      ),
    );
  }

  ListTile envelopListTitle(int index) {
    return ListTile(
      onTap: () {
        // print("card keyboard right arrow pressed for ${envelops![index].name}");
        _navigateToUpdateEnvelop(context, envelops![index]);
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
      trailing: Container(
        padding: const EdgeInsets.only(
          right: 12.0,
        ),
        // decoration: const BoxDecoration(
        // ),
        child: IconButton(
          onPressed: () => onDeleteEnvelopClick(envelops![index].id!),
          icon: const Icon(Icons.delete),
          color: const Color(0xFFDB0F00),
          iconSize: 30.0,
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
        "Amount Left: ${(envelops![index].amount - envelops![index].amountSpent!).toString()}",
        style: const TextStyle(
          color: Colors.black,
          fontSize: 12.0,
        ),
      ),
    );
  }

  void onDeleteEnvelopClick(String envelopID) {
    // print("onDeleteEnvelopClick");
    deleteUserEnvelop(envelopID);
  }

  void deleteUserEnvelop(String envelopID) async {
    try {
      var response = await EnvelopService().deleteUserEnvelop(envelopID);

      if (response) {
        setState(() {
          envelops = [];
          isLoaded = false;
          getUserEnvelops();
        });
      }
    } catch (err) {
      print(err);
    }
  }
}
