import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/features/provider/domain/entities/service_entity.dart';
import 'package:khadamaty_app/generated/l10n.dart';

class ServiceInfoSection extends StatelessWidget {
  final ServiceEntity service;

  const ServiceInfoSection({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.category,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: AppSpacing.xs(context)),
                  Text(
                    service.title,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${service.price} ${service.priceUnit}',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (service.durationMinutes != null)
                  Text(
                    '${service.durationMinutes} ${s.min}',
                    style: theme.textTheme.bodySmall,
                  ),
              ],
            ),
          ],
        ),
        SizedBox(height: AppSpacing.md(context)),
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 20),
            SizedBox(width: AppSpacing.xs(context)),
            Text(
              service.rating.toString(),
              style: theme.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: AppSpacing.xs(context)),
            Text(
              '(${service.reviewCount} ${s.reviews})',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
}
