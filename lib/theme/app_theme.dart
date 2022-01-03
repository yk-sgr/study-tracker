/*
 * Study Progress Tracker
 * Copyright (C) 2022 Yannick Seeger
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

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
