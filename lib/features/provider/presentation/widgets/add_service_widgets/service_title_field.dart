import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/generated/l10n.dart';

/// Title input field for Add Service form
class ServiceTitleField extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;
  final bool showError;

  const ServiceTitleField({
    super.key,
    required this.value,
    required this.onChanged,
    this.showError = false,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return TextFormField(
      initialValue: value,
      decoration: InputDecoration(
        labelText: s.serviceTitle,
        hintText: s.enterServiceTitle,
        prefixIcon: Icon(
          Icons.title,
          color: AppColors.textSecondary(context),
        ),
        errorText: showError && value.isEmpty ? s.pleaseEnterTitle : null,
      ),
      textInputAction: TextInputAction.next,
      onChanged: onChanged,
    );
  }
}
