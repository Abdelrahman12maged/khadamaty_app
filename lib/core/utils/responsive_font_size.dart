import 'package:flutter/material.dart';
import 'responsive_breakpoints.dart';

/// Responsive font size utility
/// Automatically scales font sizes based on screen type
///
/// Example:
/// ```dart
/// Text(
///   'Hello',
///   style: TextStyle(
///     fontSize: ResponsiveFontSize.large(context),
///   ),
/// )
/// ```
class ResponsiveFontSize {
  ResponsiveFontSize._();

  /// Scale factor for different screen types
  /// Mobile: 1.0 (base)
  /// Tablet: 1.2
  /// Desktop: 1.3
  static double _getScaleFactor(BuildContext context) {
    final screenType = Breakpoints.getScreenType(context);

    switch (screenType) {
      case ScreenType.mobile:
        return 1.0;
      case ScreenType.tablet:
        return 1.1;
      case ScreenType.desktop:
        return 0.9;
    }
  }

  /// Get scaled font size
  static double scale(BuildContext context, double baseSize) {
    return baseSize * _getScaleFactor(context);
  }

  // Predefined sizes (matching Material Design)

  /// Display Large: 57sp -> (57, 68, 74)
  static double displayLarge(BuildContext context) => scale(context, 57);

  /// Display Medium: 45sp -> (45, 54, 58)
  static double displayMedium(BuildContext context) => scale(context, 45);

  /// Display Small: 36sp -> (36, 43, 47)
  static double displaySmall(BuildContext context) => scale(context, 36);

  /// Headline Large: 32sp -> (32, 38, 42)
  static double headlineLarge(BuildContext context) => scale(context, 32);

  /// Headline Medium: 28sp -> (28, 34, 36)
  static double headlineMedium(BuildContext context) => scale(context, 28);

  /// Headline Small: 24sp -> (24, 29, 31)
  static double headlineSmall(BuildContext context) => scale(context, 24);

  /// Title Large: 22sp -> (22, 26, 29)
  static double titleLarge(BuildContext context) => scale(context, 22);

  /// Title Medium: 16sp -> (16, 19, 21)
  static double titleMedium(BuildContext context) => scale(context, 16);

  /// Title Small: 14sp -> (14, 17, 18)
  static double titleSmall(BuildContext context) => scale(context, 14);

  /// Body Large: 16sp -> (16, 19, 21)
  static double bodyLarge(BuildContext context) => scale(context, 16);

  /// Body Medium: 14sp -> (14, 17, 18)
  static double bodyMedium(BuildContext context) => scale(context, 14);

  /// Body Small: 12sp -> (12, 14, 16)
  static double bodySmall(BuildContext context) => scale(context, 12);

  /// Label Large: 14sp -> (14, 17, 18)
  static double labelLarge(BuildContext context) => scale(context, 14);

  /// Label Medium: 12sp -> (12, 14, 16)
  static double labelMedium(BuildContext context) => scale(context, 12);

  /// Label Small: 11sp -> (11, 13, 14)
  static double labelSmall(BuildContext context) => scale(context, 11);
}

/// Extension on BuildContext for easier access
extension ResponsiveFontSizeContext on BuildContext {
  /// Get scaled font size
  ///
  /// Example:
  /// ```dart
  /// fontSize: context.fontSize(16)
  /// ```
  double fontSize(double baseSize) {
    return ResponsiveFontSize.scale(this, baseSize);
  }
}
