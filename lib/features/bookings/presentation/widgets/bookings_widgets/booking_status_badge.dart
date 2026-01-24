import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';
import 'package:khadamaty_app/features/bookings/domain/entities/booking_entity.dart';
import 'package:khadamaty_app/generated/l10n.dart';

/// Status badge for booking cards
class BookingStatusBadge extends StatelessWidget {
  final BookingStatus status;

  const BookingStatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final config = _getStatusConfig(context, status);
    final iconSize = context.responsive(
      mobile: 14.0,
      tablet: 16.0,
      desktop: 18.0,
    );
    final fontSize = context.responsive(
      mobile: 11.0,
      tablet: 12.0,
      desktop: 13.0,
    );

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal:
            context.responsive(mobile: 8.0, tablet: 10.0, desktop: 12.0),
        vertical: context.responsive(mobile: 4.0, tablet: 5.0, desktop: 6.0),
      ),
      decoration: BoxDecoration(
        color: config.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: config.color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            config.icon,
            size: iconSize,
            color: config.color,
          ),
          const SizedBox(width: 6),
          Text(
            config.label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: config.color,
            ),
          ),
        ],
      ),
    );
  }

  _StatusConfig _getStatusConfig(BuildContext context, BookingStatus status) {
    switch (status) {
      case BookingStatus.pending:
        return _StatusConfig(
          label: S.of(context).pending,
          icon: Icons.schedule,
          color: AppColors.warningAmber,
        );
      case BookingStatus.confirmed:
        return _StatusConfig(
          label: S.of(context).confirmed,
          icon: Icons.check_circle,
          color: AppColors.successGreen,
        );
      case BookingStatus.completed:
        return _StatusConfig(
          label: S.of(context).completed,
          icon: Icons.done_all,
          color: AppColors.primaryBlue,
        );
      case BookingStatus.cancelled:
        return _StatusConfig(
          label: S.of(context).cancelled,
          icon: Icons.cancel,
          color: AppColors.errorRed,
        );
      case BookingStatus.declined:
        return _StatusConfig(
          label: 'تم الرفض', // Add to L10n later if needed
          icon: Icons.block,
          color: AppColors.errorRed,
        );
    }
  }
}

class _StatusConfig {
  final String label;
  final IconData icon;
  final Color color;

  _StatusConfig({
    required this.label,
    required this.icon,
    required this.color,
  });
}
