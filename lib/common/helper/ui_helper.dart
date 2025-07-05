import 'package:flutter/material.dart';
import 'package:gutenberg/common/common.dart';
import 'package:logger/logger.dart';

class UiHelper {
  final log = Logger();

  UiHelper();

  ThemeData themeData(String themeMode) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF5E56E7),
        primary: const Color(0xFF5E56E7),
        brightness: themeMode == ThemeConfig.LIGHT ? Brightness.light : Brightness.dark,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
          textStyle: WidgetStateProperty.all(TextStyle(inherit: false, fontWeight: FontWeight.w500, fontFamily: Constants.FONT_MONTESERRAT)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
          textStyle: WidgetStateProperty.all(TextStyle(inherit: false, fontWeight: FontWeight.w500, fontFamily: Constants.FONT_MONTESERRAT)),
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(inherit: true, fontFamily: Constants.FONT_MONTESERRAT),
        bodyMedium: TextStyle(inherit: true, fontFamily: Constants.FONT_MONTESERRAT),
        bodySmall: TextStyle(inherit: true, fontFamily: Constants.FONT_MONTESERRAT),
        labelLarge: TextStyle(inherit: true, fontFamily: Constants.FONT_MONTESERRAT),
        labelMedium: TextStyle(inherit: true, fontFamily: Constants.FONT_MONTESERRAT),
        labelSmall: TextStyle(inherit: true, fontFamily: Constants.FONT_MONTESERRAT),
        titleLarge: TextStyle(inherit: true, fontFamily: Constants.FONT_MONTESERRAT),
        titleMedium: TextStyle(inherit: true, fontFamily: Constants.FONT_MONTESERRAT),
        titleSmall: TextStyle(inherit: true, fontFamily: Constants.FONT_MONTESERRAT),
        headlineLarge: TextStyle(inherit: true, fontFamily: Constants.FONT_MONTESERRAT),
        headlineMedium: TextStyle(inherit: true, fontFamily: Constants.FONT_MONTESERRAT),
        headlineSmall: TextStyle(inherit: true, fontFamily: Constants.FONT_MONTESERRAT),
        displayLarge: TextStyle(inherit: true, fontFamily: Constants.FONT_MONTESERRAT),
        displayMedium: TextStyle(inherit: true, fontFamily: Constants.FONT_MONTESERRAT),
        displaySmall: TextStyle(inherit: true, fontFamily: Constants.FONT_MONTESERRAT),
      ),
    );
  }
}
