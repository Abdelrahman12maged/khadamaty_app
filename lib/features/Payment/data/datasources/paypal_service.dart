import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:khadamaty_app/features/Payment/data/datasources/payment_service.dart';
import 'package:khadamaty_app/features/Payment/data/models/payment_model.dart';
import 'package:khadamaty_app/features/Payment/data/models/payment_params.dart';

/// PayPal payment service.
///
/// Note: PayPal uses `PaypalCheckoutView` widget for the checkout UI,
/// so `makePaymentIntent` is not used in the same way as Stripe.
/// The actual payment flow is handled in `PaypalPaymentButton`.
class PaypalService implements PaymentService {
  PaypalService();

  // ─── Config (from .env) ────────────────────────────────────

  static String get clientId => dotenv.env['PAYPAL_CLIENT_ID'] ?? '';

  static String get secretKey => dotenv.env['PAYPAL_SECRET_KEY'] ?? '';

  static bool get sandboxMode =>
      dotenv.env['PAYPAL_SANDBOX_MODE']?.toLowerCase() == 'true';

  // ─── Transaction Builder ───────────────────────────────────

  /// Build transaction details for PayPal checkout.
  static Map<String, dynamic> buildTransaction({
    required String amount,
    required String currency,
    required String description,
  }) {
    return {
      "amount": {
        "total": amount,
        "currency": currency,
        "details": {
          "subtotal": amount,
          "shipping": '0',
          "shipping_discount": 0,
        }
      },
      "description": description,
      "item_list": {
        "items": [
          {
            "name": "Khadamaty Service",
            "quantity": 1,
            "price": amount,
            "currency": currency,
          }
        ],
      }
    };
  }

  // ─── PaymentService Interface ──────────────────────────────

  /// Not used for PayPal — flow is handled via PaypalCheckoutView widget.
  /// This exists only to satisfy the PaymentService interface.
  @override
  Future<PaymentModel> makePaymentIntent({required PaymentParams params}) {
    throw UnsupportedError(
      'PayPal uses PaypalCheckoutView widget. '
      'Use PaypalPaymentButton instead.',
    );
  }
}
