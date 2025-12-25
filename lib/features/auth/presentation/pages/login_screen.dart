import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import 'package:khadamaty_app/core/widgets/responsive_layout.dart';
import 'package:khadamaty_app/core/utils/error_mapper.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/login_header.dart';
import '../widgets/login_form.dart';
import '../widgets/login_footer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().login(
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
              // Navigate to main screen
              context.go('/main');
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;
//Responsivelayout  to handle varios screen sizes tablet,mobile,dektop
            return ResponsiveLayout(
              child:SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LoginHeader(),
                    LoginForm(
                      formKey: _formKey,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      onLogin: _handleLogin,
                      isLoading: isLoading,
                    ),
                    const SizedBox(height: 24),
                    const LoginFooter(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
