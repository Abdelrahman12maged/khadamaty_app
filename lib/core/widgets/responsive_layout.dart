import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';

/// A reusable responsive layout widget that adapts to different screen sizes
///
/// Features:
/// - Responsive padding based on screen size
/// - Max width constraint on larger screens
/// - Automatic card elevation on tablet/desktop
/// - Centered content
///
/// Example:
/// ```dart
/// ResponsiveLayout(
///   child: MyScreenContent(),
/// )
/// ```
class ResponsiveLayout extends StatelessWidget {
  /// The content to display
  final Widget child;

  /// Whether to show card on tablet/desktop (default: true)
  final bool useCard;

  /// Custom max width for each screen type
  final double? mobileMaxWidth;
  final double? tabletMaxWidth;
  final double? desktopMaxWidth;

  /// Custom padding for each screen type
  final double? mobilePadding;
  final double? tabletPadding;
  final double? desktopPadding;

  /// Card elevation (only for tablet/desktop when useCard is true)
  final double cardElevation;

  /// Card border radius
  final double cardBorderRadius;

  /// Card internal padding
  final double cardPadding;

  const ResponsiveLayout({
    super.key,
    required this.child,
    this.useCard = true,
    this.mobileMaxWidth,
    this.tabletMaxWidth,
    this.desktopMaxWidth,
    this.mobilePadding,
    this.tabletPadding,
    this.desktopPadding,
    this.cardElevation = 8,
    this.cardBorderRadius = 16,
    this.cardPadding = 32,
  });

  @override
  Widget build(BuildContext context) {
    // 🎯 Responsive padding - changes based on screen size
    final padding = context.responsive(
      mobile: mobilePadding ?? 24.0,
      tablet: tabletPadding ?? 32.0,
      desktop: desktopPadding ?? 48.0,
    );

    // 🎯 Max width for each screen type
    final maxWidth = context.responsive(
      mobile: mobileMaxWidth ?? double.infinity,
      tablet: tabletMaxWidth ?? 600.0,
      desktop: desktopMaxWidth ?? 500.0,
    );

    final isMobile = context.isMobile;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: useCard && !isMobile
              ? Card(
                  elevation: cardElevation,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(cardBorderRadius),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(cardPadding),
                    child: child,
                  ),
                )
              : child,
        ),
      ),
    );
  }
}
