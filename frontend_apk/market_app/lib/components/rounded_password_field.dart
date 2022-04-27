import 'package:flutter/material.dart';
import 'package:market_app/components/text_field_container.dart';

import '../details/colors.dart';

class RoundedPasswordField extends StatefulWidget {
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
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  late bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        width: widget.width,
        color: primaryGrey,
        child: TextField(
            controller: widget.controller,
            obscureText: _passwordVisible,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              hintText: "Passowrd",
              icon: Icon(Icons.lock, color: secondaryBlack),
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
            )));
  }
}
