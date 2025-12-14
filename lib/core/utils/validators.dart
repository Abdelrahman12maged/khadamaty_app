import 'package:khadamaty_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class Validators {
  Validators._();

  /// Validates email address
  static String? email(String? value, BuildContext context) {
    final s = S.of(context);

    if (value == null || value.isEmpty) {
      return s.pleaseEnterEmail;
    }

    // Basic email regex pattern
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return s.pleaseEnterValidEmail;
    }

    return null;
  }

  /// Validates password
  static String? password(String? value, BuildContext context,
      {int minLength = 6}) {
    final s = S.of(context);

    if (value == null || value.isEmpty) {
      return s.pleaseEnterPassword;
    }

    if (value.length < minLength) {
      return s.passwordMinLength;
    }

    return null;
  }

  /// Validates required field
  static String? required(
      String? value, BuildContext context, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }
    return null;
  }

  /// Validates phone number
  static String? phone(String? value, BuildContext context) {
    final s = S.of(context);

    if (value == null || value.isEmpty) {
      return s.pleaseEnterPhone;
    }

    // Remove any spaces, dashes, or parentheses
    final cleanedNumber = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    // Check if it contains only digits and has appropriate length
    if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(cleanedNumber)) {
      return s.pleaseEnterValidPhone;
    }

    return null;
  }

  /// Validates name (requires full name: first + last)
  static String? name(String? value, BuildContext context) {
    final s = S.of(context);

    if (value == null || value.isEmpty) {
      return s.pleaseEnterName;
    }

    // Trim and check minimum length
    final trimmedValue = value.trim();
    if (trimmedValue.length < 2) {
      return s.pleaseEnterName;
    }

    // Check for at least 2 words (first name + last name)
    final words = trimmedValue.split(RegExp(r'\s+'));
    if (words.length < 2 || words.any((word) => word.isEmpty)) {
      return s.pleaseEnterFullName;
    }

    return null;
  }

  /// Validates confirm password matches original password
  static String? confirmPassword(
    String? value,
    String originalPassword,
    BuildContext context,
  ) {
    final s = S.of(context);

    if (value == null || value.isEmpty) {
      return s.pleaseEnterPassword;
    }

    if (value != originalPassword) {
      return 'Passwords do not match';
    }

    return null;
  }

  /// Validates minimum length
  static String? minLength(
    String? value,
    int length,
    BuildContext context,
    String fieldName,
  ) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }

    if (value.length < length) {
      return '$fieldName must be at least $length characters';
    }

    return null;
  }

  /// Validates maximum length
  static String? maxLength(
    String? value,
    int length,
    BuildContext context,
    String fieldName,
  ) {
    if (value != null && value.length > length) {
      return '$fieldName must be less than $length characters';
    }

    return null;
  }
}
