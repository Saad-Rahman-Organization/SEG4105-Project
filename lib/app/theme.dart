import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class NutriTheme {
  static final ColorScheme lightScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF63B677),
    brightness: Brightness.light,
  ).copyWith(
    primary: const Color(0xFF63B677),
    onPrimary: const Color(0xFF0D1A11),
    secondary: const Color(0xFFF0D18A),
    onSecondary: const Color(0xFF23180B),
    surface: const Color(0xFFFAF7F1),
    onSurface: const Color(0xFF141413),
    surfaceContainerHighest: const Color(0xFFEDE6DB),
    outline: const Color(0xFFD8D1C6),
    outlineVariant: const Color(0xFFE7E0D6),
    error: const Color(0xFFDB6765),
    surfaceTint: const Color(0xFF63B677),
  );

  static final ColorScheme darkScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF9BBF7A),
    brightness: Brightness.dark,
  ).copyWith(
    primary: const Color(0xFF9BBF7A),
    onPrimary: const Color(0xFF0E1209),
    secondary: const Color(0xFFCBB07A),
    onSecondary: const Color(0xFF1B1207),
    surface: const Color(0xFF16110D),
    onSurface: const Color(0xFFF1E6D9),
    surfaceContainerHighest: const Color(0xFF241D17),
    outline: const Color(0xFF3D342B),
    outlineVariant: const Color(0xFF473C32),
    error: const Color(0xFFE89988),
    surfaceTint: const Color(0xFF9BBF7A),
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
    ).apply(
      bodyColor: scheme.onSurface,
      displayColor: scheme.onSurface,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: scheme.surface,
      splashColor: scheme.primary.withValues(alpha: 0.08),
      highlightColor: scheme.primary.withValues(alpha: 0.06),
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        foregroundColor: scheme.onSurface,
      ),
      cardTheme: CardTheme(
        color: scheme.surfaceContainerHighest,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        surfaceTintColor: Colors.transparent,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: scheme.outline.withValues(alpha: 0.7)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: scheme.outline.withValues(alpha: 0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: scheme.primary.withValues(alpha: 0.8), width: 1.4),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
      dividerColor: scheme.outline.withValues(alpha: 0.4),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        tileColor: scheme.surfaceContainerHighest,
        iconColor: scheme.onSurfaceVariant,
      ),
    );
  }
}
