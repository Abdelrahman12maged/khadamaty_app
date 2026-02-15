// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:khadamaty_app/core/utils/app_spacing.dart';
// import 'package:khadamaty_app/core/utils/responsive_value.dart';
// import 'package:khadamaty_app/generated/l10n.dart';
// import 'package:khadamaty_app/features/Payment/presentation/cubit/payment_cubit.dart';
// import 'package:khadamaty_app/features/Payment/data/datasources/paymob_service.dart';

// /// Paymob payment button widget with responsive design
// /// Supports all Paymob payment methods (Cards + Wallets)
// class PaymobPaymentButton extends StatelessWidget {
//   final double amount;
//   final String currency;
//   final bool isLoading;
//   final String customerEmail;
//   final String customerPhone;
//   final String customerName;

//   // Paymob brand color
//   static const Color paymobColor = Color(0xFF00A3FF);

//   const PaymobPaymentButton({
//     super.key,
//     required this.amount,
//     required this.currency,
//     required this.isLoading,
//     required this.customerEmail,
//     required this.customerPhone,
//     required this.customerName,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Responsive button padding
//     final buttonPadding = context.responsive(
//       mobile: AppSpacing.md(context),
//       tablet: AppSpacing.lg(context),
//       desktop: AppSpacing.lg(context),
//     );

//     // Responsive font size
//     final fontSize = context.responsive(
//       mobile: 16.0,
//       tablet: 18.0,
//       desktop: 20.0,
//     );

//     // Responsive icon size
//     final iconSize = context.responsive(
//       mobile: 24.0,
//       tablet: 28.0,
//       desktop: 32.0,
//     );

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         ElevatedButton.icon(
//           onPressed: isLoading ? null : () => _processPayment(context),
//           icon: Icon(Icons.payment, size: iconSize),
//           label: Text(S.of(context).payWithPaymob),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: paymobColor,
//             foregroundColor: Colors.white,
//             padding: EdgeInsets.symmetric(
//               vertical: buttonPadding,
//               horizontal: context.isDesktop ? AppSpacing.xl(context) : 0,
//             ),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(AppSpacing.header(context)),
//             ),
//             textStyle:
//                 TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
//           ),
//         ),

//         // Test mode indicator
//         if (PaymobService.isTestMode) ...[
//           SizedBox(height: AppSpacing.xs(context)),
//           Center(
//             child: Text(
//               S.of(context).paymobTestMode,
//               style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                     color: Colors.orange,
//                     fontStyle: FontStyle.italic,
//                   ),
//             ),
//           ),
//         ],
//       ],
//     );
//   }

//   void _processPayment(BuildContext context) async {
//     final cubit = context.read<PaymentCubit>();

//     // Convert amount to cents
//     final amountInCents = (amount * 100).toInt();

//     try {
//       // Get iframe URL from Paymob
//       final iframeUrl = await PaymobService.processPayment(
//         amountCents: amountInCents,
//         currency: currency.toUpperCase(),
//         customerEmail: customerEmail,
//         customerPhone: customerPhone,
//         customerName: customerName,
//       );

//       // Launch Paymob iframe in browser
//       final uri = Uri.parse(iframeUrl);
//       if (await canLaunchUrl(uri)) {
//         await launchUrl(
//           uri,
//           mode: LaunchMode.inAppWebView,
//         );

//         // After iframe closes, we'll need a callback mechanism
//         // For now, we mark as processing
//         // cubit.processPaymobPayment(
//         //   amount: amountInCents,
//         //   currency: currency,
//         // );
//       } else {
//         throw Exception('Could not launch payment page');
//       }
//     } catch (e) {
//       // cubit.recordPaymobError(error: e.toString());
//     }
//   }
// }
