import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/features/provider/domain/entities/service_entity.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import 'service_card.dart';

/// Reusable services grid widget
class ServicesGrid extends StatelessWidget {
  final List<ServiceEntity> services;
  final VoidCallback? onServiceTap;

  const ServicesGrid({
    super.key,
    required this.services,
    this.onServiceTap,
  });

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = context.responsive(mobile: 2, tablet: 3, desktop: 4);
    final spacing = AppSpacing.md(context);
    // Taller cards than home screen to fit all content without overflow
    final aspectRatio = 0.73;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: aspectRatio,
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
          onTap: onServiceTap,
        );
      },
    );
  }

  // Helper to get localized price unit
  String _getLocalizedPriceUnit(BuildContext context, String unit) {
    if (unit == 'per visit') return S.of(context).perVisit;
    if (unit == 'per hour') return S.of(context).perHour;
    return unit;
  }
}
