import 'package:flutter/material.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import 'package:khadamaty_app/core/utils/validators.dart';
import 'custom_text_field.dart';
import 'auth_button.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;
  final bool isLoading;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onLogin,
    required this.isLoading,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          const SizedBox(height: 48),
          CustomTextField(
            controller: widget.emailController,
            label: s.email,
            hint: s.enterYourEmail,
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => Validators.email(value, context),
          ),
          const SizedBox(height: 24),
          CustomTextField(
            controller: widget.passwordController,
            label: s.password,
            hint: s.enterYourPassword,
            prefixIcon: Icons.lock_outlined,
            obscureText: _obscurePassword,
            validator: (value) => Validators.password(value, context),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
              },
              child: Text(s.forgotPassword),
            ),
          ),
          const SizedBox(height: 24),
          AuthButton(
            text: s.login,
            onPressed: widget.onLogin,
            isLoading: widget.isLoading,
          ),
        ],
      ),
    );
  }
}
