import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import '../../../domain/entities/service_entity.dart';

/// Availability schedule picker for appointment services
class AvailabilityPicker extends StatelessWidget {
  final ServiceAvailability value;
  final ValueChanged<ServiceAvailability> onChanged;

  const AvailabilityPicker({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Work days selection
        Text(
          s.workDays,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: AppSpacing.sm(context)),
        _WorkDaysSelector(
          selectedDays: value.workDays,
          onChanged: (days) => onChanged(ServiceAvailability(
            workDays: days,
            startTime: value.startTime,
            endTime: value.endTime,
          )),
        ),

        SizedBox(height: AppSpacing.md(context)),

        // Time range
        Text(
          s.workingHours,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: AppSpacing.sm(context)),
        Row(
          children: [
            Expanded(
              child: _TimePickerField(
                label: s.startTime,
                value: value.startTime,
                onChanged: (time) => onChanged(ServiceAvailability(
                  workDays: value.workDays,
                  startTime: time,
                  endTime: value.endTime,
                )),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm(context)),
              child: Icon(Icons.arrow_forward,
                  color: AppColors.textSecondary(context)),
            ),
            Expanded(
              child: _TimePickerField(
                label: s.endTime,
                value: value.endTime,
                onChanged: (time) => onChanged(ServiceAvailability(
                  workDays: value.workDays,
                  startTime: value.startTime,
                  endTime: time,
                )),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _WorkDaysSelector extends StatelessWidget {
  final List<int> selectedDays;
  final ValueChanged<List<int>> onChanged;

  const _WorkDaysSelector({
    required this.selectedDays,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final dayNames = [
      s.sun,
      s.mon,
      s.tue,
      s.wed,
      s.thu,
      s.fri,
      s.sat,
    ];

    return Wrap(
      spacing: AppSpacing.xs(context),
      runSpacing: AppSpacing.xs(context),
      children: List.generate(7, (index) {
        final isSelected = selectedDays.contains(index);
        return FilterChip(
          label: Text(dayNames[index]),
          selected: isSelected,
          onSelected: (_) {
            final newDays = List<int>.from(selectedDays);
            if (isSelected) {
              newDays.remove(index);
            } else {
              newDays.add(index);
              newDays.sort();
            }
            onChanged(newDays);
          },
          selectedColor: AppColors.primaryBlue.withValues(alpha: 0.2),
          checkmarkColor: AppColors.primaryBlue,
        );
      }),
    );
  }
}

class _TimePickerField extends StatelessWidget {
  final String label;
  final String value;
  final ValueChanged<String> onChanged;

  const _TimePickerField({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final parts = value.split(':');
        final initialTime = TimeOfDay(
          hour: int.tryParse(parts[0]) ?? 9,
          minute: int.tryParse(parts[1]) ?? 0,
        );

        final picked = await showTimePicker(
          context: context,
          initialTime: initialTime,
        );

        if (picked != null) {
          final formatted =
              '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
          onChanged(formatted);
        }
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.all(AppSpacing.md(context)),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.divider(context)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary(context),
                      ),
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            Icon(Icons.access_time, color: AppColors.textSecondary(context)),
          ],
        ),
      ),
    );
  }
}
