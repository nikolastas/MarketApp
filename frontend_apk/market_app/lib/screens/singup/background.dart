import 'package:flutter/material.dart';
import 'package:market_app/details/colors.dart';

class Background extends StatelessWidget {
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: size.height * 0.05,
            child: Container(
              alignment: Alignment.center,
              width: size.width * 0.7,
              height: size.height * 0.1,
              decoration: BoxDecoration(
                  color: primaryBlue, borderRadius: BorderRadius.circular(10)),
              child: Text(
                "Market App",
                style: TextStyle(
                    fontSize: size.width * 0.1, color: Colors.grey[700]),
              ),
            ),
          ),
          child
        ],
      ),
    );
  }
}
