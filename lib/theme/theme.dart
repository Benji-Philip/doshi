import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Colors.white,
    onPrimary: Color.fromARGB(255, 240, 240, 240),
    primary: Colors.black,
    secondary: Color.fromARGB(255, 199, 199, 199),
    onSecondary: Color.fromARGB(255, 0, 0, 0),
    tertiary: Color.fromARGB(255, 193, 193, 193),
    onTertiary: Color.fromARGB(255, 236, 236, 236),
  ), // ColorScheme.light
); // ThemeData

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: Colors.black,
    onBackground: Color.fromARGB(255, 23, 23, 23),
    onPrimary: Colors.black,
    primary: Colors.white,
    secondary: Color.fromARGB(255, 20, 20, 20),
    onSecondary: Color.fromARGB(255, 14, 14, 14),
    tertiary: Color.fromARGB(255, 26, 26, 26),
    onTertiary: Color.fromARGB(255, 50, 50, 50),
  ), // ColorScheme.dark
); // ThemeData

// ThemeData darkMode = ThemeData(
//   brightness: Brightness.dark,
//   colorScheme: const ColorScheme.dark(
//     background: Colors.black,
//     onBackground: Color.fromARGB(255, 23, 23, 23),
//     onPrimary: Color.fromARGB(255, 20, 20, 20),
//     primary: Colors.white,
//     secondary: Color.fromARGB(255, 26, 26, 26),
//     onSecondary: Color.fromARGB(255, 30, 30, 30),
//     tertiary: Color.fromARGB(255, 49, 49, 49),
//     onTertiary: Color.fromARGB(255, 50, 50, 50),
//   ), // ColorScheme.dark
// ); // ThemeData