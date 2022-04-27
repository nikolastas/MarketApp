import 'package:flutter/material.dart';
import 'package:market_app/components/rounded_button.dart';
import 'package:market_app/details/colors.dart';
import 'package:market_app/screens/root/root.dart';

import '../../classes/user.dart';
import '../../http/client.dart';
import 'body.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
