// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(price, currency) => "Confirm Booking (${price} ${currency})";

  static String m1(method) => "Paid via ${method}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aboutService": MessageLookupByLibrary.simpleMessage("About this service"),
    "accountSettings": MessageLookupByLibrary.simpleMessage("Account Settings"),
    "active": MessageLookupByLibrary.simpleMessage("Active"),
    "addNotesHint": MessageLookupByLibrary.simpleMessage(
      "Add any other details...",
    ),
    "addService": MessageLookupByLibrary.simpleMessage("Add Service"),
    "addServiceImage": MessageLookupByLibrary.simpleMessage("Service Image"),
    "addServiceTitle": MessageLookupByLibrary.simpleMessage("Add New Service"),
    "additionalNotes": MessageLookupByLibrary.simpleMessage("Additional Notes"),
    "all": MessageLookupByLibrary.simpleMessage("All"),
    "alreadyHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Already have an account? ",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("Khadamaty"),
    "applyFilters": MessageLookupByLibrary.simpleMessage("Apply Filters"),
    "appointment": MessageLookupByLibrary.simpleMessage("Appointment"),
    "appointmentDescription": MessageLookupByLibrary.simpleMessage(
      "Book a time slot",
    ),
    "availability": MessageLookupByLibrary.simpleMessage("Availability"),
    "availabilitySubtitle": MessageLookupByLibrary.simpleMessage(
      "When you\'re available",
    ),
    "bookNow": MessageLookupByLibrary.simpleMessage("Book Now"),
    "bookingDate": MessageLookupByLibrary.simpleMessage("Booking Date"),
    "bookingDetails": MessageLookupByLibrary.simpleMessage("Booking Details"),
    "bookingFailed": MessageLookupByLibrary.simpleMessage("Booking failed"),
    "bookingSuccess": MessageLookupByLibrary.simpleMessage(
      "Booking successful!",
    ),
    "bookings": MessageLookupByLibrary.simpleMessage("Bookings"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cancelled": MessageLookupByLibrary.simpleMessage("Cancelled"),
    "categories": MessageLookupByLibrary.simpleMessage("Categories"),
    "category": MessageLookupByLibrary.simpleMessage("Category"),
    "changePassword": MessageLookupByLibrary.simpleMessage("Change Password"),
    "clearFilters": MessageLookupByLibrary.simpleMessage("Clear Filters"),
    "completed": MessageLookupByLibrary.simpleMessage("Completed"),
    "completedServices": MessageLookupByLibrary.simpleMessage("Completed"),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmBookingWithPrice": m0,
    "confirmPassword": MessageLookupByLibrary.simpleMessage("Confirm Password"),
    "confirmYourPassword": MessageLookupByLibrary.simpleMessage(
      "Confirm your password",
    ),
    "confirmed": MessageLookupByLibrary.simpleMessage("Confirmed"),
    "createAccount": MessageLookupByLibrary.simpleMessage("Create Account"),
    "currency": MessageLookupByLibrary.simpleMessage("EGP"),
    "darkMode": MessageLookupByLibrary.simpleMessage("Dark Mode"),
    "declined": MessageLookupByLibrary.simpleMessage("Declined"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteService": MessageLookupByLibrary.simpleMessage("Delete Service"),
    "deleteServiceConfirmation": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to delete this service?",
    ),
    "done": MessageLookupByLibrary.simpleMessage("Done"),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account? ",
    ),
    "duration": MessageLookupByLibrary.simpleMessage("Duration"),
    "durationHint": MessageLookupByLibrary.simpleMessage("e.g. 30"),
    "edit": MessageLookupByLibrary.simpleMessage("Edit"),
    "editProfile": MessageLookupByLibrary.simpleMessage("Edit Profile"),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "emailNotVerified": MessageLookupByLibrary.simpleMessage(
      "Email not verified yet. Please check your inbox.",
    ),
    "emailSent": MessageLookupByLibrary.simpleMessage(
      "Verification email sent!",
    ),
    "endTime": MessageLookupByLibrary.simpleMessage("End"),
    "enterCategory": MessageLookupByLibrary.simpleMessage(
      "Enter category (e.g., Plumbing, Cleaning)",
    ),
    "enterDescription": MessageLookupByLibrary.simpleMessage(
      "Describe your service",
    ),
    "enterPrice": MessageLookupByLibrary.simpleMessage("Enter price"),
    "enterServiceTitle": MessageLookupByLibrary.simpleMessage(
      "Enter service title",
    ),
    "enterYourEmail": MessageLookupByLibrary.simpleMessage("Enter your email"),
    "enterYourName": MessageLookupByLibrary.simpleMessage(
      "Enter your full name",
    ),
    "enterYourPassword": MessageLookupByLibrary.simpleMessage(
      "Enter your password",
    ),
    "enterYourPhone": MessageLookupByLibrary.simpleMessage(
      "Enter your phone number",
    ),
    "errorDataNotFound": MessageLookupByLibrary.simpleMessage("Data not found"),
    "errorEmailAlreadyInUse": MessageLookupByLibrary.simpleMessage(
      "This email is already registered",
    ),
    "errorInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "Invalid email address",
    ),
    "errorLoginFailed": MessageLookupByLibrary.simpleMessage(
      "Login failed. Please try again",
    ),
    "errorNetworkRequestFailed": MessageLookupByLibrary.simpleMessage(
      "Network error. Please check your connection",
    ),
    "errorOperationNotAllowed": MessageLookupByLibrary.simpleMessage(
      "This operation is not allowed",
    ),
    "errorPermissionDenied": MessageLookupByLibrary.simpleMessage(
      "Permission denied",
    ),
    "errorRegistrationFailed": MessageLookupByLibrary.simpleMessage(
      "Registration failed. Please try again",
    ),
    "errorSaveFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to save data",
    ),
    "errorTooManyRequests": MessageLookupByLibrary.simpleMessage(
      "Too many attempts. Please try again later",
    ),
    "errorUnknown": MessageLookupByLibrary.simpleMessage(
      "An unknown error occurred",
    ),
    "errorUserDisabled": MessageLookupByLibrary.simpleMessage(
      "This account has been disabled",
    ),
    "errorUserNotFound": MessageLookupByLibrary.simpleMessage(
      "No account found with this email",
    ),
    "errorWeakPassword": MessageLookupByLibrary.simpleMessage(
      "Password is too weak",
    ),
    "errorWrongPassword": MessageLookupByLibrary.simpleMessage(
      "Incorrect password",
    ),
    "explore": MessageLookupByLibrary.simpleMessage("Explore"),
    "favoriteServices": MessageLookupByLibrary.simpleMessage(
      "Favorite Services",
    ),
    "featuredServices": MessageLookupByLibrary.simpleMessage(
      "Featured Services",
    ),
    "filters": MessageLookupByLibrary.simpleMessage("Filters"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Forgot Password?"),
    "fri": MessageLookupByLibrary.simpleMessage("Fri"),
    "from": MessageLookupByLibrary.simpleMessage("From"),
    "fullName": MessageLookupByLibrary.simpleMessage("Full Name"),
    "getStarted": MessageLookupByLibrary.simpleMessage("Get Started"),
    "getStartedFree": MessageLookupByLibrary.simpleMessage(
      "Get started for free",
    ),
    "helpSupport": MessageLookupByLibrary.simpleMessage("Help & Support"),
    "home": MessageLookupByLibrary.simpleMessage("Home"),
    "iVerified": MessageLookupByLibrary.simpleMessage(
      "I\'ve Verified My Email",
    ),
    "imageComingSoon": MessageLookupByLibrary.simpleMessage(
      "Image upload coming soon",
    ),
    "imageSubtitle": MessageLookupByLibrary.simpleMessage(
      "Add photos of your work",
    ),
    "inactive": MessageLookupByLibrary.simpleMessage("Inactive"),
    "loadingBookings": MessageLookupByLibrary.simpleMessage(
      "Loading bookings...",
    ),
    "loadingHomeData": MessageLookupByLibrary.simpleMessage(
      "Loading home data...",
    ),
    "loadingServices": MessageLookupByLibrary.simpleMessage(
      "Loading services...",
    ),
    "location": MessageLookupByLibrary.simpleMessage("Location"),
    "locationSubtitle": MessageLookupByLibrary.simpleMessage(
      "Where you provide this service",
    ),
    "login": MessageLookupByLibrary.simpleMessage("Login"),
    "logout": MessageLookupByLibrary.simpleMessage("Logout"),
    "logoutConfirmation": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to logout?",
    ),
    "mapConfirmLocation": MessageLookupByLibrary.simpleMessage(
      "Confirm Location",
    ),
    "mapLoadingLocation": MessageLookupByLibrary.simpleMessage(
      "Loading address...",
    ),
    "mapPickLocation": MessageLookupByLibrary.simpleMessage("Pick Location"),
    "mapUseCurrentLocation": MessageLookupByLibrary.simpleMessage(
      "Use Current Location",
    ),
    "memberSince": MessageLookupByLibrary.simpleMessage("Member Since"),
    "min": MessageLookupByLibrary.simpleMessage("min"),
    "minimumRating": MessageLookupByLibrary.simpleMessage("Minimum Rating"),
    "minutes": MessageLookupByLibrary.simpleMessage("min"),
    "mon": MessageLookupByLibrary.simpleMessage("Mon"),
    "mostPopular": MessageLookupByLibrary.simpleMessage("Most Popular"),
    "myAddresses": MessageLookupByLibrary.simpleMessage("My Addresses"),
    "myBookings": MessageLookupByLibrary.simpleMessage("My Bookings"),
    "myServicesTitle": MessageLookupByLibrary.simpleMessage("My Services"),
    "next": MessageLookupByLibrary.simpleMessage("Next"),
    "noCancelledBookings": MessageLookupByLibrary.simpleMessage(
      "No cancelled bookings",
    ),
    "noImage": MessageLookupByLibrary.simpleMessage("No image available"),
    "noPastBookings": MessageLookupByLibrary.simpleMessage("No past bookings"),
    "noResultsFor": MessageLookupByLibrary.simpleMessage("No results for"),
    "noServices": MessageLookupByLibrary.simpleMessage("No services available"),
    "noServicesYet": MessageLookupByLibrary.simpleMessage("No services yet"),
    "noUpcomingBookings": MessageLookupByLibrary.simpleMessage(
      "No upcoming bookings",
    ),
    "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
    "onDemand": MessageLookupByLibrary.simpleMessage("On Demand"),
    "onDemandDescription": MessageLookupByLibrary.simpleMessage(
      "Customer requests now",
    ),
    "onboardingDesc1": MessageLookupByLibrary.simpleMessage(
      "Get connected with the best local service providers in your area.",
    ),
    "onboardingDesc2": MessageLookupByLibrary.simpleMessage(
      "Book appointments with just a few taps.",
    ),
    "onboardingDesc3": MessageLookupByLibrary.simpleMessage(
      "Pay securely through the app.",
    ),
    "onboardingTitle1": MessageLookupByLibrary.simpleMessage(
      "Find Local Services",
    ),
    "onboardingTitle2": MessageLookupByLibrary.simpleMessage("Book Easily"),
    "onboardingTitle3": MessageLookupByLibrary.simpleMessage("Secure Payments"),
    "paidVia": m1,
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordMinLength": MessageLookupByLibrary.simpleMessage(
      "Password must be at least 6 characters",
    ),
    "passwordsDontMatch": MessageLookupByLibrary.simpleMessage(
      "Passwords don\'t match",
    ),
    "past": MessageLookupByLibrary.simpleMessage("Past"),
    "payWithPaymob": MessageLookupByLibrary.simpleMessage("Pay with Paymob"),
    "payWithPaypal": MessageLookupByLibrary.simpleMessage("Pay with PayPal"),
    "payWithStripe": MessageLookupByLibrary.simpleMessage("Pay with Stripe"),
    "payment": MessageLookupByLibrary.simpleMessage("Payment"),
    "paymentMethods": MessageLookupByLibrary.simpleMessage("Payment Methods"),
    "paymentSuccessful": MessageLookupByLibrary.simpleMessage(
      "Payment Successful!",
    ),
    "paymentTotalAmount": MessageLookupByLibrary.simpleMessage("Total Amount"),
    "paymobTestMode": MessageLookupByLibrary.simpleMessage(
      "🧪 Test Mode - Use test cards",
    ),
    "paypalNote": MessageLookupByLibrary.simpleMessage(
      "Contact us for any questions on your order.",
    ),
    "pending": MessageLookupByLibrary.simpleMessage("Pending"),
    "perHour": MessageLookupByLibrary.simpleMessage("per hour"),
    "perVisit": MessageLookupByLibrary.simpleMessage("per visit"),
    "phoneNumber": MessageLookupByLibrary.simpleMessage("Phone Number"),
    "pleaseEnterCategory": MessageLookupByLibrary.simpleMessage(
      "Please enter a category",
    ),
    "pleaseEnterDescription": MessageLookupByLibrary.simpleMessage(
      "Please enter a description",
    ),
    "pleaseEnterDuration": MessageLookupByLibrary.simpleMessage(
      "Please enter duration",
    ),
    "pleaseEnterEmail": MessageLookupByLibrary.simpleMessage(
      "Please enter your email",
    ),
    "pleaseEnterFullName": MessageLookupByLibrary.simpleMessage(
      "Please enter your full name (first and last name)",
    ),
    "pleaseEnterName": MessageLookupByLibrary.simpleMessage(
      "Please enter your name",
    ),
    "pleaseEnterPassword": MessageLookupByLibrary.simpleMessage(
      "Please enter your password",
    ),
    "pleaseEnterPhone": MessageLookupByLibrary.simpleMessage(
      "Please enter your phone number",
    ),
    "pleaseEnterPrice": MessageLookupByLibrary.simpleMessage(
      "Please enter a price",
    ),
    "pleaseEnterTitle": MessageLookupByLibrary.simpleMessage(
      "Please enter a title",
    ),
    "pleaseEnterValidEmail": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid email",
    ),
    "pleaseEnterValidPhone": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid phone number",
    ),
    "pleaseSelectLocation": MessageLookupByLibrary.simpleMessage(
      "Please select a location",
    ),
    "popularProviders": MessageLookupByLibrary.simpleMessage(
      "Popular Providers",
    ),
    "price": MessageLookupByLibrary.simpleMessage("Price"),
    "priceHighToLow": MessageLookupByLibrary.simpleMessage(
      "Price: High to Low",
    ),
    "priceLowToHigh": MessageLookupByLibrary.simpleMessage(
      "Price: Low to High",
    ),
    "priceRange": MessageLookupByLibrary.simpleMessage("Price Range"),
    "priceUnit": MessageLookupByLibrary.simpleMessage("Price Unit"),
    "pricingSubtitle": MessageLookupByLibrary.simpleMessage(
      "Set your service rate",
    ),
    "pricingTitle": MessageLookupByLibrary.simpleMessage("Pricing"),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "processingPayment": MessageLookupByLibrary.simpleMessage(
      "Processing payment...",
    ),
    "profile": MessageLookupByLibrary.simpleMessage("Profile"),
    "provider": MessageLookupByLibrary.simpleMessage("Provider"),
    "quickActions": MessageLookupByLibrary.simpleMessage("Quick Actions"),
    "rating": MessageLookupByLibrary.simpleMessage("Rating"),
    "resendEmail": MessageLookupByLibrary.simpleMessage("Resend Email"),
    "reviews": MessageLookupByLibrary.simpleMessage("Reviews"),
    "sat": MessageLookupByLibrary.simpleMessage("Sat"),
    "saveService": MessageLookupByLibrary.simpleMessage("Save Service"),
    "searchServices": MessageLookupByLibrary.simpleMessage(
      "Search for services...",
    ),
    "seeAll": MessageLookupByLibrary.simpleMessage("See All"),
    "selectDate": MessageLookupByLibrary.simpleMessage("Select Date"),
    "selectPaymentMethod": MessageLookupByLibrary.simpleMessage(
      "Select Payment Method",
    ),
    "selectTime": MessageLookupByLibrary.simpleMessage("Select Time"),
    "serviceActive": MessageLookupByLibrary.simpleMessage("Active"),
    "serviceAdded": MessageLookupByLibrary.simpleMessage(
      "Service added successfully",
    ),
    "serviceDescription": MessageLookupByLibrary.simpleMessage("Description"),
    "serviceInactive": MessageLookupByLibrary.simpleMessage("Inactive"),
    "serviceInfo": MessageLookupByLibrary.simpleMessage("Service Information"),
    "serviceInfoSubtitle": MessageLookupByLibrary.simpleMessage(
      "Basic details about your service",
    ),
    "serviceLocation": MessageLookupByLibrary.simpleMessage("Service Location"),
    "serviceTitle": MessageLookupByLibrary.simpleMessage("Service Title"),
    "serviceType": MessageLookupByLibrary.simpleMessage("Service Type"),
    "serviceTypeSection": MessageLookupByLibrary.simpleMessage("Service Type"),
    "serviceTypeSectionSubtitle": MessageLookupByLibrary.simpleMessage(
      "How customers will book",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "signIn": MessageLookupByLibrary.simpleMessage("Sign In"),
    "signInToContinue": MessageLookupByLibrary.simpleMessage(
      "Sign in to continue",
    ),
    "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
    "skip": MessageLookupByLibrary.simpleMessage("Skip"),
    "sortBy": MessageLookupByLibrary.simpleMessage("Sort by"),
    "startAddingServices": MessageLookupByLibrary.simpleMessage(
      "Start adding your services to reach customers",
    ),
    "startTime": MessageLookupByLibrary.simpleMessage("Start"),
    "sun": MessageLookupByLibrary.simpleMessage("Sun"),
    "tapToAddImage": MessageLookupByLibrary.simpleMessage("Tap to add image"),
    "tapToSelectLocation": MessageLookupByLibrary.simpleMessage(
      "Tap to select location",
    ),
    "termsOfService": MessageLookupByLibrary.simpleMessage("Terms of Service"),
    "thu": MessageLookupByLibrary.simpleMessage("Thu"),
    "timeSlot": MessageLookupByLibrary.simpleMessage("Time Slot"),
    "topRated": MessageLookupByLibrary.simpleMessage("Top Rated"),
    "totalBookings": MessageLookupByLibrary.simpleMessage("Total Bookings"),
    "totalSpent": MessageLookupByLibrary.simpleMessage("Total Spent"),
    "transactionId": MessageLookupByLibrary.simpleMessage("Transaction"),
    "tryDifferentKeywords": MessageLookupByLibrary.simpleMessage(
      "Try different keywords or clear filters",
    ),
    "tue": MessageLookupByLibrary.simpleMessage("Tue"),
    "upcoming": MessageLookupByLibrary.simpleMessage("Upcoming"),
    "verifyEmail": MessageLookupByLibrary.simpleMessage("Verify Email"),
    "verifyEmailDesc": MessageLookupByLibrary.simpleMessage(
      "We\'ve sent a verification link to",
    ),
    "verifyEmailTitle": MessageLookupByLibrary.simpleMessage(
      "Check your email",
    ),
    "viewDetails": MessageLookupByLibrary.simpleMessage("View Details"),
    "wed": MessageLookupByLibrary.simpleMessage("Wed"),
    "welcomeBack": MessageLookupByLibrary.simpleMessage("Welcome Back"),
    "workDays": MessageLookupByLibrary.simpleMessage("Work Days"),
    "workingHours": MessageLookupByLibrary.simpleMessage("Working Hours"),
  };
}
