import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final appColorScheme = const ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF561F0F),
  onPrimary: Color(0xFFE6D3BA),
  secondary: Color(0xFF442A22),
  onSecondary: Color(0xFFE6D3BA),
  surface: Color(0xFF1A110F),
  onSurface: Color(0xFFE6D3BA),
  error: Color(0xFF690005),
  onError: Colors.white,
);

class AppSpacing {
  static const double base = 8.0;
  static const double edge = 16.0;
  static const double standard = 24.0;
}

final appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: appColorScheme,
  textTheme: TextTheme(
    headlineSmall: GoogleFonts.abyssinicaSil(
      fontSize: 24,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: GoogleFonts.abel(fontSize: 16, fontWeight: FontWeight.normal),
    labelLarge: GoogleFonts.abel(fontSize: 14, fontWeight: FontWeight.normal),
    labelSmall: GoogleFonts.abyssinicaSil(
      fontSize: 12,
      fontWeight: FontWeight.normal,
    ),
  ),

  cardTheme: const CardThemeData(margin: EdgeInsets.all(AppSpacing.edge)),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: appColorScheme.primary,
      foregroundColor: appColorScheme.onPrimary,
      minimumSize: const Size.fromHeight(48),
    ),
  ),
);
