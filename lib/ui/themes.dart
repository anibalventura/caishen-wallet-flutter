import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  /*
  * Colors.
  */

  static const Color _secondaryTextColor = Colors.white;

  // Light.
  static const Color _lightPrimaryColor = Color(0xFF00C897);
  static const Color _lightSecondaryColor = Color(0xFF2FA4FF);
  static const Color _lightBackgroundColor = Colors.white;
  static const Color _lightPrimaryTextColor = Color(0xFF151D3B);

  // Dark.
  static const Color _darkPrimaryColor = Color(0xFF019267);
  static const Color _darkSecondaryColor = Color(0xFF084594);
  static const Color _darkBackgroundColor = Colors.black;
  static const Color _darkPrimaryTextColor = Color(0xFFF7F7F7);

  /*
  * Styles.
  */

  static final TextStyle _headlineText1 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle _bodyText1 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle _bodyText2 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
  );

  /*
  * Themes.
  */

  // Light.
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: _lightBackgroundColor,
    iconTheme: const IconThemeData(
      color: _lightSecondaryColor,
    ),
    colorScheme: const ColorScheme.light(
      primary: _lightPrimaryColor,
      secondary: _lightSecondaryColor,
    ),
    textTheme: TextTheme(
      headline1: _headlineText1.copyWith(
        color: _lightPrimaryTextColor,
      ),
      headline2: _headlineText1.copyWith(
        color: _secondaryTextColor,
      ),
      bodyText1: _bodyText1.copyWith(
        color: _lightPrimaryTextColor,
      ),
      bodyText2: _bodyText2.copyWith(
        color: _secondaryTextColor,
      ),
    ),
    fontFamily: GoogleFonts.roboto().fontFamily,
  );

  // Dark.
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: _darkBackgroundColor,
    iconTheme: const IconThemeData(
      color: _darkSecondaryColor,
    ),
    colorScheme: const ColorScheme.dark(
      primary: _darkPrimaryColor,
      secondary: _darkSecondaryColor,
      background: _darkBackgroundColor,
    ),
    backgroundColor: _darkBackgroundColor,
    textTheme: TextTheme(
      headline1: _headlineText1.copyWith(
        color: _darkPrimaryTextColor,
      ),
      bodyText1: _bodyText1.copyWith(
        color: _darkPrimaryTextColor,
      ),
    ),
  );
}
