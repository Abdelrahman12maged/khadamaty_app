import 'package:flutter/material.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import 'package:khadamaty_app/core/utils/validators.dart';
import 'custom_text_field.dart';
import 'auth_button.dart';

class SignupForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController phoneController; // NEW
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onSignup;
  final bool isLoading;

  const SignupForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.phoneController, // NEW
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onSignup,
    required this.isLoading,
  });

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          const SizedBox(height: 48),
          CustomTextField(
            controller: widget.nameController,
            label: s.fullName,
            hint: s.enterYourName,
            prefixIcon: Icons.person_outlined,
            keyboardType: TextInputType.name,
            validator: (value) => Validators.name(value, context),
          ),
          const SizedBox(height: 24),
          // Phone Number Field (NEW - after name, before email)
          CustomTextField(
            controller: widget.phoneController,
            label: s.phoneNumber,
            hint: s.enterYourPhone,
            prefixIcon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            validator: (value) => Validators.phone(value, context),
          ),
          const SizedBox(height: 24),
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
          const SizedBox(height: 24),
          CustomTextField(
            controller: widget.confirmPasswordController,
            label: s.confirmPassword,
            hint: s.confirmYourPassword,
            prefixIcon: Icons.lock_outlined,
            obscureText: _obscureConfirmPassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return s.pleaseEnterPassword;
              }
              if (value != widget.passwordController.text) {
                return s.passwordsDontMatch;
              }
              return null;
            },
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
            ),
          ),
          const SizedBox(height: 32),
          AuthButton(
            text: s.signUp,
            onPressed: widget.onSignup,
            isLoading: widget.isLoading,
          ),
        ],
      ),
    );
  }
}
