import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._(); // Private constructor

  // ============================================
  // LIGHT THEME
  // ============================================
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    // Color Scheme
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryBlue,
      primaryContainer: AppColors.primaryBlueLight,
      secondary: AppColors.secondaryTeal,
      secondaryContainer: AppColors.secondaryTealLight,
      error: AppColors.errorRed,
      surface: AppColors.surfaceLight,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.textPrimaryLight,
      onError: Colors.white,
    ),

    // Scaffold
    scaffoldBackgroundColor: AppColors.backgroundLight,

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surfaceLight,
      foregroundColor: AppColors.textPrimaryLight,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.primaryBlue),
      titleTextStyle: TextStyle(
        color: AppColors.textPrimaryLight,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: AppColors.surfaceLight,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryBlue,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryBlue,
        side: const BorderSide(color: AppColors.primaryBlue, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.dividerLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.dividerLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.errorRed),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.errorRed, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: const TextStyle(color: AppColors.textSecondaryLight),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.surfaceLight,
      selectedItemColor: AppColors.primaryBlue,
      unselectedItemColor: AppColors.textSecondaryLight,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
    ),

    // Icon Theme
    iconTheme: const IconThemeData(
      color: AppColors.textPrimaryLight,
      size: 24,
    ),

    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: AppColors.dividerLight,
      thickness: 1,
      space: 1,
    ),

    // Text Theme
    textTheme: const TextTheme(
      // Display
      displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryLight),
      displayMedium: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryLight),
      displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryLight),

      // Headline
      headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimaryLight),
      headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimaryLight),
      headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimaryLight),

      // Title
      titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimaryLight),
      titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimaryLight),
      titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimaryLight),

      // Body
      bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: AppColors.textPrimaryLight),
      bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppColors.textPrimaryLight),
      bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: AppColors.textSecondaryLight),

      // Label
      labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimaryLight),
      labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimaryLight),
      labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondaryLight),
    ),
  );

  // ============================================
  // DARK THEME
  // ============================================
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    // Color Scheme
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryBlueLight,
      primaryContainer: AppColors.primaryBlueDark,
      secondary: AppColors.secondaryTealLight,
      secondaryContainer: AppColors.secondaryTealDark,
      error: AppColors.errorRed,
      surface: AppColors.surfaceDark,
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: AppColors.textPrimaryDark,
      onError: Colors.white,
    ),

    // Scaffold
    scaffoldBackgroundColor: AppColors.backgroundDark,

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surfaceDark,
      foregroundColor: AppColors.textPrimaryDark,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.primaryBlueLight),
      titleTextStyle: TextStyle(
        color: AppColors.textPrimaryDark,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: AppColors.surfaceDark,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryBlueLight,
        foregroundColor: Colors.black,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryBlueLight,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryBlueLight,
        side: const BorderSide(color: AppColors.primaryBlueLight, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.dividerDark),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.dividerDark),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:
            const BorderSide(color: AppColors.primaryBlueLight, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.errorRed),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.errorRed, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: const TextStyle(color: AppColors.textSecondaryDark),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.surfaceDark,
      selectedItemColor: AppColors.primaryBlueLight,
      unselectedItemColor: AppColors.textSecondaryDark,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
    ),

    // Icon Theme
    iconTheme: const IconThemeData(
      color: AppColors.textPrimaryDark,
      size: 24,
    ),

    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: AppColors.dividerDark,
      thickness: 1,
      space: 1,
    ),

    // Text Theme
    textTheme: const TextTheme(
      // Display
      displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryDark),
      displayMedium: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryDark),
      displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryDark),

      // Headline
      headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimaryDark),
      headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimaryDark),
      headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimaryDark),

      // Title
      titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimaryDark),
      titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimaryDark),
      titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimaryDark),

      // Body
      bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: AppColors.textPrimaryDark),
      bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppColors.textPrimaryDark),
      bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: AppColors.textSecondaryDark),

      // Label
      labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimaryDark),
      labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimaryDark),
      labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondaryDark),
    ),
  );
}
