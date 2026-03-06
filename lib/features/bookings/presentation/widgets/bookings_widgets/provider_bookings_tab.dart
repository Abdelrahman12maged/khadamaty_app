import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/ui_helpers.dart';
import 'package:khadamaty_app/core/widgets/loading_indicator.dart';
import 'package:khadamaty_app/core/widgets/error_display.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import '../../cubits/provider_bookings_cubit/provider_bookings_cubit.dart';
import '../../cubits/provider_bookings_cubit/provider_bookings_state.dart';
import '../../../domain/entities/booking_entity.dart';
import 'bookings_list_view.dart';
import 'empty_bookings_state.dart';

/// Provider Bookings tab — with sub-tabs (upcoming / past / cancelled)
class ProviderBookingsTab extends StatelessWidget {
  const ProviderBookingsTab({super.key});

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
            child: BlocConsumer<ProviderBookingsCubit, ProviderBookingsState>(
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
                    ProviderSubTabContent(
                      state: state,
                      bookings: state.upcomingBookings,
                      emptyMessage: S.of(context).noUpcomingBookings,
                      emptyIcon: Icons.event_available,
                    ),
                    ProviderSubTabContent(
                      state: state,
                      bookings: state.pastBookings,
                      emptyMessage: S.of(context).noPastBookings,
                      emptyIcon: Icons.history,
                    ),
                    ProviderSubTabContent(
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

/// Sub-tab content for provider bookings (uses ProviderBookingsCubit)
class ProviderSubTabContent extends StatelessWidget {
  final ProviderBookingsState state;
  final List<BookingEntity> bookings;
  final String emptyMessage;
  final IconData emptyIcon;

  const ProviderSubTabContent({
    super.key,
    required this.state,
    required this.bookings,
    required this.emptyMessage,
    required this.emptyIcon,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<ProviderBookingsCubit>().refreshBookings(),
      child: state.isLoading && bookings.isEmpty
          ? LoadingIndicator(message: S.of(context).loadingBookings)
          : state.error != null && bookings.isEmpty
              ? ErrorDisplay(
                  message: state.error!,
                  onRetry: () =>
                      context.read<ProviderBookingsCubit>().loadBookings(),
                )
              : bookings.isEmpty
                  ? SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: EmptyBookingsState(
                          message: emptyMessage,
                          icon: emptyIcon,
                        ),
                      ),
                    )
                  : BookingsListView(
                      bookings: bookings,
                      isProviderView: true,
                      onBookingTap: () {},
                    ),
    );
  }
}
