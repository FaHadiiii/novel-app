import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class AppTheme {
  // Theme colors
  static const Color primaryColor = Color.fromARGB(230, 234, 80, 14);
  static const Color secondaryColor = Color.fromARGB(255, 251, 251, 251);
  static const Color darksecondaryColor = Color.fromARGB(255, 25, 25, 25);
  static const Color lightBackground = Colors.white;
  static const Color darkBackground = Color.fromARGB(255, 14, 13, 13);
  static Color lightBackgroundShadow = Colors.grey.withOpacity(0.1);
  static const Color darkBackgroundShadow = Colors.transparent;

  //Appbar theme
  static final AppBarTheme appBarTheme = AppBarTheme(
    titleSpacing: 22.0,
    centerTitle: false,
    scrolledUnderElevation: 0.0,
    color: Colors.transparent,
    elevation: 0,
  );

  //Text theme
  static TextStyle _baseTextStyle(Color color, double size) {
    return GoogleFonts.poppins(
      fontSize: size,
      color: color,
    );
  }

  static TextTheme textTheme(Color textColor) {
    return TextTheme(
      titleLarge: _baseTextStyle(textColor, 5.h),
      titleMedium: _baseTextStyle(textColor, 5.3.w),
      titleSmall: _baseTextStyle(textColor, 4.7.w),
      bodyLarge: _baseTextStyle(textColor, 4.w),
      bodyMedium: _baseTextStyle(textColor, 3.5.w),
      bodySmall: _baseTextStyle(textColor, 3.w),
    );
  }

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    appBarTheme: appBarTheme,
    primaryColor: primaryColor,
    cardColor: secondaryColor,
    scaffoldBackgroundColor: lightBackground,
    textTheme: textTheme(Colors.black),
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    shadowColor: lightBackgroundShadow,
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    appBarTheme: appBarTheme,
    primaryColor: primaryColor,
    cardColor: darksecondaryColor,
    scaffoldBackgroundColor: darkBackground,
    textTheme: textTheme(Colors.white),
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    shadowColor: darkBackgroundShadow,
  );
}
