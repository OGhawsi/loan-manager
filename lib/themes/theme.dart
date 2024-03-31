import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey.shade300,
    color: Colors.grey.shade800,
  ),
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Colors.grey.shade900,
    background: Colors.grey.shade300,
    onPrimary: Colors.grey.shade500,
    secondary: Colors.grey.shade200,
    onSecondary: Colors.grey.shade800,
    error: Colors.red,
    onError: Colors.red,
    onBackground: Colors.grey.shade800,
    surface: Colors.grey.shade800,
    onSurface: Colors.grey.shade800,
  ),
);

ThemeData darkMode = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey.shade800,
    color: Colors.grey.shade300,
  ),
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.grey.shade300,
    onPrimary: Colors.grey.shade800,
    secondary: Colors.grey.shade700,
    onSecondary: Colors.grey.shade800,
    error: Colors.red,
    onError: Colors.red,
    background: Colors.grey.shade900,
    onBackground: Colors.grey.shade800,
    surface: Colors.grey.shade800,
    onSurface: Colors.grey.shade100,
  ),
);
