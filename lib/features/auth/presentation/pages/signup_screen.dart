import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import 'package:khadamaty_app/core/widgets/responsive_layout.dart';
import 'package:khadamaty_app/core/utils/error_mapper.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/signup_header.dart';
import '../widgets/signup_form.dart';
import '../widgets/signup_footer.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignup() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().register(
            name: _nameController.text,
            phone: _phoneController.text,
            email: _emailController.text,
            password: _passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              // Use ErrorMapper for localized error message
              final message = state.failure != null
                  ? ErrorMapper.getLocalizedMessage(context, state.failure!)
                  : state.message;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is AuthEmailVerificationPending) {
              // Navigate to email verification screen
              context.go('/email-verification?email=${state.user.email}');
            } else if (state is AuthAuthenticated) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text('${S.of(context).welcomeBack}, ${state.user.name}!'),
                  backgroundColor: Colors.green,
                ),
              );
              // TODO: Navigate to home screen
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            // 🎯 Using ResponsiveLayout - handles all responsive logic!
            return ResponsiveLayout(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SignupHeader(),
                  SignupForm(
                    formKey: _formKey,
                    nameController: _nameController,
                    phoneController: _phoneController, // NEW
                    emailController: _emailController,
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController,
                    onSignup: _handleSignup,
                    isLoading: isLoading,
                  ),
                  const SizedBox(height: 24),
                  const SignupFooter(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
