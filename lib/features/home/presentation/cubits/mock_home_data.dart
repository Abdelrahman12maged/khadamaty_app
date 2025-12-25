import 'package:flutter/material.dart';
import 'home_state.dart';

/// Mock data for home screen
/// TODO: Replace with actual data from repository
class MockHomeData {
  static List<CategoryData> getCategories() {
    return const [
      CategoryData(
        id: '1',
        name: 'Cleaning',
        icon: 'cleaning_services',
        gradientStartColor: 0xFF2196F3,
        gradientEndColor: 0xFF1976D2,
        serviceCount: 15,
      ),
      CategoryData(
        id: '2',
        name: 'Plumbing',
        icon: 'plumbing',
        gradientStartColor: 0xFFFF9800,
        gradientEndColor: 0xFFF57C00,
        serviceCount: 12,
      ),
      CategoryData(
        id: '3',
        name: 'Electrical',
        icon: 'electrical_services',
        gradientStartColor: 0xFFFFC107,
        gradientEndColor: 0xFFFFA000,
        serviceCount: 18,
      ),
      CategoryData(
        id: '4',
        name: 'Carpentry',
        icon: 'carpenter',
        gradientStartColor: 0xFF795548,
        gradientEndColor: 0xFF5D4037,
        serviceCount: 10,
      ),
      CategoryData(
        id: '5',
        name: 'Painting',
        icon: 'format_paint',
        gradientStartColor: 0xFF9C27B0,
        gradientEndColor: 0xFF7B1FA2,
        serviceCount: 14,
      ),
      CategoryData(
        id: '6',
        name: 'AC Repair',
        icon: 'ac_unit',
        gradientStartColor: 0xFF00BCD4,
        gradientEndColor: 0xFF0097A7,
        serviceCount: 8,
      ),
    ];
  }

  static List<ServiceData> getFeaturedServices(BuildContext context) {
    return const [
      ServiceData(
        id: '1',
        title: 'House Deep Cleaning',
        description: 'Professional deep cleaning for your entire house',
        providerName: 'Ahmed Hassan',
        price: 150.0,
        priceUnit: 'per visit',
        rating: 4.8,
        reviewCount: 120,
        imageUrl:
            'https://images.unsplash.com/photo-1585421514738-01798e348b17?w=400&h=300&fit=crop',
      ),
      ServiceData(
        id: '2',
        title: 'AC Installation',
        description: 'Expert AC installation and maintenance service',
        providerName: 'Mohamed Ali',
        price: 200.0,
        priceUnit: 'per visit',
        rating: 4.9,
        reviewCount: 85,
        imageUrl:
            'https://images.unsplash.com/photo-1621905251918-48416bd8575a?w=400&h=300&fit=crop',
      ),
      ServiceData(
        id: '3',
        title: 'Electrical Wiring',
        description: 'Complete electrical wiring and repair services',
        providerName: 'Sara Ibrahim',
        price: 80.0,
        priceUnit: 'per hour',
        rating: 4.7,
        reviewCount: 95,
        imageUrl:
            'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?w=400&h=300&fit=crop',
      ),
      ServiceData(
        id: '4',
        title: 'Home Painting',
        description: 'Professional painting services for all rooms',
        providerName: 'Khaled Ahmed',
        price: 120.0,
        priceUnit: 'per visit',
        rating: 4.6,
        reviewCount: 75,
        imageUrl:
            'https://images.unsplash.com/photo-1562259949-e8e7689d7828?w=400&h=300&fit=crop',
      ),
    ];
  }

  static List<ServiceData> getPopularProviders(BuildContext context) {
    return const [
      ServiceData(
        id: '5',
        title: 'Premium Cleaning Service',
        description: 'Top-rated cleaning service with 5+ years experience',
        providerName: 'Fatima Ali',
        price: 180.0,
        priceUnit: 'per visit',
        rating: 4.9,
        reviewCount: 200,
        imageUrl:
            'https://images.unsplash.com/photo-1628177142898-93e36e4e3a50?w=400&h=300&fit=crop',
      ),
      ServiceData(
        id: '6',
        title: 'Expert Plumbing Solutions',
        description: 'Fast and reliable plumbing repairs',
        providerName: 'Hassan Mohamed',
        price: 100.0,
        priceUnit: 'per hour',
        rating: 4.8,
        reviewCount: 150,
        imageUrl:
            'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=400&h=300&fit=crop',
      ),
      ServiceData(
        id: '7',
        title: 'Professional Electrician',
        description: 'Licensed electrician for all your electrical needs',
        providerName: 'Omar Abdullah',
        price: 90.0,
        priceUnit: 'per hour',
        rating: 4.7,
        reviewCount: 130,
        imageUrl:
            'https://images.unsplash.com/photo-1473341304170-971dccb5ac1e?w=400&h=300&fit=crop',
      ),
    ];
  }
}
