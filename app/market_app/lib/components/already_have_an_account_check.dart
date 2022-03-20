import 'package:flutter/material.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  const AlreadyHaveAnAccountCheck({
    Key? key,
    required this.login,
    required this.press,
    required this.color,
  }) : super(key: key);
  final bool login;
  final void Function() press;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          login ? "Dont have an account ? " : "Already have an account?",
          style: TextStyle(color: color),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Sign Up" : "Login",
            style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
