import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  const RoundedInputField({
    Key? key,
    required,
    required this.width,
    required this.color,
    required this.icon,
    required this.hintText,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);

  final double width;
  final Color color;
  final Icon icon;
  final String hintText;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      margin: EdgeInsets.symmetric(vertical: 10),
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: icon,
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
