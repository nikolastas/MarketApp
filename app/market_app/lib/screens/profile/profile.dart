import 'package:flutter/material.dart';
import 'package:market_app/components/rounded_button.dart';
import 'package:market_app/details/colors.dart';
import 'package:market_app/screens/root/root.dart';

import '../../http/client.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: Body(),
    )
  }
}

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        RoundedButton(width: size.width*0.8, text: "Logout", press: () async {
          var response = await ApiClient().logout();
          if(response.statusCode == 200){
            Navigator.pushAndRemoveUntil(context, 
            MaterialPageRoute(builder: (context) => RootPage())
            , (route) => false);
          }
        }, textcolor: primaryBlue, backgroundColor: primaryYellow)
      ],
    );
  }
}