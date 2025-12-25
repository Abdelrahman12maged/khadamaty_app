import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import 'package:khadamaty_app/core/widgets/responsive_layout.dart';
import 'package:khadamaty_app/core/widgets/loading_indicator.dart';
import 'package:khadamaty_app/core/widgets/error_display.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import '../cubits/explore_cubit/explore_cubit.dart';
import '../cubits/explore_cubit/explore_state.dart';
import '../cubits/home_cubit/mock_home_data.dart';
import '../widgets/explore_widgets/explore_search_field.dart';
import '../widgets/explore_widgets/category_filter_chips.dart';
import '../widgets/explore_widgets/sort_dropdown.dart';
import '../widgets/explore_widgets/empty_search_state.dart';
import '../widgets/home_widgets/services_grid.dart';

/// Explore page for searching and filtering services
class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExploreCubit()..loadServices(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).explore),
        ),
        body: BlocConsumer<ExploreCubit, ExploreState>(
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
                      context.read<ExploreCubit>().loadServices(context);
                    },
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            // Show loading on initial load
            if (state.isLoading && state.allServices.isEmpty) {
              return LoadingIndicator(message: S.of(context).loadingServices);
            }

            // Show error if no data and has error
            if (state.error != null && state.allServices.isEmpty) {
              return ErrorDisplay(
                message: state.error!,
                onRetry: () =>
                    context.read<ExploreCubit>().loadServices(context),
              );
            }

            // Show content
            return RefreshIndicator(
              onRefresh: () =>
                  context.read<ExploreCubit>().refreshServices(context),
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
                      // Search Field
                      ExploreSearchField(
                        initialValue: state.searchQuery,
                        onChanged: (query) {
                          context.read<ExploreCubit>().searchServices(query);
                        },
                      ),

                      SizedBox(height: AppSpacing.md(context)),

                      // Category Filter Chips
                      CategoryFilterChips(
                        categories: MockHomeData.getCategories(),
                        selectedCategoryId: state.selectedCategoryId,
                        onCategorySelected: (categoryId) {
                          context
                              .read<ExploreCubit>()
                              .filterByCategory(categoryId);
                        },
                      ),

                      SizedBox(height: AppSpacing.md(context)),

                      // Sort Dropdown
                      SortDropdown(
                        selectedOption: state.sortBy,
                        onChanged: (option) {
                          context.read<ExploreCubit>().sortServices(option);
                        },
                      ),

                      SizedBox(height: AppSpacing.lg(context)),

                      // Services Grid or Empty State
                      if (state.filteredServices.isEmpty)
                        EmptySearchState(
                          query: state.searchQuery,
                          onClearFilters: () {
                            context.read<ExploreCubit>().clearAllFilters();
                          },
                        )
                      else
                        ServicesGrid(
                          services: state.filteredServices,
                          onServiceTap: () {
                            // TODO: Navigate to service details
                          },
                        ),

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
