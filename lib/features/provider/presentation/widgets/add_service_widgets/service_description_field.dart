import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/generated/l10n.dart';

/// Description input field for Add Service form
class ServiceDescriptionField extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;
  final bool showError;

  const ServiceDescriptionField({
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
        labelText: s.serviceDescription,
        hintText: s.enterDescription,
        // No prefixIcon for multiline to avoid overflow issues
        floatingLabelBehavior: FloatingLabelBehavior.always,
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        errorText: showError && value.isEmpty ? s.pleaseEnterDescription : null,
      ),
      maxLines: 4,
      minLines: 3,
      textInputAction: TextInputAction.newline,
      onChanged: onChanged,
    );
  }
}
