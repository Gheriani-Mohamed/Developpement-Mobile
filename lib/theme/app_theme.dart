import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SmartWalletTheme {
  static const Color primaryColor = Color(0xFF76A82F); // Green
  static const Color secondaryColor = Color(0xFF5C8424); // Dark Green
  static const Color textColor = Color(0xFF0F172A); // Slate-900
  static const Color backgroundColor = Colors.white;
  static const Color surfaceColor = Color(0xFFF1F5F9); // Slate-100

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      brightness: Brightness.light,
      textTheme: GoogleFonts.outfitTextTheme(
        ThemeData.light().textTheme,
      ).apply(
        bodyColor: textColor,
        displayColor: textColor,
      ),
      inputDecorationTheme: _inputDecorationTheme(
        fillColor: surfaceColor,
        borderColor: Colors.transparent,
        focusedBorderColor: primaryColor,
      ),
      elevatedButtonTheme: _elevatedButtonTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      useMaterial3: true,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: const Color(0xFF0F172A), // Slate-900
      brightness: Brightness.dark,
      textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme).apply(
        bodyColor: const Color(0xFFF1F5F9), // Slate-100
        displayColor: const Color(0xFFF1F5F9),
      ),
      inputDecorationTheme: _inputDecorationTheme(
        fillColor: const Color(0xFF1E293B), // Slate-800
        borderColor: Colors.transparent,
        focusedBorderColor: primaryColor,
      ),
      elevatedButtonTheme: _elevatedButtonTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      useMaterial3: true,
    );
  }

  static InputDecorationTheme _inputDecorationTheme({
    required Color fillColor,
    required Color borderColor,
    required Color focusedBorderColor,
  }) {
    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: focusedBorderColor, width: 2),
      ),
      hintStyle: const TextStyle(color: Colors.grey),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16,
      ),
    );
  }

  static ElevatedButtonThemeData _elevatedButtonTheme({
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}
