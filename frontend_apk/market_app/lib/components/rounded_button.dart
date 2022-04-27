import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.width,
    required this.text,
    required this.press,
    required this.textcolor,
    required this.backgroundColor,
  }) : super(key: key);

  final double width;
  final String text;
  final void Function() press;
  final Color textcolor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ElevatedButton(
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: textcolor),
          ),
          style: ElevatedButton.styleFrom(
              primary: backgroundColor,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40)),
        ),
      ),
    );
  }
}
