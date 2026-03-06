import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/ui_helpers.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import '../../cubits/bookings_cubit/bookings_cubit.dart';
import '../../cubits/bookings_cubit/bookings_state.dart';
import 'bookings_tab_content.dart';

/// My Bookings tab — with sub-tabs (upcoming / past / cancelled)
class MyBookingsTab extends StatelessWidget {
  const MyBookingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Material(
            color: AppColors.surface(context),
            child: TabBar(
              labelColor: AppColors.primaryBlue,
              unselectedLabelColor: AppColors.textSecondary(context),
              indicatorColor: AppColors.primaryBlue,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(text: S.of(context).upcoming),
                Tab(text: S.of(context).past),
                Tab(text: S.of(context).cancelled),
              ],
            ),
          ),
          Expanded(
            child: BlocConsumer<BookingsCubit, BookingsState>(
              listener: (context, state) {
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
                    BookingsTabContent(
                      state: state,
                      bookings: state.upcomingBookings,
                      emptyMessage: S.of(context).noUpcomingBookings,
                      emptyIcon: Icons.event_available,
                    ),
                    BookingsTabContent(
                      state: state,
                      bookings: state.pastBookings,
                      emptyMessage: S.of(context).noPastBookings,
                      emptyIcon: Icons.history,
                    ),
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
        ],
      ),
    );
  }
}
