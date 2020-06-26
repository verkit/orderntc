import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appLightTheme = _buildLightTheme();

TextTheme _buildTextTheme(TextTheme base, Color primaryColor, {bool dark = false}) {
  double em = 17;

  return base.copyWith(
    headline6: GoogleFonts.rubik(
      textStyle: base.headline6.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 1.7 * em,
        letterSpacing: 0.7,
        // color for lighter white so that it's not too hard on the eyes
        color: dark ? Color(0xccFFFFFF) : Colors.black,
      ),
    ),

    // buttons
    button: GoogleFonts.rubik(
      textStyle: base.button.copyWith(
        color: primaryColor,
        fontSize: 0.85 * em,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    ),

    // bottom sheet text for confirmations?
    bodyText1: base.bodyText1.copyWith(
      fontSize: em,
      fontWeight: FontWeight.w500,
      color: dark ? Colors.white70 : Colors.black87,
    ),

    // default font
    bodyText2: base.bodyText2.copyWith(
      fontSize: em,
      fontWeight: FontWeight.w400,
      color: dark ? Colors.white70 : Colors.black87,
    ),
  );
}

Color primaryColor = Colors.indigo;

// so that there are no lines above/below expansiontile
Color dividerColor = Colors.transparent;

// for timings not available box
Color errorColor = Colors.red;

// for better back transition
PageTransitionsTheme _pageTransitionsTheme = PageTransitionsTheme(
  builders: <TargetPlatform, PageTransitionsBuilder>{
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  },
);

ThemeData _buildLightTheme() {
  final ThemeData base = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    accentColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
    toggleableActiveColor: primaryColor,
    dividerColor: dividerColor,
    errorColor: errorColor,
  );

  return base.copyWith(
    textTheme: _buildTextTheme(base.textTheme, primaryColor),
    pageTransitionsTheme: _pageTransitionsTheme,
  );
}