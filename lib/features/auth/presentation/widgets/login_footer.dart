import 'package:flutter/material.dart';
import 'package:khadamaty_app/generated/l10n.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(s.dontHaveAccount),
        TextButton(
          onPressed: () {
            // TODO: Navigate to register screen
          },
          child: Text(s.signUp),
        ),
      ],
    );
  }
}
