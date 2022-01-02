import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFF9F4F4);
  static const Color secondaryColor = Color(0xFF93C3C0);
  static const Color tertiaryColor = Color(0xFFFFFFFF);
  static const Color darkTextColor = Color(0xFF303030);
  static const Color lightActionColor = Color(0xFFB3B2B2);

  static TextStyle headline1 = GoogleFonts.openSans(
    fontSize: 24,
    color: darkTextColor,
    fontWeight: FontWeight.w600,
  );
  static TextStyle headline2 = GoogleFonts.openSans(
    fontSize: 22,
    color: darkTextColor,
    fontWeight: FontWeight.w600,
  );

  static ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: tertiaryColor,
    appBarTheme: AppBarTheme(
        color: primaryColor,
        foregroundColor: darkTextColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: headline2),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: secondaryColor,
    ),
    textTheme: TextTheme(
        bodyText1: GoogleFonts.openSans(fontSize: 14, color: darkTextColor),
        subtitle2: GoogleFonts.openSans(fontSize: 16, color: darkTextColor),
        headline1: headline1),
  );
}
