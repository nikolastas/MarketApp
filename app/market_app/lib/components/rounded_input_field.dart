import 'package:flutter/material.dart';

class RoundedInputField extends StatefulWidget {
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
  State<RoundedInputField> createState() => _RoundedInputFieldState();
}

class _RoundedInputFieldState extends State<RoundedInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      margin: EdgeInsets.symmetric(vertical: 10),
      width: widget.width,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextField(
        controller: widget.controller,
        // onChanged: widget.onChanged,
        decoration: InputDecoration(
          icon: widget.icon,
          hintText: widget.hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
