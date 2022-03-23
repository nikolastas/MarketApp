import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:market_app/http/auth.dart';

import 'package:market_app/screens/home/home.dart';
import 'package:market_app/screens/welcome/welcome_screen.dart';

import '../../http/client.dart';

enum AuthStatus {
  notLoggedIn,
  loggedIn,
}
// handle the cookie details

// handle the root stfl page widget :)
class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus _authStatus = AuthStatus.notLoggedIn;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _authBasicMethod();
    });
  }

  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _authBasicMethod();
  }

  _authBasicMethod() async {
    String ans = await ApiClient().onStartUp();
    if (ans == "ok") {
      print("user is logged in with headers: " + ans.toString());

      setState(() {
        _authStatus = AuthStatus.loggedIn;
      });
    } else {
      setState(() {
        _authStatus = AuthStatus.notLoggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return (_authStatus == AuthStatus.loggedIn)
        ? HomeScreen()
        : WelcomeScreen();
  }
}
