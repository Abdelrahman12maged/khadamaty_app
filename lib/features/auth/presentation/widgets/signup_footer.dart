import 'package:flutter/material.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import 'package:go_router/go_router.dart';

class SignupFooter extends StatelessWidget {
  const SignupFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(s.alreadyHaveAccount),
        TextButton(
          onPressed: () {
            context.go('/login');
          },
          child: Text(s.signIn),
        ),
      ],
    );
  }
}
