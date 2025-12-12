import 'package:flutter/material.dart';
import 'responsive_breakpoints.dart';

/// A utility class that returns different values based on screen size
///
/// This is extremely useful for responsive design where you need different
/// values (padding, font size, width, etc.) for different screen sizes.
///
/// Example:
/// ```dart
/// // Different padding for each screen type
/// final padding = ResponsiveValue(
///   mobile: 16.0,
///   tablet: 24.0,
///   desktop: 32.0,
/// ).getValue(context);
///
/// // Different widget for each screen type
/// final layout = ResponsiveValue(
///   mobile: MobileLayout(),
///   tablet: TabletLayout(),
///   desktop: DesktopLayout(),
/// ).getValue(context);
/// ```
class ResponsiveValue<T> {
  final T mobile;
  final T? tablet;
  final T? desktop;

  /// Creates a responsive value
  ///
  /// [mobile] is required and will be used as fallback
  /// [tablet] defaults to mobile if not provided
  /// [desktop] defaults to tablet (or mobile) if not provided
  const ResponsiveValue({
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  /// Gets the appropriate value based on current screen size
  T getValue(BuildContext context) {
    final screenType = Breakpoints.getScreenType(context);

    switch (screenType) {
      case ScreenType.mobile:
        return mobile;

      case ScreenType.tablet:
        // Use tablet value, fallback to mobile
        return tablet ?? mobile;

      case ScreenType.desktop:
        // Use desktop value, fallback to tablet, then mobile
        return desktop ?? tablet ?? mobile;
    }
  }

  /// Shorthand method - same as getValue()
  T call(BuildContext context) => getValue(context);
}

/// Extension on BuildContext for easier responsive values
extension ResponsiveContext on BuildContext {
  /// Returns different values based on screen type
  ///
  /// Example:
  /// ```dart
  /// final padding = context.responsive(
  ///   mobile: 16.0,
  ///   tablet: 24.0,
  ///   desktop: 32.0,
  /// );
  /// ```
  T responsive<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    return ResponsiveValue(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    ).getValue(this);
  }

  /// Quick access to screen type
  ScreenType get screenType => Breakpoints.getScreenType(this);

  /// Quick boolean checks
  bool get isMobile => Breakpoints.isMobile(this);
  bool get isTablet => Breakpoints.isTablet(this);
  bool get isDesktop => Breakpoints.isDesktop(this);
}
