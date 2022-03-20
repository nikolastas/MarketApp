import 'package:flutter/material.dart';
import 'package:market_app/components/text_field_container.dart';

import '../details/colors.dart';

class RoundedPasswordField extends StatelessWidget {
  const RoundedPasswordField({
    Key? key,
    required this.width,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);

  final double width;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      width: width,
      color: primaryGrey,
      child: TextField(
        controller: controller,
        obscureText: true,
        onChanged: onChanged,
        decoration: InputDecoration(
            hintText: "Passowrd",
            icon: Icon(Icons.lock, color: secondaryBlack),
            suffixIcon: Icon(Icons.remove_red_eye, color: secondaryBlack),
            border: InputBorder.none),
      ),
    );
  }
}
