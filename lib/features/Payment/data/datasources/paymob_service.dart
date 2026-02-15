// import 'package:dio/dio.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// /// Paymob API Service for payment processing
// /// Supports both test (sandbox) and production modes
// class PaymobService {
//   static final Dio _dio = Dio();

//   // Base URLs
//   static const String _baseUrl = 'https://accept.paymob.com/api';
//   static const String _iframeUrl =
//       'https://accept.paymob.com/api/acceptance/iframes';

//   // Mode configuration
//   static bool get _isTestMode => dotenv.env['PAYMOB_MODE'] == 'test';

//   // API Keys (auto-switch based on mode)
//   static String get _apiKey => _isTestMode
//       ? dotenv.env['PAYMOB_TEST_API_KEY'] ?? ''
//       : dotenv.env['PAYMOB_PROD_API_KEY'] ?? '';

//   static String get _integrationId => _isTestMode
//       ? dotenv.env['PAYMOB_TEST_INTEGRATION_ID'] ?? ''
//       : dotenv.env['PAYMOB_PROD_INTEGRATION_ID'] ?? '';

//   static String get _iframeId => _isTestMode
//       ? dotenv.env['PAYMOB_TEST_IFRAME_ID'] ?? ''
//       : dotenv.env['PAYMOB_PROD_IFRAME_ID'] ?? '';

//   /// Initialize Paymob service
//   static void initialize() {
//     _dio.options.baseUrl = _baseUrl;
//     _dio.options.connectTimeout = const Duration(seconds: 30);
//     _dio.options.receiveTimeout = const Duration(seconds: 30);

//     // Add logging in test mode
//     if (_isTestMode) {
//       _dio.interceptors.add(LogInterceptor(
//         request: true,
//         requestBody: true,
//         responseBody: true,
//         error: true,
//       ));
//     }
//   }

//   /// Step 1: Authenticate and get token
//   /// Returns authentication token for subsequent API calls
//   static Future<String> authenticatePaymob() async {
//     try {
//       final response = await _dio.post(
//         '/auth/tokens',
//         data: {'api_key': _apiKey},
//       );

//       if (response.statusCode == 201 && response.data['token'] != null) {
//         return response.data['token'] as String;
//       }

//       throw Exception('Failed to authenticate with Paymob');
//     } catch (e) {
//       throw Exception('Paymob authentication error: $e');
//     }
//   }

//   /// Step 2: Register order
//   /// Creates an order in Paymob system
//   static Future<int> createOrder({
//     required String authToken,
//     required int amountCents,
//     required String currency,
//     required String merchantOrderId,
//   }) async {
//     try {
//       final response = await _dio.post(
//         '/ecommerce/orders',
//         data: {
//           'auth_token': authToken,
//           'delivery_needed': 'false',
//           'amount_cents': amountCents.toString(),
//           'currency': currency,
//           'merchant_order_id': merchantOrderId,
//           'items': [], // Empty for service payments
//         },
//       );

//       if (response.statusCode == 201 && response.data['id'] != null) {
//         return response.data['id'] as int;
//       }

//       throw Exception('Failed to create order');
//     } catch (e) {
//       throw Exception('Paymob order creation error: $e');
//     }
//   }

//   /// Step 3: Generate payment key
//   /// Creates a payment key for the iframe
//   static Future<String> createPaymentKey({
//     required String authToken,
//     required int orderId,
//     required int amountCents,
//     required String currency,
//     required Map<String, dynamic> billingData,
//   }) async {
//     try {
//       final response = await _dio.post(
//         '/acceptance/payment_keys',
//         data: {
//           'auth_token': authToken,
//           'amount_cents': amountCents.toString(),
//           'expiration': 3600, // 1 hour
//           'order_id': orderId.toString(),
//           'billing_data': billingData,
//           'currency': currency,
//           'integration_id': int.parse(_integrationId),
//         },
//       );

//       if (response.statusCode == 201 && response.data['token'] != null) {
//         return response.data['token'] as String;
//       }

//       throw Exception('Failed to create payment key');
//     } catch (e) {
//       throw Exception('Paymob payment key error: $e');
//     }
//   }

//   /// Complete payment flow and return iframe URL
//   /// This is the main method to call for processing payment
//   static Future<String> processPayment({
//     required int amountCents,
//     required String currency,
//     required String customerEmail,
//     required String customerPhone,
//     required String customerName,
//   }) async {
//     try {
//       // Step 1: Authenticate
//       final authToken = await authenticatePaymob();

//       // Step 2: Create order
//       final merchantOrderId = 'order_${DateTime.now().millisecondsSinceEpoch}';
//       final orderId = await createOrder(
//         authToken: authToken,
//         amountCents: amountCents,
//         currency: currency,
//         merchantOrderId: merchantOrderId,
//       );

//       // Step 3: Get payment key
//       final billingData = {
//         'email': customerEmail,
//         'phone_number': customerPhone,
//         'first_name': customerName.split(' ').first,
//         'last_name': customerName.split(' ').last,
//         'apartment': 'NA',
//         'floor': 'NA',
//         'street': 'NA',
//         'building': 'NA',
//         'shipping_method': 'NA',
//         'postal_code': 'NA',
//         'city': 'Cairo',
//         'country': 'EG',
//         'state': 'Cairo',
//       };

//       final paymentKey = await createPaymentKey(
//         authToken: authToken,
//         orderId: orderId,
//         amountCents: amountCents,
//         currency: currency,
//         billingData: billingData,
//       );

//       // Return iframe URL with payment key
//       return '$_iframeUrl/$_iframeId?payment_token=$paymentKey';
//     } catch (e) {
//       throw Exception('Paymob payment processing error: $e');
//     }
//   }

//   /// Get the current mode (for display purposes)
//   static String get currentMode =>
//       _isTestMode ? 'Test Mode' : 'Production Mode';

//   /// Check if in test mode
//   static bool get isTestMode => _isTestMode;
// }
