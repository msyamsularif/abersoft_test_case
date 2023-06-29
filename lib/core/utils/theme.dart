import 'package:flutter/material.dart';

Color primaryColor = const Color(0xFF0389F7);

ThemeData get themeData {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      foregroundColor: Colors.black,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 24,
        color: Colors.black
        
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: const MaterialStatePropertyAll(Colors.white),
        textStyle: const MaterialStatePropertyAll(TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: Colors.white,
        )),
        backgroundColor: MaterialStatePropertyAll(primaryColor),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        shadowColor: const MaterialStatePropertyAll(Colors.grey),
        fixedSize: const MaterialStatePropertyAll(Size(double.infinity, 37)),
        elevation: const MaterialStatePropertyAll(6),
      ),
    ),
  );
}
