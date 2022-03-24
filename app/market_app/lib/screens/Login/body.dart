import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:market_app/classes/user.dart';
import 'package:market_app/components/rounded_button.dart';
import 'package:market_app/details/colors.dart';

import 'package:market_app/http/auth.dart';
import 'package:market_app/http/client.dart';
import 'package:market_app/screens/home/home.dart';
import 'package:market_app/screens/root/root.dart';
import 'package:market_app/screens/singup/signup_screen.dart';

import '../../components/already_have_an_account_check.dart';
import '../../components/rounded_input_field.dart';
import '../../components/rounded_password_field.dart';
import '../../components/text_field_container.dart';
import '../login/background.dart';

class Body extends StatefulWidget {
  Body({
    Key? key,
    this.currentUser,
  }) : super(key: key);
  late User? currentUser;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.shopping_cart,
              size: size.width * 0.3,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            RoundedInputField(
                controller: usernameController,
                width: size.width * 0.8,
                color: primaryGrey,
                icon: Icon(
                  Icons.person,
                  color: secondaryBlack,
                ),
                hintText: "Your username",
                onChanged: (value) {}),
            RoundedPasswordField(
              controller: passwordController,
              width: size.width * 0.8,
              onChanged: (value) {},
            ),
            RoundedButton(
                width: size.width * 0.8,
                text: "Login",
                press: () async {
                  var response = await ApiClient()
                      .login(usernameController.text, passwordController.text);
                  if (response.statusCode == 200) {
                    print(response);

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => RootPage()),
                        (route) => false);
                  } else {
                    print(response.statusCode);
                    print("error with login");
                  }
                },
                textcolor: Colors.white,
                backgroundColor: Colors.indigo),
            AlreadyHaveAnAccountCheck(
                login: true,
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SignupScreen();
                  }));
                },
                color: Colors.indigo)
          ],
        ),
      ),
    );
  }
}
