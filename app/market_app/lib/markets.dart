

import 'package:flutter/material.dart';

class markets extends StatefulWidget {
  const markets({ Key? key }) : super(key: key);

  @override
  State<markets> createState() => _marketsState();
}

class _marketsState extends State<markets> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("market widget here"),
    );
  }
}