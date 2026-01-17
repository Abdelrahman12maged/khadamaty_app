import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/generated/l10n.dart';

/// Duration input field for appointment services
class DurationInputField extends StatelessWidget {
  final int? value;
  final ValueChanged<int?> onChanged;
  final bool showError;

  const DurationInputField({
    super.key,
    required this.value,
    required this.onChanged,
    this.showError = false,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          initialValue: value?.toString(),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: s.duration,
            hintText: s.durationHint,
            suffixText: s.minutes,
            prefixIcon: const Icon(Icons.timer_outlined),
            errorText: showError && (value == null || value! <= 0)
                ? s.pleaseEnterDuration
                : null,
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(3),
          ],
          onChanged: (text) {
            final parsed = int.tryParse(text);
            onChanged(parsed);
          },
        ),
        SizedBox(height: AppSpacing.xs(context)),
        // Quick duration buttons
        Wrap(
          spacing: AppSpacing.xs(context),
          children: [
            _DurationChip(
                label: '15',
                value: 15,
                currentValue: value,
                onSelected: onChanged),
            _DurationChip(
                label: '30',
                value: 30,
                currentValue: value,
                onSelected: onChanged),
            _DurationChip(
                label: '45',
                value: 45,
                currentValue: value,
                onSelected: onChanged),
            _DurationChip(
                label: '60',
                value: 60,
                currentValue: value,
                onSelected: onChanged),
            _DurationChip(
                label: '90',
                value: 90,
                currentValue: value,
                onSelected: onChanged),
          ],
        ),
      ],
    );
  }
}

class _DurationChip extends StatelessWidget {
  final String label;
  final int value;
  final int? currentValue;
  final ValueChanged<int?> onSelected;

  const _DurationChip({
    required this.label,
    required this.value,
    required this.currentValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = currentValue == value;

    return FilterChip(
      label: Text('$label ${S.of(context).min}'),
      selected: isSelected,
      onSelected: (_) => onSelected(value),
      visualDensity: VisualDensity.compact,
    );
  }
}
