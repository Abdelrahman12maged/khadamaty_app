import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';
import 'package:khadamaty_app/features/bookings/presentation/pages/bookings_page.dart';
import '../cubits/navigation_cubit.dart';
import '../widgets/home_widgets/side_navigation_rail.dart';
import '../widgets/home_widgets/app_bottom_navigation_bar.dart';
import 'home_screen.dart';
import 'package:khadamaty_app/features/explore/presentation/pages/explore_page.dart';
import 'profile_page.dart';

/// Main screen with adaptive navigation:
/// - Desktop: Side NavigationRail
/// - Mobile/Tablet: Bottom NavigationBar
class MainScreen extends StatelessWidget {
  final int initialTab;

  const MainScreen({super.key, this.initialTab = 0});

  static final List<Widget> _pages = const [
    HomeScreen(),
    ExplorePage(),
    BookingsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationCubit(initialIndex: initialTab),
      child: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          final navigationCubit = context.read<NavigationCubit>();

          return Scaffold(
            body: context.isDesktop
                ? Row(
                    children: [
                      // Side Navigation Rail for Desktop
                      SideNavigationRail(
                        selectedIndex: state.selectedIndex,
                        onDestinationSelected: navigationCubit.selectPage,
                      ),

                      // Vertical divider
                      const VerticalDivider(thickness: 1, width: 1),

                      // Main content
                      Expanded(
                        child: IndexedStack(
                          index: state.selectedIndex,
                          children: _pages,
                        ),
                      ),
                    ],
                  )
                : IndexedStack(
                    index: state.selectedIndex,
                    children: _pages,
                  ),
            bottomNavigationBar: context.isDesktop
                ? null
                : AppBottomNavigationBar(
                    currentIndex: state.selectedIndex,
                    onTap: navigationCubit.selectPage,
                  ),
          );
        },
      ),
    );
  }
}
