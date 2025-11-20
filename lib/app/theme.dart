import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class NutriTheme {
  static final ColorScheme lightScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF5FB662),
    brightness: Brightness.light,
  ).copyWith(
    primary: const Color(0xFF5FB662),
    onPrimary: const Color(0xFF0F1A0F),
    secondary: const Color(0xFFD4F06A),
    onSecondary: const Color(0xFF1A1F06),
    surface: const Color(0xFFF8F6F1),
    onSurface: const Color(0xFF13140F),
    surfaceContainerHighest: const Color(0xFFEAE8E1),
    outline: const Color(0xFFEAE8E1),
    error: const Color(0xFFD9534F),
    surfaceTint: const Color(0xFF5FB662),
  );

  static final ColorScheme darkScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF6BCB70),
    brightness: Brightness.dark,
  ).copyWith(
    primary: const Color(0xFF6BCB70),
    onPrimary: const Color(0xFFF5FFF5),
    secondary: const Color(0xFFC9E85A),
    onSecondary: const Color(0xFF1A1F06),
    surface: const Color(0xFF121212),
    onSurface: const Color(0xFFE6E2D9),
    surfaceContainerHighest: const Color(0xFF3A3A3A),
    outline: const Color(0xFF4F4F4F),
    error: const Color(0xFFE57373),
    surfaceTint: const Color(0xFF6BCB70),
  );

  static ThemeData get light => _buildTheme(lightScheme);
  static ThemeData get dark => _buildTheme(darkScheme);

  static SystemUiOverlayStyle systemChromeFor(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: lightScheme.surface,
        );
      case ThemeMode.dark:
        return SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: darkScheme.surface,
        );
      case ThemeMode.system:
        return SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent);
    }
  }

  static ThemeData _buildTheme(ColorScheme scheme) {
    final baseTextTheme = GoogleFonts.interTextTheme();
    final textTheme = baseTextTheme.copyWith(
      displayLarge: baseTextTheme.displayLarge?.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: baseTextTheme.headlineMedium?.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: baseTextTheme.bodyLarge?.copyWith(fontSize: 16),
      labelMedium: baseTextTheme.labelMedium?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: baseTextTheme.bodySmall?.copyWith(fontSize: 12),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: scheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        foregroundColor: scheme.onSurface,
      ),
      cardTheme: CardTheme(
        color: scheme.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: scheme.primary,
        contentTextStyle: textTheme.bodyLarge?.copyWith(color: scheme.onPrimary),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: scheme.surfaceContainerHighest,
        labelStyle: textTheme.labelMedium!,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}
