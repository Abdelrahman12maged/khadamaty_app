import 'package:flutter/material.dart';

/// Defines screen types based on width
enum ScreenType {
  mobile, // < 600dp
  tablet, // 600dp - 1240dp
  desktop, // > 1240dp
}

/// Responsive breakpoints utility class
/// This class helps determine what type of screen we're on
/// and provides helper methods for responsive design
class Breakpoints {
  // Private constructor - prevents creating instances
  Breakpoints._();

  // Breakpoint values (in logical pixels)
  static const double mobile = 600; // Below this = mobile
  static const double tablet = 1280; // Between mobile & tablet = tablet
  // Above tablet = desktop

  /// Gets the current screen type based on width
  ///
  /// Example:
  /// ```dart
  /// final screenType = Breakpoints.getScreenType(context);
  /// if (screenType == ScreenType.mobile) {
  ///   // Show mobile layout
  /// }
  /// ```
  static ScreenType getScreenType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < mobile) {
      return ScreenType.mobile;
    } else if (width < tablet) {
      return ScreenType.tablet;
    } else {
      return ScreenType.desktop;
    }
  }

  /// Check if current screen is mobile
  static bool isMobile(BuildContext context) {
    return getScreenType(context) == ScreenType.mobile;
  }

  /// Check if current screen is tablet
  static bool isTablet(BuildContext context) {
    return getScreenType(context) == ScreenType.tablet;
  }

  /// Check if current screen is desktop
  static bool isDesktop(BuildContext context) {
    return getScreenType(context) == ScreenType.desktop;
  }

  /// Get screen width
  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Get screen height
  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
