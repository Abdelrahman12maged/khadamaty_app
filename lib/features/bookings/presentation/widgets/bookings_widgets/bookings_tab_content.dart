import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import 'package:khadamaty_app/core/widgets/loading_indicator.dart';
import 'package:khadamaty_app/core/widgets/error_display.dart';
import '../../cubits/bookings_cubit/bookings_cubit.dart';
import '../../cubits/bookings_cubit/bookings_state.dart';
import 'bookings_list_view.dart';
import 'empty_bookings_state.dart';

/// Tab content for bookings list
///
/// Handles different states:
/// - Loading state
/// - Error state
/// - Empty state
/// - List of bookings
class BookingsTabContent extends StatelessWidget {
  final BookingsState state;
  final List<BookingData> bookings;
  final String emptyMessage;
  final IconData emptyIcon;

  const BookingsTabContent({
    super.key,
    required this.state,
    required this.bookings,
    required this.emptyMessage,
    required this.emptyIcon,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<BookingsCubit>().refreshBookings(context),
      child: state.isLoading && bookings.isEmpty
          ? LoadingIndicator(message: S.of(context).loadingBookings)
          : state.error != null && bookings.isEmpty
              ? ErrorDisplay(
                  message: state.error!,
                  onRetry: () =>
                      context.read<BookingsCubit>().loadBookings(context),
                )
              : bookings.isEmpty
                  ? SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: EmptyBookingsState(
                          message: emptyMessage,
                          icon: emptyIcon,
                        ),
                      ),
                    )
                  : BookingsListView(
                      bookings: bookings,
                      onBookingTap: () {
                        // TODO: Navigate to booking details
                        // context.push('/booking/${booking.id}');
                      },
                    ),
    );
  }
}
