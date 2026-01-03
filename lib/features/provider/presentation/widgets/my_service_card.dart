import 'package:flutter/material.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';
import '../../domain/entities/service_entity.dart';

/// My Service Card widget
class MyServiceCard extends StatelessWidget {
  final ServiceEntity service;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final ValueChanged<bool>? onToggleStatus;

  const MyServiceCard({
    super.key,
    required this.service,
    this.onEdit,
    this.onDelete,
    this.onToggleStatus,
  });

  @override
  Widget build(BuildContext context) {
    final imageSize = context.responsive(
      mobile: 80.0,
      tablet: 90.0,
      desktop: 100.0,
    );

    return Container(
      margin: EdgeInsets.only(bottom: AppSpacing.md(context)),
      padding: EdgeInsets.all(AppSpacing.md(context)),
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider(context)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: service.imageUrl != null
                ? Image.network(
                    service.imageUrl!,
                    width: imageSize,
                    height: imageSize,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildPlaceholder(imageSize),
                  )
                : _buildPlaceholder(imageSize),
          ),
          SizedBox(width: AppSpacing.md(context)),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + Status indicator
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        service.title,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Status indicator
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: service.isActive ? Colors.green : Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.xs(context)),

                // Category + Service Type
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        service.category,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.primaryBlue,
                            ),
                      ),
                    ),
                    SizedBox(width: AppSpacing.xs(context)),
                    if (service.requiresAppointment)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          S.of(context).appointment,
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Colors.orange,
                                  ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: AppSpacing.xs(context)),

                // Price
                Text(
                  '${service.price.toStringAsFixed(0)} ${S.of(context).currency}',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: AppSpacing.xs(context)),

                // Rating
                Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: Colors.orange),
                    const SizedBox(width: 4),
                    Text(
                      '${service.rating} (${service.reviewCount})',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Actions
          Column(
            children: [
              // Edit
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: onEdit,
                tooltip: S.of(context).edit,
                color: AppColors.primaryBlue,
              ),
              // Delete
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: onDelete,
                tooltip: S.of(context).delete,
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder(double size) {
    return Container(
      width: size,
      height: size,
      color: Colors.grey.shade200,
      child: Icon(
        Icons.work_outline,
        size: size * 0.4,
        color: Colors.grey.shade400,
      ),
    );
  }
}
