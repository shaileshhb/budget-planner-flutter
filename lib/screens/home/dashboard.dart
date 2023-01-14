import 'package:budget_planner_flutter/screens/envelops/envelop.dart';
import 'package:budget_planner_flutter/screens/profile/profile.dart';
import 'package:budget_planner_flutter/screens/transaction/view_transaction.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  final int selectedIndex;

  const Dashboard({
    Key? key,
    this.selectedIndex = 0,
  }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    ViewEnvelop(),
    ViewTransactions(),
    Profile(),
    // Envelop(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor:
            Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor:
            Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: "Transactions",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.account_balance),
          //   label: "Accounts",
          // ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 12,
              backgroundImage: AssetImage("assets/images/user-placeholder.png"),
            ),
            label: "Profile",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      // body: const ChatPage(),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
