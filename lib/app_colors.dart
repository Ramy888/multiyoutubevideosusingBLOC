import 'package:flutter/material.dart';

// Defining color constants
class AppColors {
  static const Color purple1 = Color(0xFF5F43C1);
  static const Color purple2 = Color(0xFF6C1894);
  static const Color grey = Color(0xFFBCBCBC);
  static const Color black = Color(0xFF000000);
  static const Color lightGrey = Color(0xFFEDEDED);
  static const Color brown = Color(0xFFA0885A);
  static const Color white = Color(0xFFFFFFFF);
  static const Color purple3 = Color(0xFF981778);
  static const Color darkPurple1 = Color(0xFF433084);
  static const Color darkPurple2 = Color(0xFF221842);
  static const Color cardColor = Color(0xFFf0f0f1);

  static const LinearGradient mainPurpleGradient = LinearGradient(
    colors: [
      Color(0xFF5F43C1), // Start color of the gradient
      Color(0xFF6C1894)  // End color of the gradient
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient lastGradient = LinearGradient(
    colors: [
      Color(0xFF433084), // Start color of the gradient
      Color(0xFF221842)  // End color of the gradient
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
