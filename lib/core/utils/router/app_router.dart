import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:khadamaty_app/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:khadamaty_app/features/auth/presentation/pages/login_screen.dart';
import 'package:khadamaty_app/features/auth/presentation/pages/signup_screen.dart';
import 'package:khadamaty_app/features/auth/presentation/pages/email_verification_screen.dart';
import 'package:khadamaty_app/features/home/presentation/pages/main_screen.dart';
import 'package:khadamaty_app/features/home/presentation/pages/service_details_page.dart';
import 'package:khadamaty_app/features/provider/presentation/pages/add_service_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/onboarding',
  redirect: (context, state) async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

    // Check if user is authenticated
    final isAuthenticated = user != null;
    final isEmailVerified = user?.emailVerified ?? false;

    final isGoingToOnboarding = state.matchedLocation == '/onboarding';
    final isGoingToLogin = state.matchedLocation == '/login';
    final isGoingToSignup = state.matchedLocation == '/signup';
    final isGoingToEmailVerification =
        state.matchedLocation == '/email-verification';
    final isGoingToMain = state.matchedLocation == '/main';

    // If user is authenticated and email is verified, go to main screen
    if (isAuthenticated && isEmailVerified) {
      if (isGoingToOnboarding ||
          isGoingToLogin ||
          isGoingToSignup ||
          isGoingToEmailVerification) {
        return '/main';
      }
      return null; // Allow navigation to current destination
    }

    // If user is authenticated but email not verified, go to email verification
    if (isAuthenticated && !isEmailVerified) {
      if (isGoingToOnboarding ||
          isGoingToLogin ||
          isGoingToSignup ||
          isGoingToMain) {
        return '/email-verification?email=${user.email}';
      }
      return null;
    }

    // User is not authenticated
    // Check if should skip onboarding
    final shouldSkipOnboarding = kIsWeb || hasSeenOnboarding || _isDesktop();

    if (shouldSkipOnboarding) {
      // Skip onboarding, show login or current destination
      if (isGoingToOnboarding) {
        return '/login';
      }
      return null;
    }

    // Show onboarding on first launch for mobile
    if (isGoingToMain) {
      return '/onboarding';
    }

    return null;
  },
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
    GoRoute(
      path: '/main',
      name: 'main',
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: '/explore',
      name: 'explore',
      builder: (context, state) => const MainScreen(initialTab: 1),
    ),
    GoRoute(
      path: '/service-details/:id',
      name: 'serviceDetails',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return ServiceDetailsPage(serviceId: id);
      },
    ),
    GoRoute(
      path: '/add-service',
      name: 'addService',
      builder: (context, state) => const AddServicePage(),
    ),
  ],
);

// Helper to check if platform is desktop
bool _isDesktop() {
  try {
    return Platform.isWindows || Platform.isMacOS || Platform.isLinux;
  } catch (e) {
    return false;
  }
}
