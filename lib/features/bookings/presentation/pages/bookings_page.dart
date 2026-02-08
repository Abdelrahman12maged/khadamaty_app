import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamaty_app/core/di/injection_container.dart';
import 'package:khadamaty_app/core/utils/ui_helpers.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import '../cubits/bookings_cubit/bookings_cubit.dart';
import '../cubits/bookings_cubit/bookings_state.dart';
import '../widgets/bookings_widgets/bookings_tab_content.dart';

/// Bookings page with tab navigation
class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BookingsCubit>()..loadBookings(),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(S.of(context).bookings),
            bottom: TabBar(
              tabs: [
                Tab(text: S.of(context).upcoming),
                Tab(text: S.of(context).past),
                Tab(text: S.of(context).cancelled),
              ],
            ),
          ),
          body: BlocConsumer<BookingsCubit, BookingsState>(
            listener: (context, state) {
              // Show error snackbar
              if (state.error != null) {
                UIHelpers.showErrorSnackbar(
                  context: context,
                  message: state.error!,
                );
              }
            },
            builder: (context, state) {
              return TabBarView(
                children: [
                  // Upcoming Tab
                  BookingsTabContent(
                    state: state,
                    bookings: state.upcomingBookings,
                    emptyMessage: S.of(context).noUpcomingBookings,
                    emptyIcon: Icons.event_available,
                  ),
                  // Past Tab
                  BookingsTabContent(
                    state: state,
                    bookings: state.pastBookings,
                    emptyMessage: S.of(context).noPastBookings,
                    emptyIcon: Icons.history,
                  ),
                  // Cancelled Tab
                  BookingsTabContent(
                    state: state,
                    bookings: state.cancelledBookings,
                    emptyMessage: S.of(context).noCancelledBookings,
                    emptyIcon: Icons.event_busy,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
