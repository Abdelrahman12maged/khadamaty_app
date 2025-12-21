import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import '../widgets/service_card.dart';

/// Featured Services Section Widget
class FeaturedServicesSection extends StatelessWidget {
  const FeaturedServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock featured services data
    final services = [
      {
        'title': 'House Deep Cleaning',
        'description': 'Professional deep cleaning for your entire house',
        'provider': 'Ahmed Hassan',
        'price': 150.0,
        'priceUnit': S.of(context).perVisit,
        'rating': 4.8,
        'reviews': 120,
      },
      {
        'title': 'AC Installation',
        'description': 'Expert AC installation and maintenance service',
        'provider': 'Mohamed Ali',
        'price': 200.0,
        'priceUnit': S.of(context).perVisit,
        'rating': 4.9,
        'reviews': 85,
      },
      {
        'title': 'Electrical Wiring',
        'description': 'Complete electrical wiring and repair services',
        'provider': 'Sara Ibrahim',
        'price': 80.0,
        'priceUnit': S.of(context).perHour,
        'rating': 4.7,
        'reviews': 95,
      },
      {
        'title': 'Home Painting',
        'description': 'Professional painting services for all rooms',
        'provider': 'Khaled Ahmed',
        'price': 120.0,
        'priceUnit': S.of(context).perVisit,
        'rating': 4.6,
        'reviews': 75,
      },
    ];

    // On desktop/tablet, show grid instead of horizontal scroll
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
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return ServiceCard(
            title: service['title'] as String,
            description: service['description'] as String,
            providerName: service['provider'] as String,
            price: service['price'] as double,
            priceUnit: service['priceUnit'] as String,
            rating: service['rating'] as double,
            reviewCount: service['reviews'] as int,
            isInGrid: true,
            onTap: () {
              // TODO: Navigate to service details
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
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return ServiceCard(
            title: service['title'] as String,
            description: service['description'] as String,
            providerName: service['provider'] as String,
            price: service['price'] as double,
            priceUnit: service['priceUnit'] as String,
            rating: service['rating'] as double,
            reviewCount: service['reviews'] as int,
            isInGrid: false,
            onTap: () {
              // TODO: Navigate to service details
            },
          );
        },
      ),
    );
  }
}
