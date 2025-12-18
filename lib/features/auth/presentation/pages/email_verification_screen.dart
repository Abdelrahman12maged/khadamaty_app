import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import 'package:khadamaty_app/core/widgets/responsive_layout.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/auth_button.dart';

class EmailVerificationScreen extends StatelessWidget {
  final String email;

  const EmailVerificationScreen({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(s.verifyEmail),
        actions: [
          // Logout button
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthCubit>().logout();
              context.go('/login');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              // Email verified - navigate to home
              // TODO: Navigate to home screen when ready
              context.go('/login');
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return ResponsiveLayout(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Email icon
                  Icon(
                    Icons.mark_email_unread_outlined,
                    size: 100,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 32),

                  // Title
                  Text(
                    s.verifyEmailTitle,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  // Description
                  Text(
                    s.verifyEmailDesc,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.textTheme.bodySmall?.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),

                  // Email
                  Text(
                    email,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),

                  // Check verification button
                  AuthButton(
                    text: s.iVerified,
                    onPressed: () {
                      context.read<AuthCubit>().checkEmailVerification();
                    },
                    isLoading: isLoading,
                  ),
                  const SizedBox(height: 16),

                  // Resend email button
                  AuthButton(
                    text: s.resendEmail,
                    onPressed: () {
                      context.read<AuthCubit>().resendEmailVerification();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(s.emailSent),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    isLoading: false,
                    isOutlined: true,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
