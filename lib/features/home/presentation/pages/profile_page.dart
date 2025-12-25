import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/widgets/loading_indicator.dart';
import '../cubits/profile_cubit/profile_cubit.dart';
import '../cubits/profile_cubit/profile_state.dart';
import '../widgets/profile_widgets/profile_header.dart';
import '../widgets/profile_widgets/profile_stats_card.dart';
import '../widgets/profile_widgets/profile_action_item.dart';
import '../widgets/profile_widgets/profile_setting_item.dart';
import '../widgets/profile_widgets/profile_section.dart';

/// Profile page with user information and settings
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..loadProfile(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).profile),
          elevation: 0,
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state.isLoading && state.profile == null) {
              return Center(
                child: LoadingIndicator(message: S.of(context).loadingHomeData),
              );
            }

            if (state.profile == null) {
              return Center(
                child: Text(S.of(context).loadingHomeData),
              );
            }

            final profile = state.profile!;

            return RefreshIndicator(
              onRefresh: () =>
                  context.read<ProfileCubit>().refreshProfile(context),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    // Profile Header
                    ProfileHeader(
                      name: profile.name,
                      email: profile.email,
                      avatarUrl: profile.avatarUrl,
                      onEditPressed: () {
                        // TODO: Navigate to edit profile
                      },
                    ),
                    SizedBox(height: AppSpacing.lg(context)),

                    // Stats Cards
                    _buildStatsSection(context, profile),
                    SizedBox(height: AppSpacing.lg(context)),

                    // Quick Actions
                    ProfileSection(
                      title: S.of(context).quickActions,
                      children: [
                        ProfileActionItem(
                          icon: Icons.event_note,
                          title: S.of(context).myBookings,
                          onTap: () {
                            // TODO: Navigate to bookings
                          },
                        ),
                        Divider(height: 1, color: AppColors.divider(context)),
                        ProfileActionItem(
                          icon: Icons.favorite_outline,
                          title: S.of(context).favoriteServices,
                          onTap: () {
                            // TODO: Navigate to favorites
                          },
                        ),
                        Divider(height: 1, color: AppColors.divider(context)),
                        ProfileActionItem(
                          icon: Icons.payment,
                          title: S.of(context).paymentMethods,
                          onTap: () {
                            // TODO: Navigate to payment methods
                          },
                        ),
                        Divider(height: 1, color: AppColors.divider(context)),
                        ProfileActionItem(
                          icon: Icons.location_on_outlined,
                          title: S.of(context).myAddresses,
                          onTap: () {
                            // TODO: Navigate to addresses
                          },
                        ),
                        Divider(height: 1, color: AppColors.divider(context)),
                        ProfileActionItem(
                          icon: Icons.help_outline,
                          title: S.of(context).helpSupport,
                          onTap: () {
                            // TODO: Navigate to help
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: AppSpacing.lg(context)),

                    // Settings
                    ProfileSection(
                      title: S.of(context).settings,
                      children: [
                        ProfileSettingItem(
                          icon: Icons.notifications_outlined,
                          title: S.of(context).notifications,
                          value: true,
                          onChanged: (value) {
                            // TODO: Toggle notifications
                          },
                        ),
                        Divider(height: 1, color: AppColors.divider(context)),
                        ProfileSettingItem(
                          icon: Icons.dark_mode_outlined,
                          title: S.of(context).darkMode,
                          value:
                              Theme.of(context).brightness == Brightness.dark,
                          onChanged: (value) {
                            // TODO: Toggle theme
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: AppSpacing.lg(context)),

                    // Account Settings
                    ProfileSection(
                      title: S.of(context).accountSettings,
                      children: [
                        ProfileActionItem(
                          icon: Icons.lock_outline,
                          title: S.of(context).changePassword,
                          onTap: () {
                            // TODO: Navigate to change password
                          },
                        ),
                        Divider(height: 1, color: AppColors.divider(context)),
                        ProfileActionItem(
                          icon: Icons.privacy_tip_outlined,
                          title: S.of(context).privacyPolicy,
                          onTap: () {
                            // TODO: Navigate to privacy policy
                          },
                        ),
                        Divider(height: 1, color: AppColors.divider(context)),
                        ProfileActionItem(
                          icon: Icons.description_outlined,
                          title: S.of(context).termsOfService,
                          onTap: () {
                            // TODO: Navigate to terms
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: AppSpacing.lg(context)),

                    // Logout Button
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.md(context)),
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () => _showLogoutDialog(context),
                          icon: const Icon(Icons.logout),
                          label: Text(S.of(context).logout),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                            padding: EdgeInsets.symmetric(
                              vertical: AppSpacing.md(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: AppSpacing.xl(context)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context, ProfileData profile) {
    final isDesktop = context.isDesktop;
    final isTablet = context.isTablet;

    final stats = [
      ProfileStatsCard(
        icon: Icons.event_note,
        label: S.of(context).totalBookings,
        value: profile.totalBookings.toString(),
        iconColor: AppColors.primaryBlue,
      ),
      ProfileStatsCard(
        icon: Icons.check_circle_outline,
        label: S.of(context).completedServices,
        value: profile.completedServices.toString(),
        iconColor: Colors.green,
      ),
      ProfileStatsCard(
        icon: Icons.account_balance_wallet_outlined,
        label: S.of(context).totalSpent,
        value:
            '${profile.totalSpent.toStringAsFixed(0)} ${S.of(context).currency}',
        iconColor: Colors.orange,
      ),
      ProfileStatsCard(
        icon: Icons.calendar_today,
        label: S.of(context).memberSince,
        value: DateFormat('MMM yyyy').format(profile.memberSince),
        iconColor: Colors.purple,
      ),
    ];

    if (isDesktop || isTablet) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.md(context)),
        child: GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: isDesktop ? 4 : 2,
          crossAxisSpacing: AppSpacing.md(context),
          mainAxisSpacing: AppSpacing.md(context),
          childAspectRatio: isDesktop ? 1.2 : 1.3,
          children: stats,
        ),
      );
    }

    // Mobile: 2x2 grid
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.md(context)),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.sm(context),
        mainAxisSpacing: AppSpacing.sm(context),
        childAspectRatio: 1.1,
        children: stats,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(S.of(context).logout),
        content: Text(S.of(context).logoutConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(S.of(context).cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              // TODO: Implement logout logic
              // Navigator.pushReplacementNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text(S.of(context).confirm),
          ),
        ],
      ),
    );
  }
}
