import 'bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'colors.dart';
import 'items.dart';
import 'markets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'MarketApp';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  // _MyStatefulWidgetState();
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 12,
    fontFamily: 'Roboto',
  );
  var paidStatus = true;
  late List screens = [Items(), markets()];
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Items',
      style: optionStyle,
    ),
    Text(
      'Markets',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryGrey,
      body: screens.elementAt(_selectedIndex),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomMenu(
        selectedIndex: _selectedIndex,
        onClicked: _onItemTapped,
      ),
    );
  }
}
