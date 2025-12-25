import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_state.dart';
import 'mock_profile_data.dart';

/// Profile cubit for managing profile state
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());

  /// Load profile data
  Future<void> loadProfile(BuildContext context) async {
    try {
      emit(state.copyWith(status: ProfileStatus.loading, clearError: true));

      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Load mock data
      final profile = MockProfileData.getProfile(context);

      emit(state.copyWith(
        status: ProfileStatus.loaded,
        profile: profile,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.error,
        error: 'Failed to load profile: ${e.toString()}',
      ));
    }
  }

  /// Refresh profile data
  Future<void> refreshProfile(BuildContext context) async {
    await loadProfile(context);
  }

  /// Update profile (placeholder for future implementation)
  Future<void> updateProfile({
    String? name,
    String? email,
    String? avatarUrl,
  }) async {
    if (state.profile == null) return;

    try {
      emit(state.copyWith(status: ProfileStatus.loading));

      // Simulate update delay
      await Future.delayed(const Duration(milliseconds: 800));

      // TODO: Implement actual update logic with backend

      emit(state.copyWith(status: ProfileStatus.loaded));
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.error,
        error: 'Failed to update profile: ${e.toString()}',
      ));
    }
  }
}
