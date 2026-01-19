import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import '../../cubits/home_cubit/home_state.dart';
import 'service_card.dart';

/// Featured Services Section Widget
class FeaturedServicesSection extends StatelessWidget {
  final List<ServiceData> services;

  const FeaturedServicesSection({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    if (services.isEmpty) {
      return const Center(child: Text('No featured services available'));
    }

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
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return ServiceCard(
            title: service.title,
            description: service.description,
            providerName: service.providerName,
            price: service.price,
            priceUnit: _getLocalizedPriceUnit(context, service.priceUnit),
            rating: service.rating,
            reviewCount: service.reviewCount,
            imageUrl: service.imageUrl,
            isInGrid: true,
            onTap: () => context.push('/service-details/${service.id}'),
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
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return ServiceCard(
            title: service.title,
            description: service.description,
            providerName: service.providerName,
            price: service.price,
            priceUnit: _getLocalizedPriceUnit(context, service.priceUnit),
            rating: service.rating,
            reviewCount: service.reviewCount,
            imageUrl: service.imageUrl,
            isInGrid: false,
            onTap: () => context.push('/service-details/${service.id}'),
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
