import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import '../cubits/bookings_cubit/bookings_cubit.dart';
import '../cubits/bookings_cubit/bookings_state.dart';
import '../widgets/bookings_widgets/bookings_tab_content.dart';

/// Bookings page with tab navigation
class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingsCubit()..loadBookings(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).bookings),
          bottom: TabBar(
            controller: _tabController,
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error!),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return TabBarView(
              controller: _tabController,
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
    );
  }
}
