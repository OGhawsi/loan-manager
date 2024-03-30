import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Colors.grey.shade300,
    onPrimary: Colors.grey.shade800,
    secondary: Colors.grey.shade200,
    onSecondary: Colors.grey.shade800,
    error: Colors.red,
    onError: Colors.red,
    background: Colors.grey.shade400,
    onBackground: Colors.grey.shade800,
    surface: Colors.grey.shade800,
    onSurface: Colors.grey.shade800,
  ),
);

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.grey.shade800,
    onPrimary: Colors.grey.shade800,
    secondary: Colors.grey.shade700,
    onSecondary: Colors.grey.shade800,
    error: Colors.red,
    onError: Colors.red,
    background: Colors.grey.shade900,
    onBackground: Colors.grey.shade800,
    surface: Colors.grey.shade800,
    onSurface: Colors.grey.shade800,
  ),
);
