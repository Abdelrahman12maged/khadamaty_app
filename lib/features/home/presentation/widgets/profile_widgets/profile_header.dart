import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';
import 'package:khadamaty_app/generated/l10n.dart';

/// Profile header widget with user info and avatar
class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String? avatarUrl;
  final VoidCallback? onEditPressed;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    this.avatarUrl,
    this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    final avatarSize = context.responsive(
      mobile: 80.0,
      tablet: 100.0,
      desktop: 120.0,
    );

    return Container(
      padding: EdgeInsets.all(AppSpacing.lg(context)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryBlue,
            AppColors.primaryBlueLight,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          // Avatar
          CircleAvatar(
            radius: avatarSize / 2,
            backgroundColor: Colors.white,
            child: avatarUrl != null
                ? ClipOval(
                    child: Image.network(
                      avatarUrl!,
                      width: avatarSize,
                      height: avatarSize,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _buildPlaceholderAvatar(avatarSize),
                    ),
                  )
                : _buildPlaceholderAvatar(avatarSize),
          ),
          SizedBox(height: AppSpacing.md(context)),

          // Name
          Text(
            name,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSpacing.xs(context)),

          // Email
          Text(
            email,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSpacing.md(context)),

          // Edit Button
          OutlinedButton.icon(
            onPressed: onEditPressed,
            icon: const Icon(Icons.edit_outlined, size: 18),
            label: Text(S.of(context).editProfile),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white, width: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderAvatar(double size) {
    return Icon(
      Icons.person,
      size: size * 0.6,
      color: AppColors.primaryBlue,
    );
  }
}
