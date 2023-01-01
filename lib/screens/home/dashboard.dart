import 'package:budget_planner_flutter/models/envelop/envelop.dart';
import 'package:budget_planner_flutter/screens/home/components/skeleton_container.dart';
import 'package:budget_planner_flutter/services/envelop/envelop.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
      bottomNavigationBar: SizedBox(
        height: 50.0,
        child: BottomAppBar(
          color: Colors.grey[500],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  print("clicked on home");
                },
                icon: const Icon(
                  Icons.home,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  print("clicked on money");
                },
                icon: const Icon(
                  Icons.money,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  print("clicked on account");
                },
                icon: const Icon(
                  Icons.account_balance,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: isLoaded ? envelops!.length : 5,
        itemBuilder: (context, index) {
          return isLoaded ? envelopCard(index) : buildSkeleton(context);
        },
      ),
    );
  }

  Widget buildSkeleton(BuildContext context) => skeletonEnvelopCard();

  Card skeletonEnvelopCard() {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
        child: skeletonEnvelopList(),
      ),
    );
  }

  ListTile skeletonEnvelopList() {
    return ListTile(
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
        child: const Icon(Icons.account_balance_wallet),
      ),
      title: EnvelopSkeleton.square(
        width: MediaQuery.of(context).size.width * 0.6,
        height: 15.0,
      ),
      subtitle: EnvelopSkeleton.square(
        width: MediaQuery.of(context).size.width * 0.2,
        height: 12.0,
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
        child: const Icon(Icons.account_balance_wallet),
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
