import 'package:flutter/material.dart';
import 'package:market_app/components/rounded_button.dart';
import 'package:market_app/details/bottom_nav_bar.dart';
import 'package:market_app/details/colors.dart';
import 'package:market_app/screens/add/add.dart';
import 'package:market_app/screens/markets/markets.dart';
import 'package:market_app/screens/profile/profile.dart';
import 'package:market_app/screens/support/support.dart';

import 'body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Widget> screens = <Widget>[
    HomeScreenBody(),
    Markets(),
    AddItem(),
    ProfileScreen(),
    SupportScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: screens.elementAt(_selectedIndex),
      bottomNavigationBar: BotNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
