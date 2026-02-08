import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';
import 'package:khadamaty_app/features/bookings/domain/entities/booking_entity.dart';
import 'booking_card.dart';

/// Responsive bookings list widget
///
/// Displays bookings in:
/// - Grid layout (2 columns) on tablet/desktop
/// - List layout (single column) on mobile
class BookingsListView extends StatelessWidget {
  final List<BookingEntity> bookings;
  final VoidCallback? onBookingTap;

  const BookingsListView({
    super.key,
    required this.bookings,
    this.onBookingTap,
  });

  @override
  Widget build(BuildContext context) {
    // Use project's responsive system
    final isDesktop = context.isDesktop;
    final isTablet = context.isTablet;

    // Grid on tablet/desktop, list on mobile
    if (isDesktop || isTablet) {
      return _buildGridView(context, isDesktop);
    }

    return _buildListView(context);
  }

  /// Grid view for tablet/desktop
  Widget _buildGridView(BuildContext context, bool isDesktop) {
    final crossAxisCount = 2; // 2 columns for both tablet and desktop
    final maxWidth = isDesktop ? 1400.0 : double.infinity;

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          padding: EdgeInsets.all(AppSpacing.page(context)),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: AppSpacing.md(context),
              mainAxisSpacing: AppSpacing.md(context),
              childAspectRatio: isDesktop ? 3.2 : 2.8,
            ),
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index];
              return BookingCard(
                booking: booking,
                onTap: onBookingTap,
              );
            },
          ),
        ),
      ),
    );
  }

  /// List view for mobile
  Widget _buildListView(BuildContext context) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.all(AppSpacing.page(context)),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return Padding(
          padding: EdgeInsets.only(
            bottom: index < bookings.length - 1 ? AppSpacing.md(context) : 0,
          ),
          child: BookingCard(
            booking: booking,
            onTap: onBookingTap,
          ),
        );
      },
    );
  }
}
