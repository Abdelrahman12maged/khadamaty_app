import 'package:flutter/material.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import 'package:khadamaty_app/core/widgets/responsive_layout.dart';
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
    return Scaffold(
      appBar: const HomeAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: Implement refresh logic
          await Future.delayed(const Duration(seconds: 1));
        },
        child: ResponsiveLayout(
          useCard: false,
          mobileMaxWidth: double.infinity,
          tabletMaxWidth: 900.0,
          desktopMaxWidth: 1200.0,
          mobilePadding: 10.0,
          tabletPadding: 32.0,
          desktopPadding: 40.0,
          child: Column(
            children: [
               SearchBarWidget(
                        onTap: () {


                          // TODO: Navigate to explore/search screen
                        },
                      ),

                 
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search Bar
                     
                      const SizedBox(height: 16),
                
                      // Categories Section
                      SectionHeader(
                        title: S.of(context).categories,
                        seeAllText: S.of(context).seeAll,
                        onSeeAllTap: () {
                          // TODO: Navigate to all categories
                        },
                      ),
                
                      const SizedBox(height: 12),
                
                      const CategoriesSection(),
                
                      const SizedBox(height: 32),
                
                      // Featured Services Section
                      SectionHeader(
                        title: S.of(context).featuredServices,
                        seeAllText: S.of(context).seeAll,
                        onSeeAllTap: () {
                          // TODO: Navigate to all featured services
                        },
                      ),
                
                      const SizedBox(height: 12),
                
                      const FeaturedServicesSection(),
                
                      const SizedBox(height: 32),
                
                      // Popular Providers Section
                      SectionHeader(
                        title: S.of(context).popularProviders,
                        seeAllText: S.of(context).seeAll,
                        onSeeAllTap: () {
                          // TODO: Navigate to all providers
                        },
                      ),
                
                      const SizedBox(height: 12),
                
                      const PopularProvidersSection(),
                
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
