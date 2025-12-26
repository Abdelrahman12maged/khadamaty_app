import 'package:flutter/material.dart';
import '../../../../home/presentation/cubits/home_cubit/home_state.dart';

/// Mock my services data
class MockMyServicesData {
  MockMyServicesData._();

  static List<ServiceData> getMyServices(BuildContext context) {
    return [
      ServiceData(
        id: 'my_service_1',
        title: 'كهربائي منازل',
        description: 'صيانة وتركيب الكهرباء المنزلية',
        providerName: 'أحمد محمد', // Current user
        price: 150.0,
        priceUnit: 'per visit',
        rating: 4.8,
        reviewCount: 24,
        imageUrl: 'https://picsum.photos/seed/electric/400/300',
      ),
      ServiceData(
        id: 'my_service_2',
        title: 'نجارة وتفصيل',
        description: 'تفصيل أثاث خشبي حسب الطلب',
        providerName: 'أحمد محمد',
        price: 200.0,
        priceUnit: 'per hour',
        rating: 4.9,
        reviewCount: 18,
        imageUrl: 'https://picsum.photos/seed/carpentry/400/300',
      ),
    ];
  }
}
