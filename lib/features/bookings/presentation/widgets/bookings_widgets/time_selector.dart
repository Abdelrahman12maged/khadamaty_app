import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';

class TimeSelector extends StatelessWidget {
  final String? selectedTime;
  final Function(String) onTimeSelected;

  const TimeSelector(
      {super.key, required this.selectedTime, required this.onTimeSelected});

  @override
  Widget build(BuildContext context) {
    final times = [
      '09:00 AM',
      '10:00 AM',
      '11:00 AM',
      '12:00 PM',
      '01:00 PM',
      '02:00 PM',
      '03:00 PM',
      '04:00 PM'
    ];

    return Wrap(
      spacing: AppSpacing.sm(context),
      runSpacing: AppSpacing.sm(context),
      children: times.map((time) {
        final isSelected = selectedTime == time;
        return GestureDetector(
          onTap: () => onTimeSelected(time),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primaryBlue
                  : AppColors.background(context),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? AppColors.primaryBlue
                    : AppColors.divider(context),
              ),
            ),
            child: Text(
              time,
              style: TextStyle(
                color:
                    isSelected ? Colors.white : AppColors.textPrimary(context),
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
