import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFFF4D8D);
  static const Color secondaryColor = Color(0xFF666666);
  static const Color backgroundColor = Color(0xFFFAF9F9);

  static ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(color: primaryColor),
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
    ),
    textTheme: GoogleFonts.poppinsTextTheme(),
  );
}
