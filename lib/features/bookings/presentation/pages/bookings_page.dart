import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamaty_app/core/di/injection_container.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import '../cubits/bookings_cubit/bookings_cubit.dart';
import '../cubits/provider_bookings_cubit/provider_bookings_cubit.dart';
import '../widgets/bookings_widgets/my_bookings_tab.dart';
import '../widgets/bookings_widgets/provider_bookings_tab.dart';

/// Unified bookings page with two top-level tabs:
/// - حجوزاتي (My Bookings) — bookings I made as a customer
/// - الحجوزات الواردة (Incoming) — bookings others made for my services
class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<BookingsCubit>()..loadBookings()),
        BlocProvider(
            create: (_) => sl<ProviderBookingsCubit>()..loadBookings()),
      ],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(S.of(context).bookings),
            bottom: TabBar(
              indicatorWeight: 3,
              labelStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              tabs: [
                Tab(text: S.of(context).myBookings),
                Tab(text: S.of(context).providerBookings),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              MyBookingsTab(),
              ProviderBookingsTab(),
            ],
          ),
        ),
      ),
    );
  }
}
