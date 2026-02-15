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

  /// `Reviews`
  String get reviews {
    return Intl.message('Reviews', name: 'reviews', desc: '', args: []);
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

  /// `Upcoming`
  String get upcoming {
    return Intl.message('Upcoming', name: 'upcoming', desc: '', args: []);
  }

  /// `Past`
  String get past {
    return Intl.message('Past', name: 'past', desc: '', args: []);
  }

  /// `Cancelled`
  String get cancelled {
    return Intl.message('Cancelled', name: 'cancelled', desc: '', args: []);
  }

  /// `Pending`
  String get pending {
    return Intl.message('Pending', name: 'pending', desc: '', args: []);
  }

  /// `Confirmed`
  String get confirmed {
    return Intl.message('Confirmed', name: 'confirmed', desc: '', args: []);
  }

  /// `Completed`
  String get completed {
    return Intl.message('Completed', name: 'completed', desc: '', args: []);
  }

  /// `No upcoming bookings`
  String get noUpcomingBookings {
    return Intl.message(
      'No upcoming bookings',
      name: 'noUpcomingBookings',
      desc: '',
      args: [],
    );
  }

  /// `No past bookings`
  String get noPastBookings {
    return Intl.message(
      'No past bookings',
      name: 'noPastBookings',
      desc: '',
      args: [],
    );
  }

  /// `No cancelled bookings`
  String get noCancelledBookings {
    return Intl.message(
      'No cancelled bookings',
      name: 'noCancelledBookings',
      desc: '',
      args: [],
    );
  }

  /// `Loading bookings...`
  String get loadingBookings {
    return Intl.message(
      'Loading bookings...',
      name: 'loadingBookings',
      desc: '',
      args: [],
    );
  }

  /// `Booking Details`
  String get bookingDetails {
    return Intl.message(
      'Booking Details',
      name: 'bookingDetails',
      desc: '',
      args: [],
    );
  }

  /// `Time Slot`
  String get timeSlot {
    return Intl.message('Time Slot', name: 'timeSlot', desc: '', args: []);
  }

  /// `EGP`
  String get currency {
    return Intl.message('EGP', name: 'currency', desc: '', args: []);
  }

  /// `Loading home data...`
  String get loadingHomeData {
    return Intl.message(
      'Loading home data...',
      name: 'loadingHomeData',
      desc: '',
      args: [],
    );
  }

  /// `Loading services...`
  String get loadingServices {
    return Intl.message(
      'Loading services...',
      name: 'loadingServices',
      desc: '',
      args: [],
    );
  }

  /// `Khadamaty`
  String get appName {
    return Intl.message('Khadamaty', name: 'appName', desc: '', args: []);
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Total Bookings`
  String get totalBookings {
    return Intl.message(
      'Total Bookings',
      name: 'totalBookings',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completedServices {
    return Intl.message(
      'Completed',
      name: 'completedServices',
      desc: '',
      args: [],
    );
  }

  /// `Total Spent`
  String get totalSpent {
    return Intl.message('Total Spent', name: 'totalSpent', desc: '', args: []);
  }

  /// `Member Since`
  String get memberSince {
    return Intl.message(
      'Member Since',
      name: 'memberSince',
      desc: '',
      args: [],
    );
  }

  /// `Quick Actions`
  String get quickActions {
    return Intl.message(
      'Quick Actions',
      name: 'quickActions',
      desc: '',
      args: [],
    );
  }

  /// `My Bookings`
  String get myBookings {
    return Intl.message('My Bookings', name: 'myBookings', desc: '', args: []);
  }

  /// `Favorite Services`
  String get favoriteServices {
    return Intl.message(
      'Favorite Services',
      name: 'favoriteServices',
      desc: '',
      args: [],
    );
  }

  /// `Payment Methods`
  String get paymentMethods {
    return Intl.message(
      'Payment Methods',
      name: 'paymentMethods',
      desc: '',
      args: [],
    );
  }

  /// `My Addresses`
  String get myAddresses {
    return Intl.message(
      'My Addresses',
      name: 'myAddresses',
      desc: '',
      args: [],
    );
  }

  /// `Help & Support`
  String get helpSupport {
    return Intl.message(
      'Help & Support',
      name: 'helpSupport',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message('Dark Mode', name: 'darkMode', desc: '', args: []);
  }

  /// `Account Settings`
  String get accountSettings {
    return Intl.message(
      'Account Settings',
      name: 'accountSettings',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Service`
  String get termsOfService {
    return Intl.message(
      'Terms of Service',
      name: 'termsOfService',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Are you sure you want to logout?`
  String get logoutConfirmation {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'logoutConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `My Services`
  String get myServicesTitle {
    return Intl.message(
      'My Services',
      name: 'myServicesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add Service`
  String get addService {
    return Intl.message('Add Service', name: 'addService', desc: '', args: []);
  }

  /// `No services yet`
  String get noServicesYet {
    return Intl.message(
      'No services yet',
      name: 'noServicesYet',
      desc: '',
      args: [],
    );
  }

  /// `Start adding your services to reach customers`
  String get startAddingServices {
    return Intl.message(
      'Start adding your services to reach customers',
      name: 'startAddingServices',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get serviceActive {
    return Intl.message('Active', name: 'serviceActive', desc: '', args: []);
  }

  /// `Inactive`
  String get serviceInactive {
    return Intl.message(
      'Inactive',
      name: 'serviceInactive',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Delete Service`
  String get deleteService {
    return Intl.message(
      'Delete Service',
      name: 'deleteService',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this service?`
  String get deleteServiceConfirmation {
    return Intl.message(
      'Are you sure you want to delete this service?',
      name: 'deleteServiceConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message('Active', name: 'active', desc: '', args: []);
  }

  /// `Inactive`
  String get inactive {
    return Intl.message('Inactive', name: 'inactive', desc: '', args: []);
  }

  /// `Pick Location`
  String get mapPickLocation {
    return Intl.message(
      'Pick Location',
      name: 'mapPickLocation',
      desc: '',
      args: [],
    );
  }

  /// `Use Current Location`
  String get mapUseCurrentLocation {
    return Intl.message(
      'Use Current Location',
      name: 'mapUseCurrentLocation',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Location`
  String get mapConfirmLocation {
    return Intl.message(
      'Confirm Location',
      name: 'mapConfirmLocation',
      desc: '',
      args: [],
    );
  }

  /// `Loading address...`
  String get mapLoadingLocation {
    return Intl.message(
      'Loading address...',
      name: 'mapLoadingLocation',
      desc: '',
      args: [],
    );
  }

  /// `Add New Service`
  String get addServiceTitle {
    return Intl.message(
      'Add New Service',
      name: 'addServiceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Service Title`
  String get serviceTitle {
    return Intl.message(
      'Service Title',
      name: 'serviceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter service title`
  String get enterServiceTitle {
    return Intl.message(
      'Enter service title',
      name: 'enterServiceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get serviceDescription {
    return Intl.message(
      'Description',
      name: 'serviceDescription',
      desc: '',
      args: [],
    );
  }

  /// `Describe your service`
  String get enterDescription {
    return Intl.message(
      'Describe your service',
      name: 'enterDescription',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message('Category', name: 'category', desc: '', args: []);
  }

  /// `Enter category (e.g., Plumbing, Cleaning)`
  String get enterCategory {
    return Intl.message(
      'Enter category (e.g., Plumbing, Cleaning)',
      name: 'enterCategory',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message('Price', name: 'price', desc: '', args: []);
  }

  /// `Enter price`
  String get enterPrice {
    return Intl.message('Enter price', name: 'enterPrice', desc: '', args: []);
  }

  /// `Price Unit`
  String get priceUnit {
    return Intl.message('Price Unit', name: 'priceUnit', desc: '', args: []);
  }

  /// `Service Location`
  String get serviceLocation {
    return Intl.message(
      'Service Location',
      name: 'serviceLocation',
      desc: '',
      args: [],
    );
  }

  /// `Tap to select location`
  String get tapToSelectLocation {
    return Intl.message(
      'Tap to select location',
      name: 'tapToSelectLocation',
      desc: '',
      args: [],
    );
  }

  /// `Service Image`
  String get addServiceImage {
    return Intl.message(
      'Service Image',
      name: 'addServiceImage',
      desc: '',
      args: [],
    );
  }

  /// `Image upload coming soon`
  String get imageComingSoon {
    return Intl.message(
      'Image upload coming soon',
      name: 'imageComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Save Service`
  String get saveService {
    return Intl.message(
      'Save Service',
      name: 'saveService',
      desc: '',
      args: [],
    );
  }

  /// `Service added successfully`
  String get serviceAdded {
    return Intl.message(
      'Service added successfully',
      name: 'serviceAdded',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a title`
  String get pleaseEnterTitle {
    return Intl.message(
      'Please enter a title',
      name: 'pleaseEnterTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a description`
  String get pleaseEnterDescription {
    return Intl.message(
      'Please enter a description',
      name: 'pleaseEnterDescription',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a category`
  String get pleaseEnterCategory {
    return Intl.message(
      'Please enter a category',
      name: 'pleaseEnterCategory',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a price`
  String get pleaseEnterPrice {
    return Intl.message(
      'Please enter a price',
      name: 'pleaseEnterPrice',
      desc: '',
      args: [],
    );
  }

  /// `Please select a location`
  String get pleaseSelectLocation {
    return Intl.message(
      'Please select a location',
      name: 'pleaseSelectLocation',
      desc: '',
      args: [],
    );
  }

  /// `Service Information`
  String get serviceInfo {
    return Intl.message(
      'Service Information',
      name: 'serviceInfo',
      desc: '',
      args: [],
    );
  }

  /// `Basic details about your service`
  String get serviceInfoSubtitle {
    return Intl.message(
      'Basic details about your service',
      name: 'serviceInfoSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Pricing`
  String get pricingTitle {
    return Intl.message('Pricing', name: 'pricingTitle', desc: '', args: []);
  }

  /// `Set your service rate`
  String get pricingSubtitle {
    return Intl.message(
      'Set your service rate',
      name: 'pricingSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Where you provide this service`
  String get locationSubtitle {
    return Intl.message(
      'Where you provide this service',
      name: 'locationSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Add photos of your work`
  String get imageSubtitle {
    return Intl.message(
      'Add photos of your work',
      name: 'imageSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Appointment`
  String get appointment {
    return Intl.message('Appointment', name: 'appointment', desc: '', args: []);
  }

  /// `On Demand`
  String get onDemand {
    return Intl.message('On Demand', name: 'onDemand', desc: '', args: []);
  }

  /// `Service Type`
  String get serviceType {
    return Intl.message(
      'Service Type',
      name: 'serviceType',
      desc: '',
      args: [],
    );
  }

  /// `Customer requests now`
  String get onDemandDescription {
    return Intl.message(
      'Customer requests now',
      name: 'onDemandDescription',
      desc: '',
      args: [],
    );
  }

  /// `Book a time slot`
  String get appointmentDescription {
    return Intl.message(
      'Book a time slot',
      name: 'appointmentDescription',
      desc: '',
      args: [],
    );
  }

  /// `Duration`
  String get duration {
    return Intl.message('Duration', name: 'duration', desc: '', args: []);
  }

  /// `e.g. 30`
  String get durationHint {
    return Intl.message('e.g. 30', name: 'durationHint', desc: '', args: []);
  }

  /// `min`
  String get minutes {
    return Intl.message('min', name: 'minutes', desc: '', args: []);
  }

  /// `min`
  String get min {
    return Intl.message('min', name: 'min', desc: '', args: []);
  }

  /// `Please enter duration`
  String get pleaseEnterDuration {
    return Intl.message(
      'Please enter duration',
      name: 'pleaseEnterDuration',
      desc: '',
      args: [],
    );
  }

  /// `Service Type`
  String get serviceTypeSection {
    return Intl.message(
      'Service Type',
      name: 'serviceTypeSection',
      desc: '',
      args: [],
    );
  }

  /// `How customers will book`
  String get serviceTypeSectionSubtitle {
    return Intl.message(
      'How customers will book',
      name: 'serviceTypeSectionSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Work Days`
  String get workDays {
    return Intl.message('Work Days', name: 'workDays', desc: '', args: []);
  }

  /// `Working Hours`
  String get workingHours {
    return Intl.message(
      'Working Hours',
      name: 'workingHours',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get startTime {
    return Intl.message('Start', name: 'startTime', desc: '', args: []);
  }

  /// `End`
  String get endTime {
    return Intl.message('End', name: 'endTime', desc: '', args: []);
  }

  /// `Sun`
  String get sun {
    return Intl.message('Sun', name: 'sun', desc: '', args: []);
  }

  /// `Mon`
  String get mon {
    return Intl.message('Mon', name: 'mon', desc: '', args: []);
  }

  /// `Tue`
  String get tue {
    return Intl.message('Tue', name: 'tue', desc: '', args: []);
  }

  /// `Wed`
  String get wed {
    return Intl.message('Wed', name: 'wed', desc: '', args: []);
  }

  /// `Thu`
  String get thu {
    return Intl.message('Thu', name: 'thu', desc: '', args: []);
  }

  /// `Fri`
  String get fri {
    return Intl.message('Fri', name: 'fri', desc: '', args: []);
  }

  /// `Sat`
  String get sat {
    return Intl.message('Sat', name: 'sat', desc: '', args: []);
  }

  /// `Availability`
  String get availability {
    return Intl.message(
      'Availability',
      name: 'availability',
      desc: '',
      args: [],
    );
  }

  /// `When you're available`
  String get availabilitySubtitle {
    return Intl.message(
      'When you\'re available',
      name: 'availabilitySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Tap to add image`
  String get tapToAddImage {
    return Intl.message(
      'Tap to add image',
      name: 'tapToAddImage',
      desc: '',
      args: [],
    );
  }

  /// `Book Now`
  String get bookNow {
    return Intl.message('Book Now', name: 'bookNow', desc: '', args: []);
  }

  /// `About this service`
  String get aboutService {
    return Intl.message(
      'About this service',
      name: 'aboutService',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message('Location', name: 'location', desc: '', args: []);
  }

  /// `Provider`
  String get provider {
    return Intl.message('Provider', name: 'provider', desc: '', args: []);
  }

  /// `No image available`
  String get noImage {
    return Intl.message(
      'No image available',
      name: 'noImage',
      desc: '',
      args: [],
    );
  }

  /// `Select Date`
  String get selectDate {
    return Intl.message('Select Date', name: 'selectDate', desc: '', args: []);
  }

  /// `Select Time`
  String get selectTime {
    return Intl.message('Select Time', name: 'selectTime', desc: '', args: []);
  }

  /// `Additional Notes`
  String get additionalNotes {
    return Intl.message(
      'Additional Notes',
      name: 'additionalNotes',
      desc: '',
      args: [],
    );
  }

  /// `Add any other details...`
  String get addNotesHint {
    return Intl.message(
      'Add any other details...',
      name: 'addNotesHint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Booking ({price} {currency})`
  String confirmBookingWithPrice(Object price, Object currency) {
    return Intl.message(
      'Confirm Booking ($price $currency)',
      name: 'confirmBookingWithPrice',
      desc: '',
      args: [price, currency],
    );
  }

  /// `Booking successful!`
  String get bookingSuccess {
    return Intl.message(
      'Booking successful!',
      name: 'bookingSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Booking failed`
  String get bookingFailed {
    return Intl.message(
      'Booking failed',
      name: 'bookingFailed',
      desc: '',
      args: [],
    );
  }

  /// `Declined`
  String get declined {
    return Intl.message('Declined', name: 'declined', desc: '', args: []);
  }

  /// `Booking Date`
  String get bookingDate {
    return Intl.message(
      'Booking Date',
      name: 'bookingDate',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get payment {
    return Intl.message('Payment', name: 'payment', desc: '', args: []);
  }

  /// `Select Payment Method`
  String get selectPaymentMethod {
    return Intl.message(
      'Select Payment Method',
      name: 'selectPaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Total Amount`
  String get paymentTotalAmount {
    return Intl.message(
      'Total Amount',
      name: 'paymentTotalAmount',
      desc: '',
      args: [],
    );
  }

  /// `Pay with Stripe`
  String get payWithStripe {
    return Intl.message(
      'Pay with Stripe',
      name: 'payWithStripe',
      desc: '',
      args: [],
    );
  }

  /// `Pay with PayPal`
  String get payWithPaypal {
    return Intl.message(
      'Pay with PayPal',
      name: 'payWithPaypal',
      desc: '',
      args: [],
    );
  }

  /// `Payment Successful!`
  String get paymentSuccessful {
    return Intl.message(
      'Payment Successful!',
      name: 'paymentSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Paid via {method}`
  String paidVia(Object method) {
    return Intl.message(
      'Paid via $method',
      name: 'paidVia',
      desc: '',
      args: [method],
    );
  }

  /// `Transaction`
  String get transactionId {
    return Intl.message(
      'Transaction',
      name: 'transactionId',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `Contact us for any questions on your order.`
  String get paypalNote {
    return Intl.message(
      'Contact us for any questions on your order.',
      name: 'paypalNote',
      desc: '',
      args: [],
    );
  }

  /// `Processing payment...`
  String get processingPayment {
    return Intl.message(
      'Processing payment...',
      name: 'processingPayment',
      desc: '',
      args: [],
    );
  }

  /// `Pay with Paymob`
  String get payWithPaymob {
    return Intl.message(
      'Pay with Paymob',
      name: 'payWithPaymob',
      desc: '',
      args: [],
    );
  }

  /// `🧪 Test Mode - Use test cards`
  String get paymobTestMode {
    return Intl.message(
      '🧪 Test Mode - Use test cards',
      name: 'paymobTestMode',
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
