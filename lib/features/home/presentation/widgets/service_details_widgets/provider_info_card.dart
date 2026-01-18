import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/features/provider/domain/entities/service_entity.dart';
import 'package:khadamaty_app/generated/l10n.dart';

class ProviderInfoCard extends StatelessWidget {
  final ServiceEntity service;

  const ProviderInfoCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s.provider,
          style:
              theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: AppSpacing.sm(context)),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
            child: const Icon(Icons.person, color: AppColors.primaryBlue),
          ),
          title: Text(
            service.providerName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: const Text('Verified Professional'),
          trailing: IconButton(
            icon: const Icon(Icons.chat_bubble_outline,
                color: AppColors.primaryBlue),
            onPressed: () {
              // TODO: Implement Chat
            },
          ),
        ),
      ],
    );
  }
}
