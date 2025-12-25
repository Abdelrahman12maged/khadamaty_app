import 'package:flutter/material.dart';
import 'profile_state.dart';

/// Mock profile data generator
class MockProfileData {
  MockProfileData._();

  /// Generate mock profile data
  static ProfileData getProfile(BuildContext context) {
    return ProfileData(
      id: 'user_001',
      name: 'Ahmed Mohamed',
      email: 'ahmed.mohamed@example.com',
      avatarUrl: null, // Will show placeholder
      memberSince: DateTime(2023, 6, 15),
      totalBookings: 24,
      completedServices: 18,
      totalSpent: 4850.0,
    );
  }
}
