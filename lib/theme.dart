import 'package:flutter/material.dart';

Color darkPurple = Color(0xff161124);
Color purple = Color(0xff4b3b78);
Color blue = Color(0xff9bcbfe);
Color red = Color(0xffA53A3A);
Color green = Color(0xff3B783C);

ThemeData appThemeLight = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Colors.white,
    onPrimary: purple,
    secondary: purple,
    onSecondary: blue,
    error: red,
    onError: Colors.white,
    surface: Colors.white,
    onSurface: blue,
    outline: blue,
    outlineVariant: Colors.white,
  ),
  fontFamily: 'Unica',
);

ThemeData appThemeDark = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: darkPurple,
    onPrimary: blue,
    secondary: purple,
    onSecondary: blue,
    error: red,
    onError: Colors.white,
    surface: darkPurple,
    onSurface: blue,
    outline: purple,
    outlineVariant: blue,
  ),
  fontFamily: 'Unica',
);
