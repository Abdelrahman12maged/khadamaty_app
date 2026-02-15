import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' show ThemeMode, debugPrint;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:khadamaty_app/core/service/Api.dart';
import 'package:khadamaty_app/features/Payment/data/datasources/payment_service.dart';
import 'package:khadamaty_app/features/Payment/data/models/payment_model.dart';
import 'package:khadamaty_app/features/Payment/data/models/payment_params.dart';

/// Stripe payment service implementation.
///
/// Handles the full Stripe payment flow:
/// 1. Customer management (create once, reuse forever)
/// 2. Ephemeral key generation (for saved cards)
/// 3. Payment intent creation
/// 4. Payment sheet presentation
class StripeServiceImp implements PaymentService {
  StripeServiceImp({
    required Apiservice apiservice,
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _api = apiservice,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  final Apiservice _api;
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  // ─── Constants ─────────────────────────────────────────────

  static const _baseUrl = 'https://api.stripe.com/v1';
  static const _stripeVersion = '2024-06-20';
  static const _merchantName = 'Khadamaty';

  // ─── Config ────────────────────────────────────────────────

  String get _secretKey => dotenv.env['STRIPE_SECRET_KEY'] ?? '';

  Map<String, dynamic> get _versionHeader => {
        'Stripe-Version': _stripeVersion,
      };

  // ═══════════════════════════════════════════════════════════
  //  PUBLIC API
  // ═══════════════════════════════════════════════════════════

  /// Execute the full payment flow.
  ///
  /// Flow: Customer → Ephemeral Key → PaymentIntent → Sheet → Present
  @override
  Future<PaymentModel> makePaymentIntent({
    required PaymentParams params,
  }) async {
    try {
      // 1. Resolve customer
      final customerId = await _resolveCustomerId(params);

      // 2. Generate ephemeral key for saved cards
      final ephemeralKey =
          customerId != null ? await _createEphemeralKey(customerId) : null;

      // 3. Create payment intent
      final paymentResult = await _createPaymentIntent(
        params: params,
        customerId: customerId,
      );

      // 4. Initialize & present payment sheet
      await _showPaymentSheet(
        clientSecret: paymentResult.clientSecret,
        customerId: customerId,
        ephemeralKey: ephemeralKey,
      );

      return paymentResult;
    } on StripeException catch (e) {
      throw Exception('Stripe: ${e.error.localizedMessage}');
    } catch (e) {
      throw Exception('Payment failed: $e');
    }
  }

  // ═══════════════════════════════════════════════════════════
  //  CUSTOMER MANAGEMENT
  // ═══════════════════════════════════════════════════════════

  /// Resolves the Stripe customer ID for the current user.
  ///
  /// Priority:
  /// 1. Existing valid ID from Firestore
  /// 2. Create new → save to Firestore
  /// 3. null if no authenticated user
  Future<String?> _resolveCustomerId(PaymentParams params) async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final saved = await _getSavedCustomerId(user.uid);

    if (saved != null && await _isCustomerValid(saved)) {
      return saved;
    }

    // Create fresh customer
    final newId = await _createCustomer(
      email: user.email ?? params.customerEmail ?? '',
      name: user.displayName ?? params.customerName ?? '',
    );

    await _saveCustomerId(user.uid, newId);
    return newId;
  }

  Future<String?> _getSavedCustomerId(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    return doc.data()?['stripeCustomerId'] as String?;
  }

  Future<void> _saveCustomerId(String userId, String customerId) async {
    await _firestore.collection('users').doc(userId).update({
      'stripeCustomerId': customerId,
    });
  }

  /// Validates that a customer ID still exists in Stripe.
  Future<bool> _isCustomerValid(String customerId) async {
    try {
      await _api.postdio(
        url: '$_baseUrl/ephemeral_keys',
        token: _secretKey,
        extraHeaders: _versionHeader,
        body: {'customer': customerId},
      );
      return true;
    } catch (_) {
      debugPrint('Stripe: Customer $customerId is invalid, recreating...');
      return false;
    }
  }

  // ═══════════════════════════════════════════════════════════
  //  STRIPE API CALLS
  // ═══════════════════════════════════════════════════════════

  Future<String> _createCustomer({
    required String email,
    required String name,
  }) async {
    final response = await _api.postdio(
      url: '$_baseUrl/customers',
      token: _secretKey,
      body: {'email': email, 'name': name},
    );
    return response.data['id'] as String;
  }

  Future<String> _createEphemeralKey(String customerId) async {
    final response = await _api.postdio(
      url: '$_baseUrl/ephemeral_keys',
      token: _secretKey,
      extraHeaders: _versionHeader,
      body: {'customer': customerId},
    );
    return response.data['secret'] as String;
  }

  Future<PaymentModel> _createPaymentIntent({
    required PaymentParams params,
    String? customerId,
  }) async {
    final body = <String, dynamic>{
      'amount': params.amount,
      'currency': params.currency,
    };

    if (customerId != null) {
      body['customer'] = customerId;
    }

    final response = await _api.postdio(
      url: '$_baseUrl/payment_intents',
      token: _secretKey,
      body: body,
    );

    return PaymentModel.fromJson(response.data);
  }

  // ═══════════════════════════════════════════════════════════
  //  PAYMENT SHEET
  // ═══════════════════════════════════════════════════════════

  Future<void> _showPaymentSheet({
    required String clientSecret,
    String? customerId,
    String? ephemeralKey,
  }) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: _merchantName,
        style: ThemeMode.system,
        customerId: customerId,
        customerEphemeralKeySecret: ephemeralKey,
      ),
    );

    await Stripe.instance.presentPaymentSheet();
  }
}
