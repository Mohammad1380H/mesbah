import 'package:flutter/material.dart';
import 'package:mesbah/component/colors.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor:ColorWith.primaryColor,
  textTheme: const TextTheme(
    headlineLarge: TextStyle(fontFamily: "shabnam", fontSize: 18),
    headlineMedium: TextStyle(fontFamily: "shabnam", fontSize: 16),
    headlineSmall: TextStyle(fontFamily: "shabnam", fontSize: 12),
  ),
  // ... دیگر ویژگی‌های مربوط به light mode
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  textTheme: const TextTheme(
    headlineLarge: TextStyle(fontFamily: "shabnam", fontSize: 18),
    headlineMedium: TextStyle(fontFamily: "shabnam", fontSize: 15),
    headlineSmall: TextStyle(fontFamily: "shabnam", fontSize: 12),
  ),

  // ... دیگر ویژگی‌های مربوط به dark mode
);
