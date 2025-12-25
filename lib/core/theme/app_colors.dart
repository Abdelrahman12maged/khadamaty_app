import 'package:flutter/material.dart';

/// App Color Palette
/// Centralized color definitions for the Khadamaty app
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // Primary Colors
  static const Color primaryBlue = Color(0xFF2196F3);
  static const Color primaryBlueDark = Color(0xFF1976D2);
  static const Color primaryBlueLight = Color(0xFF64B5F6);

  // Secondary Colors
  static const Color secondaryTeal = Color(0xFF009688);
  static const Color secondaryTealDark = Color(0xFF00796B);
  static const Color secondaryTealLight = Color(0xFF4DB6AC);

  // Accent Colors
  static const Color accentOrange = Color(0xFFFF9800);
  static const Color accentGreen = Color(0xFF4CAF50);

  // Error & Warning
  static const Color errorRed = Color(0xFFD32F2F);
  static const Color warningAmber = Color(0xFFFFC107);
  static const Color successGreen = Color(0xFF388E3C);

  // Neutral Colors - Light Theme
  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color textPrimaryLight = Color(0xFF212121);
  static const Color textSecondaryLight = Color(0xFF757575);
  static const Color dividerLight = Color(0xFFE0E0E0);

  // Neutral Colors - Dark Theme
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);
  static const Color dividerDark = Color(0xFF2C2C2C);

  // Semantic Colors
  static const Color rating = Color(0xFFFFC107);
  static const Color verified = Color(0xFF4CAF50);
  static const Color premium = Color(0xFFFFD700);

  // Dark theme helpers (aliases for easier access)
  static const Color darkSurface = surfaceDark;
  static const Color darkBorder = dividerDark;
  static const Color darkTextSecondary = textSecondaryDark;

  // Theme-aware helper methods
  /// Get background color based on current theme
  static Color background(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? backgroundDark
        : backgroundLight;
  }

  /// Get surface color based on current theme
  static Color surface(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? surfaceDark
        : surfaceLight;
  }

  /// Get primary text color based on current theme
  static Color textPrimary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? textPrimaryDark
        : textPrimaryLight;
  }

  /// Get secondary text color based on current theme
  static Color textSecondary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? textSecondaryDark
        : textSecondaryLight;
  }

  /// Get divider color based on current theme
  static Color divider(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? dividerDark
        : dividerLight;
  }
}
