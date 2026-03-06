// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:khadamaty_app/core/di/injection_container.dart';
// import 'package:khadamaty_app/core/utils/ui_helpers.dart';
// import 'package:khadamaty_app/core/widgets/loading_indicator.dart';
// import 'package:khadamaty_app/core/widgets/error_display.dart';
// import 'package:khadamaty_app/generated/l10n.dart';
// import '../cubits/provider_bookings_cubit/provider_bookings_cubit.dart';
// import '../cubits/provider_bookings_cubit/provider_bookings_state.dart';
// import '../widgets/bookings_widgets/bookings_list_view.dart';
// import '../widgets/bookings_widgets/empty_bookings_state.dart';

// /// Page showing bookings received by the current user as a service provider
// class ProviderBookingsPage extends StatelessWidget {
//   const ProviderBookingsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => sl<ProviderBookingsCubit>()..loadBookings(),
//       child: DefaultTabController(
//         length: 3,
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text(S.of(context).providerBookings),
//             bottom: TabBar(
//               tabs: [
//                 Tab(text: S.of(context).upcoming),
//                 Tab(text: S.of(context).past),
//                 Tab(text: S.of(context).cancelled),
//               ],
//             ),
//           ),
//           body: BlocConsumer<ProviderBookingsCubit, ProviderBookingsState>(
//             listener: (context, state) {
//               if (state.error != null) {
//                 UIHelpers.showErrorSnackbar(
//                   context: context,
//                   message: state.error!,
//                 );
//               }
//             },
//             builder: (context, state) {
//               return TabBarView(
//                 children: [
//                   // Upcoming Tab
//                   _ProviderBookingsTabContent(
//                     state: state,
//                     bookings: state.upcomingBookings,
//                     emptyMessage: S.of(context).noUpcomingBookings,
//                     emptyIcon: Icons.event_available,
//                   ),
//                   // Past Tab
//                   _ProviderBookingsTabContent(
//                     state: state,
//                     bookings: state.pastBookings,
//                     emptyMessage: S.of(context).noPastBookings,
//                     emptyIcon: Icons.history,
//                   ),
//                   // Cancelled Tab
//                   _ProviderBookingsTabContent(
//                     state: state,
//                     bookings: state.cancelledBookings,
//                     emptyMessage: S.of(context).noCancelledBookings,
//                     emptyIcon: Icons.event_busy,
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// Tab content that uses ProviderBookingsCubit instead of BookingsCubit
// class _ProviderBookingsTabContent extends StatelessWidget {
//   final ProviderBookingsState state;
//   final List<dynamic> bookings;
//   final String emptyMessage;
//   final IconData emptyIcon;

//   const _ProviderBookingsTabContent({
//     required this.state,
//     required this.bookings,
//     required this.emptyMessage,
//     required this.emptyIcon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       onRefresh: () => context.read<ProviderBookingsCubit>().refreshBookings(),
//       child: state.isLoading && bookings.isEmpty
//           ? LoadingIndicator(message: S.of(context).loadingBookings)
//           : state.error != null && bookings.isEmpty
//               ? ErrorDisplay(
//                   message: state.error!,
//                   onRetry: () =>
//                       context.read<ProviderBookingsCubit>().loadBookings(),
//                 )
//               : bookings.isEmpty
//                   ? SingleChildScrollView(
//                       physics: const AlwaysScrollableScrollPhysics(),
//                       child: SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.7,
//                         child: EmptyBookingsState(
//                           message: emptyMessage,
//                           icon: emptyIcon,
//                         ),
//                       ),
//                     )
//                   : BookingsListView(
//                       bookings: bookings.cast(),
//                       isProviderView: true,
//                       onBookingTap: () {
//                         // TODO: Navigate to booking details
//                       },
//                     ),
//     );
//   }
// }
