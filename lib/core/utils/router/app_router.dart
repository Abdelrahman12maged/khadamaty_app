import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import 'package:go_router/go_router.dart';
import 'package:khadamaty_app/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:khadamaty_app/features/auth/presentation/pages/login_screen.dart';
import 'package:khadamaty_app/features/auth/presentation/pages/signup_screen.dart';
import 'package:khadamaty_app/features/auth/presentation/pages/email_verification_screen.dart';

// Helper function to determine initial route based on platform
String _getInitialLocation() {
  // Skip onboarding on web or Windows
  if (kIsWeb) {
    return '/login';
  }

  // Check for Windows (desktop)
  try {
    if (Platform.isWindows) {
      return '/login';
    }
  } catch (e) {
    // Platform not available on web, already handled above
  }

  // Show onboarding on mobile (iOS/Android)
  return '/onboarding';
}

final GoRouter appRouter = GoRouter(
  initialLocation: _getInitialLocation(),
  routes: [
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      name: 'signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/email-verification',
      name: 'emailVerification',
      builder: (context, state) {
        final email = state.uri.queryParameters['email'] ?? '';
        return EmailVerificationScreen(email: email);
      },
    ),
  ],
);
