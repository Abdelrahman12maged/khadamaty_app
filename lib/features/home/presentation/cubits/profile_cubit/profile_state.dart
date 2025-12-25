import 'package:equatable/equatable.dart';

/// Profile status enum
enum ProfileStatus {
  initial,
  loading,
  loaded,
  error,
}

/// User profile data model
class ProfileData extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final DateTime memberSince;
  final int totalBookings;
  final int completedServices;
  final double totalSpent;

  const ProfileData({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    required this.memberSince,
    required this.totalBookings,
    required this.completedServices,
    required this.totalSpent,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        avatarUrl,
        memberSince,
        totalBookings,
        completedServices,
        totalSpent,
      ];
}

/// Profile state
class ProfileState extends Equatable {
  final ProfileStatus status;
  final ProfileData? profile;
  final String? error;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.profile,
    this.error,
  });

  /// Copy with helper
  ProfileState copyWith({
    ProfileStatus? status,
    ProfileData? profile,
    String? error,
    bool clearError = false,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      error: clearError ? null : (error ?? this.error),
    );
  }

  /// Computed getters
  bool get isLoading => status == ProfileStatus.loading;
  bool get isLoaded => status == ProfileStatus.loaded;
  bool get hasError => status == ProfileStatus.error;

  @override
  List<Object?> get props => [status, profile, error];
}
