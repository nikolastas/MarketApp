import 'package:flutter/material.dart';
import 'package:market_app/http/auth.dart';

import '../../components/already_have_an_account_check.dart';
import '../../components/rounded_button.dart';
import '../../components/rounded_input_field.dart';

import '../../components/rounded_password_field.dart';
import '../../details/colors.dart';
import '../Login/login_screen.dart';
import 'background.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    final groupController = TextEditingController();
    final emailController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return Background(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Sign Up"),
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
              icon: Icon(Icons.person),
              hintText: "Username",
              onChanged: (value) {}),
          RoundedInputField(
              controller: emailController,
              width: size.width * 0.8,
              color: primaryGrey,
              icon: Icon(Icons.email),
              hintText: "Email",
              onChanged: (value) {}),
          RoundedInputField(
              controller: groupController,
              width: size.width * 0.8,
              color: primaryGrey,
              icon: Icon(Icons.group),
              hintText: "Group",
              onChanged: (value) {}),
          RoundedPasswordField(
            width: size.width * 0.8,
            onChanged: (value) {},
            controller: passwordController,
          ),
          RoundedButton(
              width: size.width * 0.8,
              text: "Sign Up",
              press: () async {
                var response = await signup(
                    usernameController.text,
                    emailController.text,
                    groupController.text,
                    passwordController.text);
                if (response.statusCode == 200) {
                  print(response.body);
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: Container(
                            child: Text(response.body),
                          ),
                        );
                      });
                }
              },
              textcolor: Colors.white,
              backgroundColor: Colors.indigo),
          AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }));
              },
              color: Colors.indigo)
        ],
      ),
    ));
  }
}
