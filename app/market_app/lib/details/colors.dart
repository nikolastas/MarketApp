import 'package:flutter/material.dart';

//primary
Color primaryGrey = const Color(0xffd7ddE9);
Color primaryBlue = const Color(0xff8CbbF1);
Color primaryPink = const Color(0xfff9cedf);
Color primaryYellow = const Color(0xfffceeca);
Color primaryWhite = const Color(0xfffdfdff);
// // secondary
Color secondaryYellow = const Color(0xffffe298);
Color secondaryPink = const Color(0xffffa6C9);
Color secondaryGrey = const Color(0xff626772);
Color secondaryBlue = const Color(0xff479afa);
Color secondaryBlack = const Color(0xff000000);

// Custom Theme data
ThemeData ourThemeData = ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.dark,
    primaryColor: (secondaryBlack),

    // Define the default font family.
    fontFamily: 'OpenSans',

    // Define the default `TextTheme`. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: const TextTheme(
      bodySmall: TextStyle(
          fontSize: 14.0, fontFamily: 'OpenSans', color: Color(0xff000000)),
      bodyMedium: TextStyle(
          fontSize: 14.0, fontFamily: 'OpenSans', color: Color(0xff000000)),
      bodyLarge: TextStyle(
          fontSize: 16.0, fontFamily: 'OpenSans', color: Color(0xff000000)),
      headlineSmall: TextStyle(
          fontSize: 24.0, fontFamily: 'OpenSans', color: Color(0xff000000)),
      headlineLarge: TextStyle(
          fontSize: 32.0, fontFamily: 'OpenSans', color: Color(0xff000000)),
      displaySmall: TextStyle(
          fontSize: 36.0, fontFamily: 'Roboto', color: Color(0xff000000)),
    ));
