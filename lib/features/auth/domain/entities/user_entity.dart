import 'package:equatable/equatable.dart';

/// User entity - pure business object
/// This is the core user representation used throughout the app
class UserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? phoneNumber;
  final String? profileImageUrl;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final String? location;
  final DateTime? createdAt;
  final String? stripeCustomerId;

  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    this.phoneNumber,
    this.profileImageUrl,
    this.isEmailVerified = false,
    this.isPhoneVerified = false,
    this.location,
    this.createdAt,
    this.stripeCustomerId,
  });

  /// Create a copy with updated fields
  UserEntity copyWith({
    String? id,
    String? email,
    String? name,
    String? phoneNumber,
    String? profileImageUrl,
    bool? isEmailVerified,
    bool? isPhoneVerified,
    String? location,
    DateTime? createdAt,
    String? stripeCustomerId,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      location: location ?? this.location,
      createdAt: createdAt ?? this.createdAt,
      stripeCustomerId: stripeCustomerId ?? this.stripeCustomerId,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        phoneNumber,
        profileImageUrl,
        isEmailVerified,
        isPhoneVerified,
        location,
        createdAt,
        stripeCustomerId,
      ];
}
