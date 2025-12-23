import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import 'package:khadamaty_app/core/widgets/responsive_layout.dart';
import 'package:khadamaty_app/core/widgets/loading_indicator.dart';
import 'package:khadamaty_app/core/widgets/error_display.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:go_router/go_router.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/section_header.dart';
import '../widgets/categories_section.dart';
import '../widgets/featured_services_section.dart';
import '../widgets/popular_providers_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..loadHomeData(context),
      child: Scaffold(
        appBar: const HomeAppBar(),
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            // Show snackbar on error
            if (state.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error!),
                  backgroundColor: Colors.red,
                  action: SnackBarAction(
                    label: 'Retry',
                    textColor: Colors.white,
                    onPressed: () {
                      context.read<HomeCubit>().loadHomeData(context);
                    },
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            // Show loading on initial load
            if (state.isLoading && state.categories.isEmpty) {
              return const LoadingIndicator(message: 'Loading home data...');
            }

            // Show error if no data and has error
            if (state.error != null && state.categories.isEmpty) {
              return ErrorDisplay(
                message: state.error!,
                onRetry: () => context.read<HomeCubit>().loadHomeData(context),
              );
            }

            // Show content
            return RefreshIndicator(
              onRefresh: () =>
                  context.read<HomeCubit>().refreshHomeData(context),
              child: ResponsiveLayout(
                useCard: false,
                mobileMaxWidth: double.infinity,
                tabletMaxWidth: 900.0,
                desktopMaxWidth: 1200.0,
                mobilePadding: 16.0,
                tabletPadding: 32.0,
                desktopPadding: 40.0,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search Bar
                      SearchBarWidget(
                        onTap: () => context.go('/explore'),
                      ),

                      SizedBox(height: AppSpacing.lg(context)),

                      // Categories Section
                      SectionHeader(
                        title: S.of(context).categories,
                        seeAllText: S.of(context).seeAll,
                        onSeeAllTap: () => context.go('/explore'),
                      ),

                      SizedBox(height: AppSpacing.header(context)),

                      const CategoriesSection(),

                      SizedBox(height: AppSpacing.section(context)),

                      // Featured Services Section
                      SectionHeader(
                        title: S.of(context).featuredServices,
                        seeAllText: S.of(context).seeAll,
                        onSeeAllTap: () => context.go('/explore'),
                      ),

                      SizedBox(height: AppSpacing.header(context)),

                      const FeaturedServicesSection(),

                      SizedBox(height: AppSpacing.section(context)),

                      // Popular Providers Section
                      SectionHeader(
                        title: S.of(context).popularProviders,
                        seeAllText: S.of(context).seeAll,
                        onSeeAllTap: () => context.go('/explore'),
                      ),

                      SizedBox(height: AppSpacing.header(context)),

                      const PopularProvidersSection(),

                      SizedBox(height: AppSpacing.section(context)),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
