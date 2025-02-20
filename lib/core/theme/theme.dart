import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlobalTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    textTheme: GoogleFonts.dmSansTextTheme(),
    colorScheme: ColorScheme.fromSeed(seedColor: Color(0xfff86320)),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    textTheme: GoogleFonts.dmSansTextTheme(),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow, brightness: Brightness.dark),
  );
}