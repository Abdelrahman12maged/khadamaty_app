import 'package:flutter/material.dart';
import 'bookings_state.dart';

/// Mock data for bookings
/// TODO: Replace with actual data from repository
class MockBookingsData {
  static List<BookingData> getBookings(BuildContext context) {
    final now = DateTime.now();

    return [
      // Upcoming bookings
      BookingData(
        id: '1',
        serviceTitle: 'House Deep Cleaning',
        providerName: 'Ahmed Hassan',
        imageUrl:
            'https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=400',
        bookingDate: now.add(const Duration(days: 2)),
        timeSlot: '10:00 AM - 12:00 PM',
        price: 150.0,
        status: BookingStatus.confirmed,
        address: '123 Main St, Apartment 5A',
      ),
      BookingData(
        id: '2',
        serviceTitle: 'AC Installation',
        providerName: 'Mohamed Ali',
        imageUrl:
            'https://images.unsplash.com/photo-1585771724684-38269d6639fd?w=400',
        bookingDate: now.add(const Duration(days: 5)),
        timeSlot: '2:00 PM - 4:00 PM',
        price: 200.0,
        status: BookingStatus.pending,
        address: '456 Oak Ave',
      ),
      BookingData(
        id: '3',
        serviceTitle: 'Plumbing Repair',
        providerName: 'Khaled Ibrahim',
        imageUrl:
            'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=400',
        bookingDate: now.add(const Duration(days: 7)),
        timeSlot: '9:00 AM - 11:00 AM',
        price: 120.0,
        status: BookingStatus.confirmed,
        address: '789 Pine Rd',
      ),

      // Past bookings
      BookingData(
        id: '4',
        serviceTitle: 'Electrical Work',
        providerName: 'Hassan Ahmed',
        imageUrl:
            'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?w=400',
        bookingDate: now.subtract(const Duration(days: 5)),
        timeSlot: '1:00 PM - 3:00 PM',
        price: 180.0,
        status: BookingStatus.completed,
        address: '321 Elm St',
      ),
      BookingData(
        id: '5',
        serviceTitle: 'Painting Service',
        providerName: 'Mahmoud Salem',
        imageUrl:
            'https://images.unsplash.com/photo-1562259949-e8e7689d7828?w=400',
        bookingDate: now.subtract(const Duration(days: 15)),
        timeSlot: '10:00 AM - 5:00 PM',
        price: 350.0,
        status: BookingStatus.completed,
        address: '654 Maple Dr',
      ),
      BookingData(
        id: '6',
        serviceTitle: 'Carpet Cleaning',
        providerName: 'Youssef Omar',
        imageUrl:
            'https://images.unsplash.com/photo-1628177142898-93e36e4e3a50?w=400',
        bookingDate: now.subtract(const Duration(days: 20)),
        timeSlot: '11:00 AM - 1:00 PM',
        price: 100.0,
        status: BookingStatus.completed,
        address: '987 Cedar Ln',
      ),

      // Cancelled bookings
      BookingData(
        id: '7',
        serviceTitle: 'Window Cleaning',
        providerName: 'Ali Hassan',
        imageUrl:
            'https://images.unsplash.com/photo-1600585152220-90363fe7e115?w=400',
        bookingDate: now.subtract(const Duration(days: 3)),
        timeSlot: '3:00 PM - 5:00 PM',
        price: 80.0,
        status: BookingStatus.cancelled,
        address: '147 Birch Ave',
      ),
      BookingData(
        id: '8',
        serviceTitle: 'Garden Maintenance',
        providerName: 'Ibrahim Khalil',
        imageUrl:
            'https://images.unsplash.com/photo-1558904541-efa843a96f01?w=400',
        bookingDate: now.add(const Duration(days: 1)),
        timeSlot: '8:00 AM - 12:00 PM',
        price: 150.0,
        status: BookingStatus.cancelled,
        address: '258 Willow Rd',
      ),
    ];
  }
}
