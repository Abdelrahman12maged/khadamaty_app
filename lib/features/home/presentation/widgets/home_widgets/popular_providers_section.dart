import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import '../../cubits/home_cubit/mock_home_data.dart';
import 'service_card.dart';

/// Popular Providers Section Widget
class PopularProvidersSection extends StatelessWidget {
  const PopularProvidersSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Get providers from centralized mock data
    final providers = MockHomeData.getPopularProviders(context);

    // Desktop/tablet: show grid
    if (!context.isMobile) {
      final crossAxisCount =
          context.responsive(mobile: 2, tablet: 2, desktop: 3);
      final spacing = AppSpacing.md(context);

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing,
          childAspectRatio: 0.85,
        ),
        itemCount: providers.length,
        itemBuilder: (context, index) {
          final provider = providers[index];
          return ServiceCard(
            title: provider.title,
            description: provider.description,
            providerName: provider.providerName,
            price: provider.price,
            priceUnit: _getLocalizedPriceUnit(context, provider.priceUnit),
            rating: provider.rating,
            reviewCount: provider.reviewCount,
            imageUrl: provider.imageUrl,
            isInGrid: true,
            onTap: () {
              // TODO: Navigate to provider profile (/provider/${provider.id})
              // Will implement when provider profile page is created
            },
          );
        },
      );
    }

    // Mobile: horizontal scroll
    final cardHeight =
        context.responsive(mobile: 280.0, tablet: 300.0, desktop: 320.0);

    return SizedBox(
      height: cardHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: providers.length,
        itemBuilder: (context, index) {
          final provider = providers[index];
          return ServiceCard(
            title: provider.title,
            description: provider.description,
            providerName: provider.providerName,
            price: provider.price,
            priceUnit: _getLocalizedPriceUnit(context, provider.priceUnit),
            rating: provider.rating,
            reviewCount: provider.reviewCount,
            imageUrl: provider.imageUrl,
            isInGrid: false,
            onTap: () {
              // TODO: Navigate to provider profile (/provider/${provider.id})
              // Will implement when provider profile page is created
            },
          );
        },
      ),
    );
  }

  // Helper to get localized price unit
  String _getLocalizedPriceUnit(BuildContext context, String unit) {
    if (unit == 'per visit') return S.of(context).perVisit;
    if (unit == 'per hour') return S.of(context).perHour;
    return unit;
  }
}
