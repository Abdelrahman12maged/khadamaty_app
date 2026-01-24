import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/features/provider/domain/entities/service_entity.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import '../../cubits/create_booking_cubit/create_booking_cubit.dart';
import '../../cubits/create_booking_cubit/create_booking_state.dart';

class BookingSheet extends StatefulWidget {
  final ServiceEntity service;

  const BookingSheet({super.key, required this.service});

  @override
  State<BookingSheet> createState() => _BookingSheetState();
}

class _BookingSheetState extends State<BookingSheet> {
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);

    return BlocConsumer<CreateBookingCubit, CreateBookingState>(
      listener: (context, state) {
        if (state.status == CreateBookingStatus.success) {
          Navigator.pop(context); // Close sheet
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم الحجز بنجاح!'),
              backgroundColor: AppColors.successGreen,
            ),
          );
          // TODO: Navigate to My Bookings or refresh
        } else if (state.status == CreateBookingStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'فشل الحجز'),
              backgroundColor: AppColors.errorRed,
            ),
          );
        }
      },
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'تفاصيل الحجز',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(),
              SizedBox(height: AppSpacing.md(context)),

              // Date Selection
              const Text('اختر التاريخ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: AppSpacing.sm(context)),
              _DateSelector(
                selectedDate: state.selectedDate,
                onDateSelected: (date) =>
                    context.read<CreateBookingCubit>().selectDate(date),
              ),

              SizedBox(height: AppSpacing.md(context)),

              // Time Selection (Static for now, can be dynamic based on availability)
              const Text('اختر الوقت',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: AppSpacing.sm(context)),
              _TimeSelector(
                selectedTime: state.selectedTime,
                onTimeSelected: (time) =>
                    context.read<CreateBookingCubit>().selectTime(time),
              ),

              SizedBox(height: AppSpacing.md(context)),

              // Notes
              const Text('ملاحظات إضافية',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: AppSpacing.sm(context)),
              TextField(
                controller: _notesController,
                decoration: InputDecoration(
                  hintText: 'أضف أي تفاصيل أخرى...',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                maxLines: 2,
              ),

              SizedBox(height: AppSpacing.lg(context)),

              // Confirm Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: state.status == CreateBookingStatus.loading
                      ? null
                      : () {
                          context.read<CreateBookingCubit>().confirmBooking(
                                service: widget.service,
                                notes: _notesController.text,
                              );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: state.status == CreateBookingStatus.loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'تأكيد الحجز (${widget.service.price.toStringAsFixed(0)} ${s.currency})',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                ),
              ),
              SizedBox(height: AppSpacing.lg(context)),
            ],
          ),
        );
      },
    );
  }
}

class _DateSelector extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  const _DateSelector(
      {required this.selectedDate, required this.onDateSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 14, // Next 2 weeks
        itemBuilder: (context, index) {
          final date = DateTime.now().add(Duration(days: index));
          final isSelected = selectedDate != null &&
              selectedDate!.year == date.year &&
              selectedDate!.month == date.month &&
              selectedDate!.day == date.day;

          return GestureDetector(
            onTap: () => onDateSelected(date),
            child: Container(
              width: 50,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryBlue : Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('E').format(date),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    date.day.toString(),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TimeSelector extends StatelessWidget {
  final String? selectedTime;
  final Function(String) onTimeSelected;

  const _TimeSelector(
      {required this.selectedTime, required this.onTimeSelected});

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
      spacing: 10,
      runSpacing: 10,
      children: times.map((time) {
        final isSelected = selectedTime == time;
        return GestureDetector(
          onTap: () => onTimeSelected(time),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryBlue : Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              time,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
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
