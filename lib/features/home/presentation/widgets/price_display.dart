import 'package:flutter/material.dart';
import 'package:khadamaty_app/generated/l10n.dart';

/// Price display widget
class PriceDisplay extends StatelessWidget {
  final double price;
  final String priceUnit;

  const PriceDisplay({
    super.key,
    required this.price,
    required this.priceUnit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${S.of(context).from} \$${price.toStringAsFixed(0)}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          priceUnit,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}
