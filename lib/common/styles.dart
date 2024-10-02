import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
 
// const Color primaryColor = Color(0xFFFFFFFF);
const Color secondaryColor = Color(0xFF8FABB7);

final TextTheme mainTextTheme = TextTheme(
  displayLarge: GoogleFonts.poppins(
      fontSize: 92, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  displayMedium: GoogleFonts.poppins(
      fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  displaySmall:
      GoogleFonts.poppins(fontSize: 46, fontWeight: FontWeight.w400),
  headlineLarge: GoogleFonts.poppins(
      fontSize: 32, fontWeight: FontWeight.w400),
  headlineMedium: GoogleFonts.poppins(
      fontSize: 28, fontWeight: FontWeight.w400),
  headlineSmall:
      GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w400),
  titleLarge: GoogleFonts.poppins(
      fontSize: 19, fontWeight: FontWeight.w500),
  titleMedium: GoogleFonts.poppins(
      fontSize: 15, fontWeight: FontWeight.w400),
  titleSmall: GoogleFonts.poppins(
      fontSize: 13, fontWeight: FontWeight.w500),
  bodyLarge: GoogleFonts.poppins(
      fontSize: 16, fontWeight: FontWeight.w400),
  bodyMedium: GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.w400),
  bodySmall: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w400),
  labelLarge: GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.w500),
  labelMedium: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w400),
  labelSmall: GoogleFonts.poppins(
      fontSize: 10, fontWeight: FontWeight.w400),
);

ThemeData getThemeData(BuildContext context) {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF1F85E0)),
    textTheme: mainTextTheme,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: false
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: secondaryColor,
        foregroundColor: Colors.white,
        textStyle: mainTextTheme.titleMedium,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(0)
          )
        )
      )
    )
  );
}