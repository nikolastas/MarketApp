import 'package:flutter/material.dart';
import 'package:market_app/details/colors.dart';
import 'package:market_app/screens/Login/login_screen.dart';
import 'package:market_app/screens/singup/signup_screen.dart';

import '../../components/rounded_button.dart';
import 'background.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to the MarketApp",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            Icon(
              Icons.shopping_cart,
              size: 100,
              color: secondaryPink,
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            RoundedButton(
              width: size.width * 0.8,
              text: "Login",
              backgroundColor: Colors.indigo,
              textcolor: Colors.white,
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }));
              },
            ),
            RoundedButton(
                width: size.width * 0.8,
                text: "Sign up",
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SignupScreen();
                  }));
                },
                textcolor: Colors.black,
                backgroundColor: primaryGrey)
          ],
        ),
      ),
    );
  }
}
