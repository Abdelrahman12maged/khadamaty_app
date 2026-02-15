
import 'package:khadamaty_app/features/Payment/domain/entities/paymentreuslt.dart';

/// Payment Model - Data layer
/// Used for JSON serialization/deserialization with Firestore
class PaymentModel extends PaymentResultEntity {
  const PaymentModel({

   required super.clientSecret,

  });

  /// Create PaymentModel from JSON (Firestore)
  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      // isSuccess: json['isSuccess'],
      // transactionId: json['transactionId'],
      // message: json['message'],
      clientSecret: json['client_secret'],
      

    );
  }

  /// Convert PaymentModel to JSON (for Firestore)
  Map<String, dynamic> toJson() {
    return {
     
    
    };
  }

}
