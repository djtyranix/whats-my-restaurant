import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryContainer = Color(0xFFD3E4FF);
const Color primaryContainerDark = Color(0xFF1E4875);
const Color onPrimaryContainer = Color(0xFF001C38);
const Color onPrimaryContainerDark = Color(0xFFD3E4FF);
const Color successContainer = Color(0xFFBBF0B5);
const Color successContainerDark = Color(0xFF225025);
const Color onSuccessContainer = Color(0xFF002105);
const Color onSuccessContainerDark = Color(0xFFBBF0B5);
const Color errorContainer = Color(0xFFFFDAD6);
const Color errorContainerDark = Color(0xFF93000A);
const Color onErrorContainer = Color(0xFF410002);
const Color onErrorContainerDark = Color(0xFFFFDAD6);
 
final TextTheme mainTextTheme = TextTheme(
  displayLarge: GoogleFonts.poppins(
      fontSize: 92, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  displayMedium: GoogleFonts.poppins(
      fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  displaySmall:
      GoogleFonts.poppins(fontSize: 46, fontWeight: FontWeight.w400, letterSpacing: 0),
  headlineLarge: GoogleFonts.poppins(
      fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0),
  headlineMedium: GoogleFonts.poppins(
      fontSize: 28, fontWeight: FontWeight.w400, letterSpacing: 0),
  headlineSmall:
      GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w400, letterSpacing: 0),
  titleLarge: GoogleFonts.poppins(
      fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0),
  titleMedium: GoogleFonts.poppins(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0),
  titleSmall: GoogleFonts.poppins(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0),
  bodyLarge: GoogleFonts.poppins(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0),
  bodyMedium: GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0),
  bodySmall: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0),
  labelLarge: GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0),
  labelMedium: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0),
  labelSmall: GoogleFonts.poppins(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 0),
);

ThemeData getThemeData(BuildContext context, Brightness brightness) {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      brightness: brightness,
      seedColor: Color(0xFF1F85E0)
    ),
    textTheme: mainTextTheme,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(  
        backgroundColor: brightness == Brightness.dark ? primaryContainerDark : primaryContainer,
        foregroundColor: brightness == Brightness.dark ? onPrimaryContainerDark : onPrimaryContainer
      )
    )
  );
}