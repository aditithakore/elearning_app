import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryOrange = Color(0xFFE86D2A);
  static const Color secondaryBlue = Color(0xFF66D1E7);
  static const Color accentGreen = Color(0xFF8DD118);
  static const Color accentYellow = Color(0xFFEDE734);
  static const Color accentRed = Color(0xFFD83535);
  static const Color backgroundColor = Color(0xFFE2F1F0);

  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryOrange,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: ColorScheme.light(
      primary: primaryOrange,
      secondary: secondaryBlue,
      background: backgroundColor,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: primaryOrange,
      foregroundColor: Colors.white,
    ),

    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black87, fontSize: 18),
      bodyMedium: TextStyle(color: Colors.black87, fontSize: 16),
      titleLarge: TextStyle(color: primaryOrange, fontSize: 24, fontWeight: FontWeight.bold),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryOrange,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: TextStyle(fontSize: 18),
      ),
    ),
    
    iconTheme: IconThemeData(color: primaryOrange, size: 30),
  );
}