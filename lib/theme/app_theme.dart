import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFF9F4F4);
  static const Color secondaryColor = Color(0xFF93C3C0);
  static const Color tertiaryColor = Color(0xFFFFFFFF);
  static const Color darkTextColor = Color(0xFF303030);

  static ThemeData lightTheme = ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(color: primaryColor),
    textTheme: TextTheme(
      bodyText1: GoogleFonts.openSans(fontSize: 14, color: darkTextColor),
      subtitle2: GoogleFonts.openSans(fontSize: 16, color: darkTextColor),
      headline1: GoogleFonts.openSans(
        fontSize: 24,
        color: darkTextColor,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
