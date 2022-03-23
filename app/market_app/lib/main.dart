import 'package:flutter/material.dart';
import 'package:market_app/screens/root/root.dart';
import 'package:market_app/screens/welcome/welcome_screen.dart';
import 'details/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'MarketApp';

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyApp._title,
      theme: ThemeData(
        primaryColor: primaryGrey,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: RootPage(),
    );
  }
}
