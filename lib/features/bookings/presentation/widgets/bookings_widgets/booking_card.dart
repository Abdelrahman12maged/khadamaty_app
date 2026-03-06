import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamaty_app/core/di/injection_container.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';
import 'package:khadamaty_app/core/utils/ui_helpers.dart';
import 'package:khadamaty_app/features/bookings/presentation/widgets/bookings_widgets/open_chat_button.dart';
import 'package:khadamaty_app/features/chat_system/presentation/cubits/open_chat_cubit/open_chat_cubit.dart';
import 'package:khadamaty_app/features/chat_system/presentation/cubits/open_chat_cubit/open_chat_state.dart';
import 'package:khadamaty_app/features/chat_system/presentation/pages/chat_page.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/booking_entity.dart';
import '../../cubits/provider_bookings_cubit/provider_bookings_cubit.dart';
import 'package:khadamaty_app/features/Payment/presentation/pages/payment_screen.dart';
import 'booking_status_badge.dart';
import 'placeholder_image.dart';

/// Booking card widget for displaying real booking information
class BookingCard extends StatelessWidget {
  final BookingEntity booking;
  final VoidCallback? onTap;
  final bool isProviderView;

  const BookingCard({
    super.key,
    required this.booking,
    this.onTap,
    this.isProviderView = false,
  });

  @override
  Widget build(BuildContext context) {
    // Use AppSpacing.card for consistent card padding/radius
    final cardPadding = AppSpacing.card(context);
    final borderRadius = AppSpacing.card(context);

    final imageSize = context.responsive(
      mobile: 80.0,
      tablet: 90.0,
      desktop: 100.0,
    );

    return BlocProvider(
      create: (_) => sl<OpenChatCubit>(),
      child: BlocListener<OpenChatCubit, OpenChatState>(
        listener: (context, state) {
          if (state.error != null) {
            UIHelpers.showErrorSnackbar(
              context: context,
              message: 'فشل فتح المحادثة: ${state.error}',
            );
          }
          if (state.chat != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ChatPage(chat: state.chat!),
              ),
            );
          }
        },
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(cardPadding),
            decoration: BoxDecoration(
              color: AppColors.surface(context),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: AppColors.divider(context),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: PlaceholderImage(size: imageSize),
                ),
                SizedBox(width: AppSpacing.sm(context)),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Service Title
                      Text(
                        booking.serviceName,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: AppSpacing.xs(context)),

                      // Provider or Customer name
                      Row(
                        children: [
                          Icon(
                            Icons.person_outline,
                            size: 14,
                            color: AppColors.textSecondary(context),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              isProviderView
                                  ? '${S.of(context).customer}: ${booking.customerId}'
                                  : booking.providerName,
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSpacing.xs(context)),

                      // Date & Time
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 14,
                            color: AppColors.textSecondary(context),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              _formatDateTime(booking.bookingDate),
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSpacing.sm(context)),

                      // Price & Status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Price
                          Text(
                            '${booking.totalPrice.toStringAsFixed(0)} ${S.of(context).currency}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: AppColors.primaryBlue,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          // Status Badge
                          BookingStatusBadge(status: booking.status),
                          if (booking.isPaid)
                            Container(
                              margin: const EdgeInsets.only(left: 6),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                S.of(context).paid,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                        ],
                      ),

                      // Pay Now button (customer + confirmed + not paid)
                      if (!isProviderView &&
                          booking.status == BookingStatus.confirmed &&
                          !booking.isPaid) ...[
                        SizedBox(height: AppSpacing.sm(context)),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () => _navigateToPayment(context),
                            icon: const Icon(Icons.payment, size: 18),
                            label: Text(S.of(context).payNow),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryBlue,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                vertical: AppSpacing.sm(context),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],

                      // Accept/Decline buttons (provider + pending only)
                      if (isProviderView &&
                          booking.status == BookingStatus.pending) ...[
                        SizedBox(height: AppSpacing.sm(context)),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => context
                                    .read<ProviderBookingsCubit>()
                                    .acceptBooking(booking.id),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                    vertical: AppSpacing.sm(context),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(S.of(context).accept),
                              ),
                            ),
                            SizedBox(width: AppSpacing.sm(context)),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => context
                                    .read<ProviderBookingsCubit>()
                                    .declineBooking(booking.id),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.red,
                                  side: const BorderSide(color: Colors.red),
                                  padding: EdgeInsets.symmetric(
                                    vertical: AppSpacing.sm(context),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(S.of(context).decline),
                              ),
                            ),
                          ],
                        ),
                      ],

                      // Chat button (for both provider and customer on active bookings)
                      if (booking.status == BookingStatus.pending ||
                          booking.status == BookingStatus.confirmed) ...[
                        SizedBox(height: AppSpacing.sm(context)),
                        OpenChatButton(booking: booking),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToPayment(BuildContext context) {
    // Convert price to piasters for Stripe (EGP smallest unit: 1 EGP = 100 piasters)
    final amountInPiasters = (booking.totalPrice *100).toInt();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PaymentScreen(
          amount: amountInPiasters,
          currency: 'egp',
          description: booking.serviceName,
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MMM dd, yyyy • hh:mm a').format(dateTime);
  }
}
