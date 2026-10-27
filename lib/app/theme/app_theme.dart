import 'package:flutter/material.dart';

import 'app_tokens.dart';

abstract final class AppTheme {
  static ThemeData get light => _buildTheme(Brightness.light);
  static ThemeData get dark => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final canvas = isDark ? AppTokens.darkCanvas : AppTokens.lightCanvas;
    final surface = isDark ? AppTokens.darkSurface : AppTokens.lightSurface;
    final primary = isDark ? AppTokens.darkPrimary : AppTokens.lightPrimary;
    final secondary = isDark
        ? AppTokens.darkSecondary
        : AppTokens.lightSecondary;
    final text = isDark ? AppTokens.darkText : AppTokens.lightText;
    final mutedText = isDark
        ? AppTokens.darkMutedText
        : AppTokens.lightMutedText;
    final divider = isDark ? AppTokens.darkDivider : AppTokens.lightDivider;
    final outline = isDark ? AppTokens.darkOutline : AppTokens.lightOutline;
    final error = isDark ? AppTokens.darkError : AppTokens.lightError;

    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: isDark ? AppTokens.darkCanvas : Colors.white,
      secondary: secondary,
      onSecondary: isDark ? AppTokens.darkCanvas : Colors.white,
      error: error,
      onError: isDark ? AppTokens.darkCanvas : Colors.white,
      surface: surface,
      onSurface: text,
      outline: outline,
      outlineVariant: divider,
      surfaceTint: Colors.transparent,
    );

    final baseTextTheme = ThemeData(
      brightness: brightness,
      useMaterial3: true,
    ).textTheme;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: canvas,
      dividerColor: divider,
      visualDensity: VisualDensity.standard,
      textTheme: baseTextTheme.copyWith(
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(
          color: text,
          fontSize: AppTokens.bodyTextSize,
        ),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(
          color: text,
          fontSize: AppTokens.bodyTextSize,
          height: 1.5,
        ),
        bodySmall: baseTextTheme.bodySmall?.copyWith(
          color: mutedText,
          fontSize: 12,
          height: 1.4,
        ),
        titleLarge: baseTextTheme.titleLarge?.copyWith(
          color: text,
          fontSize: AppTokens.titleTextSize,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: baseTextTheme.titleMedium?.copyWith(
          color: text,
          fontSize: AppTokens.sectionHeadingSize,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: baseTextTheme.headlineSmall?.copyWith(
          color: text,
          fontSize: AppTokens.pageHeadingSize,
          fontWeight: FontWeight.w600,
          height: 1.2,
          letterSpacing: -0.4,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: canvas,
        foregroundColor: text,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: baseTextTheme.titleLarge?.copyWith(
          color: text,
          fontSize: AppTokens.titleTextSize,
          fontWeight: FontWeight.w600,
        ),
      ),
      dividerTheme: DividerThemeData(color: divider, thickness: 1, space: 1),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: colorScheme.onPrimary,
          disabledBackgroundColor: divider,
          disabledForegroundColor: mutedText,
          minimumSize: const Size(0, AppTokens.controlMinHeight),
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.space16,
            vertical: AppTokens.space12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTokens.radius12),
          ),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: text,
          minimumSize: const Size(0, AppTokens.controlMinHeight),
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.space16,
            vertical: AppTokens.space12,
          ),
          side: BorderSide(color: divider),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTokens.radius12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: text,
          minimumSize: const Size(0, AppTokens.controlMinHeight),
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.space12,
            vertical: AppTokens.space12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTokens.radius12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        contentPadding: const EdgeInsets.all(AppTokens.space16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radius12),
          borderSide: BorderSide(color: divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radius12),
          borderSide: BorderSide(color: divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radius12),
          borderSide: BorderSide(color: outline, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radius12),
          borderSide: BorderSide(color: error),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isDark ? AppTokens.darkSurface : AppTokens.lightText,
        contentTextStyle: TextStyle(
          color: isDark ? AppTokens.darkText : Colors.white,
          fontSize: AppTokens.bodyTextSize,
        ),
        elevation: 0,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: primary,
        linearTrackColor: divider,
      ),
    );
  }
}
