import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import '../../../domain/entities/service_entity.dart';

/// Service Type Selector - On Demand vs Appointment
class ServiceTypeSelector extends StatelessWidget {
  final ServiceType value;
  final ValueChanged<ServiceType> onChanged;

  const ServiceTypeSelector({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s.serviceType,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: AppSpacing.sm(context)),
        Row(
          children: [
            Expanded(
              child: _ServiceTypeCard(
                icon: Icons.flash_on,
                title: s.onDemand,
                subtitle: s.onDemandDescription,
                isSelected: value == ServiceType.onDemand,
                onTap: () => onChanged(ServiceType.onDemand),
              ),
            ),
            SizedBox(width: AppSpacing.sm(context)),
            Expanded(
              child: _ServiceTypeCard(
                icon: Icons.calendar_month,
                title: s.appointment,
                subtitle: s.appointmentDescription,
                isSelected: value == ServiceType.appointment,
                onTap: () => onChanged(ServiceType.appointment),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ServiceTypeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _ServiceTypeCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(AppSpacing.md(context)),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryBlue.withValues(alpha: 0.1)
              : AppColors.surface(context),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isSelected ? AppColors.primaryBlue : AppColors.divider(context),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected
                  ? AppColors.primaryBlue
                  : AppColors.textSecondary(context),
            ),
            SizedBox(height: AppSpacing.xs(context)),
            Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: isSelected ? AppColors.primaryBlue : null,
              ),
            ),
            SizedBox(height: AppSpacing.xs(context)),
            Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary(context),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
