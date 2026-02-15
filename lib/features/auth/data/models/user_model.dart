import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:khadamaty_app/features/auth/domain/entities/user_entity.dart';

/// User Model for Firestore serialization
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    required super.name,
    super.phoneNumber,
    super.profileImageUrl,
    super.isEmailVerified,
    super.isPhoneVerified,
    super.location,
    super.createdAt,
    super.stripeCustomerId,
  });

  /// Create from Firestore document
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final json = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      email: json['email'] as String? ?? '',
      name: json['name'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
      isPhoneVerified: json['isPhoneVerified'] as bool? ?? false,
      location: json['location'] as String?,
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] as Timestamp).toDate()
          : null,
      stripeCustomerId: json['stripeCustomerId'] as String?,
    );
  }

  /// Create from JSON map
  factory UserModel.fromJson(Map<String, dynamic> json, {String? docId}) {
    return UserModel(
      id: docId ?? json['id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      name: json['name'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
      isPhoneVerified: json['isPhoneVerified'] as bool? ?? false,
      location: json['location'] as String?,
      createdAt: _parseDateTime(json['createdAt']),
      stripeCustomerId: json['stripeCustomerId'] as String?,
    );
  }

  static DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.tryParse(value);
    return null;
  }

  /// Create from UserEntity
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      phoneNumber: entity.phoneNumber,
      profileImageUrl: entity.profileImageUrl,
      isEmailVerified: entity.isEmailVerified,
      isPhoneVerified: entity.isPhoneVerified,
      location: entity.location,
      createdAt: entity.createdAt,
      stripeCustomerId: entity.stripeCustomerId,
    );
  }

  /// Convert to Firestore map
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
      'isEmailVerified': isEmailVerified,
      'isPhoneVerified': isPhoneVerified,
      'location': location,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'stripeCustomerId': stripeCustomerId,
    };
  }

  /// Convert to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
      'isEmailVerified': isEmailVerified,
      'isPhoneVerified': isPhoneVerified,
      'location': location,
      'createdAt': createdAt?.toIso8601String(),
      'stripeCustomerId': stripeCustomerId,
    };
  }

  @override
  UserModel copyWith({
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
    return UserModel(
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
}
