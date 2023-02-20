import 'package:flukit/utils/flu_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'settings.dart';

/// [ThemeManager] instance that will be used in
/// the whole app.
const ThemeManager themeManager = ThemeManager._();

/// Manage theming operations across the app
class ThemeManager {
  const ThemeManager._();

  void changeThemeMode() => Flu.changeThemeMode();

  /* void changeTheme(Themes theme) =>
      Flu.changeTheme(Get.isDarkMode ? lightTheme : theme.light); */

  ThemeData get lightTheme {
    return _buildTheme(
      ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: settings.defaultTheme.colorSchemeSeed,
          brightness: Brightness.light,
        ),
      ),
    );
  }

  ThemeData get darkTheme {
    return _buildTheme(
      ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: settings.defaultTheme.colorSchemeSeed,
          brightness: Brightness.dark,
        ),
      ),
    );
  }

  /// Build a theme with common styles
  ThemeData _buildTheme(ThemeData themeData) {
    return themeData.copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(themeData.textTheme));
  }
}

/// App themes
enum Themes { blue }

extension E on Themes {
  /// Define the seed color for a theme [ColorScheme]
  Color get colorSchemeSeed {
    switch (this) {
      case Themes.blue:
        return const Color(0xFF1651E7);
    }
  }
}
