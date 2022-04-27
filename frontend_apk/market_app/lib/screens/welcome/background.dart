import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: double.infinity,
      width: size.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              top: size.height * 0.1,
              child: Icon(
                Icons.facebook,
                size: 30,
              )),
          Positioned(
            bottom: size.height * 0.1,
            child: Icon(Icons.adb_outlined, size: 30),
          ),
          child
        ],
      ),
    );
  }
}
