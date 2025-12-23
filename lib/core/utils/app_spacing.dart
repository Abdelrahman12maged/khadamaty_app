import 'package:flutter/material.dart';
import 'responsive_value.dart';

/// Responsive spacing constants for consistent spacing throughout the app
class AppSpacing {
  AppSpacing._(); // Private constructor

  /// Extra small spacing: 4-6-8
  static double xs(BuildContext context) {
    return context.responsive(mobile: 4.0, tablet: 6.0, desktop: 8.0);
  }

  /// Small spacing: 8-10-12
  static double sm(BuildContext context) {
    return context.responsive(mobile: 8.0, tablet: 10.0, desktop: 12.0);
  }

  /// Medium spacing: 16-20-24
  static double md(BuildContext context) {
    return context.responsive(mobile: 16.0, tablet: 20.0, desktop: 24.0);
  }

  /// Large spacing: 24-28-32
  static double lg(BuildContext context) {
    return context.responsive(mobile: 24.0, tablet: 28.0, desktop: 32.0);
  }

  /// Extra large spacing: 32-40-48
  static double xl(BuildContext context) {
    return context.responsive(mobile: 32.0, tablet: 40.0, desktop: 48.0);
  }

  /// Section spacing (between major sections): 32-40-48
  static double section(BuildContext context) {
    return context.responsive(mobile: 32.0, tablet: 40.0, desktop: 48.0);
  }

  /// Header spacing (after header, before content): 12-14-16
  static double header(BuildContext context) {
    return context.responsive(mobile: 12.0, tablet: 14.0, desktop: 16.0);
  }

  /// Card spacing (between cards in grid): 12-14-16
  static double card(BuildContext context) {
    return context.responsive(mobile: 12.0, tablet: 14.0, desktop: 16.0);
  }

  /// Page padding: 16-24-32
  static double page(BuildContext context) {
    return context.responsive(mobile: 16.0, tablet: 24.0, desktop: 32.0);
  }
}
