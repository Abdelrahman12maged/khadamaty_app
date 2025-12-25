// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Find Local Services`
  String get onboardingTitle1 {
    return Intl.message(
      'Find Local Services',
      name: 'onboardingTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Get connected with the best local service providers in your area.`
  String get onboardingDesc1 {
    return Intl.message(
      'Get connected with the best local service providers in your area.',
      name: 'onboardingDesc1',
      desc: '',
      args: [],
    );
  }

  /// `Book Easily`
  String get onboardingTitle2 {
    return Intl.message(
      'Book Easily',
      name: 'onboardingTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Book appointments with just a few taps.`
  String get onboardingDesc2 {
    return Intl.message(
      'Book appointments with just a few taps.',
      name: 'onboardingDesc2',
      desc: '',
      args: [],
    );
  }

  /// `Secure Payments`
  String get onboardingTitle3 {
    return Intl.message(
      'Secure Payments',
      name: 'onboardingTitle3',
      desc: '',
      args: [],
    );
  }

  /// `Pay securely through the app.`
  String get onboardingDesc3 {
    return Intl.message(
      'Pay securely through the app.',
      name: 'onboardingDesc3',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message('Get Started', name: 'getStarted', desc: '', args: []);
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Welcome Back`
  String get welcomeBack {
    return Intl.message(
      'Welcome Back',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to continue`
  String get signInToContinue {
    return Intl.message(
      'Sign in to continue',
      name: 'signInToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Enter your email`
  String get enterYourEmail {
    return Intl.message(
      'Enter your email',
      name: 'enterYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Enter your password`
  String get enterYourPassword {
    return Intl.message(
      'Enter your password',
      name: 'enterYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Don't have an account? `
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account? ',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message('Sign Up', name: 'signUp', desc: '', args: []);
  }

  /// `Please enter your email`
  String get pleaseEnterEmail {
    return Intl.message(
      'Please enter your email',
      name: 'pleaseEnterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get pleaseEnterValidEmail {
    return Intl.message(
      'Please enter a valid email',
      name: 'pleaseEnterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get pleaseEnterPassword {
    return Intl.message(
      'Please enter your password',
      name: 'pleaseEnterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get passwordMinLength {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'passwordMinLength',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Get started for free`
  String get getStartedFree {
    return Intl.message(
      'Get started for free',
      name: 'getStartedFree',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message('Full Name', name: 'fullName', desc: '', args: []);
  }

  /// `Enter your full name`
  String get enterYourName {
    return Intl.message(
      'Enter your full name',
      name: 'enterYourName',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm your password`
  String get confirmYourPassword {
    return Intl.message(
      'Confirm your password',
      name: 'confirmYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? `
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account? ',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message('Sign In', name: 'signIn', desc: '', args: []);
  }

  /// `Passwords don't match`
  String get passwordsDontMatch {
    return Intl.message(
      'Passwords don\'t match',
      name: 'passwordsDontMatch',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name`
  String get pleaseEnterName {
    return Intl.message(
      'Please enter your name',
      name: 'pleaseEnterName',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number`
  String get enterYourPhone {
    return Intl.message(
      'Enter your phone number',
      name: 'enterYourPhone',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your phone number`
  String get pleaseEnterPhone {
    return Intl.message(
      'Please enter your phone number',
      name: 'pleaseEnterPhone',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid phone number`
  String get pleaseEnterValidPhone {
    return Intl.message(
      'Please enter a valid phone number',
      name: 'pleaseEnterValidPhone',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your full name (first and last name)`
  String get pleaseEnterFullName {
    return Intl.message(
      'Please enter your full name (first and last name)',
      name: 'pleaseEnterFullName',
      desc: '',
      args: [],
    );
  }

  /// `Verify Email`
  String get verifyEmail {
    return Intl.message(
      'Verify Email',
      name: 'verifyEmail',
      desc: '',
      args: [],
    );
  }

  /// `Check your email`
  String get verifyEmailTitle {
    return Intl.message(
      'Check your email',
      name: 'verifyEmailTitle',
      desc: '',
      args: [],
    );
  }

  /// `We've sent a verification link to`
  String get verifyEmailDesc {
    return Intl.message(
      'We\'ve sent a verification link to',
      name: 'verifyEmailDesc',
      desc: '',
      args: [],
    );
  }

  /// `Resend Email`
  String get resendEmail {
    return Intl.message(
      'Resend Email',
      name: 'resendEmail',
      desc: '',
      args: [],
    );
  }

  /// `Verification email sent!`
  String get emailSent {
    return Intl.message(
      'Verification email sent!',
      name: 'emailSent',
      desc: '',
      args: [],
    );
  }

  /// `I've Verified My Email`
  String get iVerified {
    return Intl.message(
      'I\'ve Verified My Email',
      name: 'iVerified',
      desc: '',
      args: [],
    );
  }

  /// `Email not verified yet. Please check your inbox.`
  String get emailNotVerified {
    return Intl.message(
      'Email not verified yet. Please check your inbox.',
      name: 'emailNotVerified',
      desc: '',
      args: [],
    );
  }

  /// `This email is already registered`
  String get errorEmailAlreadyInUse {
    return Intl.message(
      'This email is already registered',
      name: 'errorEmailAlreadyInUse',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email address`
  String get errorInvalidEmail {
    return Intl.message(
      'Invalid email address',
      name: 'errorInvalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password is too weak`
  String get errorWeakPassword {
    return Intl.message(
      'Password is too weak',
      name: 'errorWeakPassword',
      desc: '',
      args: [],
    );
  }

  /// `No account found with this email`
  String get errorUserNotFound {
    return Intl.message(
      'No account found with this email',
      name: 'errorUserNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect password`
  String get errorWrongPassword {
    return Intl.message(
      'Incorrect password',
      name: 'errorWrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `This account has been disabled`
  String get errorUserDisabled {
    return Intl.message(
      'This account has been disabled',
      name: 'errorUserDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Too many attempts. Please try again later`
  String get errorTooManyRequests {
    return Intl.message(
      'Too many attempts. Please try again later',
      name: 'errorTooManyRequests',
      desc: '',
      args: [],
    );
  }

  /// `This operation is not allowed`
  String get errorOperationNotAllowed {
    return Intl.message(
      'This operation is not allowed',
      name: 'errorOperationNotAllowed',
      desc: '',
      args: [],
    );
  }

  /// `Network error. Please check your connection`
  String get errorNetworkRequestFailed {
    return Intl.message(
      'Network error. Please check your connection',
      name: 'errorNetworkRequestFailed',
      desc: '',
      args: [],
    );
  }

  /// `An unknown error occurred`
  String get errorUnknown {
    return Intl.message(
      'An unknown error occurred',
      name: 'errorUnknown',
      desc: '',
      args: [],
    );
  }

  /// `Registration failed. Please try again`
  String get errorRegistrationFailed {
    return Intl.message(
      'Registration failed. Please try again',
      name: 'errorRegistrationFailed',
      desc: '',
      args: [],
    );
  }

  /// `Login failed. Please try again`
  String get errorLoginFailed {
    return Intl.message(
      'Login failed. Please try again',
      name: 'errorLoginFailed',
      desc: '',
      args: [],
    );
  }

  /// `Data not found`
  String get errorDataNotFound {
    return Intl.message(
      'Data not found',
      name: 'errorDataNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Permission denied`
  String get errorPermissionDenied {
    return Intl.message(
      'Permission denied',
      name: 'errorPermissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `Failed to save data`
  String get errorSaveFailed {
    return Intl.message(
      'Failed to save data',
      name: 'errorSaveFailed',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Explore`
  String get explore {
    return Intl.message('Explore', name: 'explore', desc: '', args: []);
  }

  /// `Bookings`
  String get bookings {
    return Intl.message('Bookings', name: 'bookings', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Search for services...`
  String get searchServices {
    return Intl.message(
      'Search for services...',
      name: 'searchServices',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message('Categories', name: 'categories', desc: '', args: []);
  }

  /// `Featured Services`
  String get featuredServices {
    return Intl.message(
      'Featured Services',
      name: 'featuredServices',
      desc: '',
      args: [],
    );
  }

  /// `Popular Providers`
  String get popularProviders {
    return Intl.message(
      'Popular Providers',
      name: 'popularProviders',
      desc: '',
      args: [],
    );
  }

  /// `See All`
  String get seeAll {
    return Intl.message('See All', name: 'seeAll', desc: '', args: []);
  }

  /// `No services available`
  String get noServices {
    return Intl.message(
      'No services available',
      name: 'noServices',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from {
    return Intl.message('From', name: 'from', desc: '', args: []);
  }

  /// `per hour`
  String get perHour {
    return Intl.message('per hour', name: 'perHour', desc: '', args: []);
  }

  /// `per visit`
  String get perVisit {
    return Intl.message('per visit', name: 'perVisit', desc: '', args: []);
  }

  /// `Rating`
  String get rating {
    return Intl.message('Rating', name: 'rating', desc: '', args: []);
  }

  /// `reviews`
  String get reviews {
    return Intl.message('reviews', name: 'reviews', desc: '', args: []);
  }

  /// `View Details`
  String get viewDetails {
    return Intl.message(
      'View Details',
      name: 'viewDetails',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `Sort by`
  String get sortBy {
    return Intl.message('Sort by', name: 'sortBy', desc: '', args: []);
  }

  /// `Most Popular`
  String get mostPopular {
    return Intl.message(
      'Most Popular',
      name: 'mostPopular',
      desc: '',
      args: [],
    );
  }

  /// `Top Rated`
  String get topRated {
    return Intl.message('Top Rated', name: 'topRated', desc: '', args: []);
  }

  /// `Price: Low to High`
  String get priceLowToHigh {
    return Intl.message(
      'Price: Low to High',
      name: 'priceLowToHigh',
      desc: '',
      args: [],
    );
  }

  /// `Price: High to Low`
  String get priceHighToLow {
    return Intl.message(
      'Price: High to Low',
      name: 'priceHighToLow',
      desc: '',
      args: [],
    );
  }

  /// `No results for`
  String get noResultsFor {
    return Intl.message(
      'No results for',
      name: 'noResultsFor',
      desc: '',
      args: [],
    );
  }

  /// `Try different keywords or clear filters`
  String get tryDifferentKeywords {
    return Intl.message(
      'Try different keywords or clear filters',
      name: 'tryDifferentKeywords',
      desc: '',
      args: [],
    );
  }

  /// `Clear Filters`
  String get clearFilters {
    return Intl.message(
      'Clear Filters',
      name: 'clearFilters',
      desc: '',
      args: [],
    );
  }

  /// `Filters`
  String get filters {
    return Intl.message('Filters', name: 'filters', desc: '', args: []);
  }

  /// `Price Range`
  String get priceRange {
    return Intl.message('Price Range', name: 'priceRange', desc: '', args: []);
  }

  /// `Minimum Rating`
  String get minimumRating {
    return Intl.message(
      'Minimum Rating',
      name: 'minimumRating',
      desc: '',
      args: [],
    );
  }

  /// `Apply Filters`
  String get applyFilters {
    return Intl.message(
      'Apply Filters',
      name: 'applyFilters',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
