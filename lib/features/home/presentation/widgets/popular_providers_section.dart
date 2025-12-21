import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import '../widgets/service_card.dart';

/// Popular Providers Section Widget
class PopularProvidersSection extends StatelessWidget {
  const PopularProvidersSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock providers data
    final providers = [
      {
        'title': 'Premium Home Care',
        'description': '5+ years experience in professional cleaning',
        'provider': 'Fatima Al-Sayed',
        'price': 120.0,
        'priceUnit': S.of(context).perVisit,
        'rating': 5.0,
        'reviews': 250,
      },
      {
        'title': 'Expert Plumber 24/7',
        'description': 'Emergency plumbing services available',
        'provider': 'Khaled Mahmoud',
        'price': 100.0,
        'priceUnit': S.of(context).perHour,
        'rating': 4.9,
        'reviews': 180,
      },
      {
        'title': 'Master Electrician',
        'description': 'Licensed electrician with 10+ years experience',
        'provider': 'Ahmed Saleh',
        'price': 90.0,
        'priceUnit': S.of(context).perHour,
        'rating': 4.8,
        'reviews': 165,
      },
    ];

    // On desktop/tablet, show grid
    if (!context.isMobile) {
      final crossAxisCount =
          context.responsive(mobile: 2, tablet: 2, desktop: 3);

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemCount: providers.length,
        itemBuilder: (context, index) {
          final provider = providers[index];
          return ServiceCard(
            title: provider['title'] as String,
            description: provider['description'] as String,
            providerName: provider['provider'] as String,
            price: provider['price'] as double,
            priceUnit: provider['priceUnit'] as String,
            rating: provider['rating'] as double,
            reviewCount: provider['reviews'] as int,
            isInGrid: true,
            onTap: () {
              // TODO: Navigate to provider profile
            },
          );
        },
      );
    }

    // Mobile: horizontal scroll
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: providers.length,
        itemBuilder: (context, index) {
          final provider = providers[index];
          return ServiceCard(
            title: provider['title'] as String,
            description: provider['description'] as String,
            providerName: provider['provider'] as String,
            price: provider['price'] as double,
            priceUnit: provider['priceUnit'] as String,
            rating: provider['rating'] as double,
            reviewCount: provider['reviews'] as int,
            isInGrid: false,
            onTap: () {
              // TODO: Navigate to provider profile
            },
          );
        },
      ),
    );
  }
}
