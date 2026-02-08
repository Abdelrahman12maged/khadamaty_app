import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/core/utils/ui_helpers.dart';
import 'package:khadamaty_app/features/provider/domain/entities/service_entity.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import '../../cubits/create_booking_cubit/create_booking_cubit.dart';
import '../../cubits/create_booking_cubit/create_booking_state.dart';
import 'date_selector.dart';
import 'time_selector.dart';

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
          UIHelpers.showSuccessSnackbar(
            context: context,
            message: s.bookingSuccess,
          );
          // TODO: Navigate to My Bookings or refresh
        } else if (state.status == CreateBookingStatus.error) {
          UIHelpers.showErrorSnackbar(
            context: context,
            message: state.errorMessage ?? s.bookingFailed,
          );
        }
      },
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom +
                AppSpacing.page(context),
            left: AppSpacing.page(context),
            right: AppSpacing.page(context),
            top: AppSpacing.page(context),
          ),
          decoration: BoxDecoration(
            color: AppColors.surface(context),
            borderRadius: const BorderRadius.only(
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
                    s.bookingDetails,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close,
                        color: AppColors.textPrimary(context)),
                  ),
                ],
              ),
              const Divider(),
              SizedBox(height: AppSpacing.md(context)),

              // Date Selection
              Text(
                s.selectDate,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: AppSpacing.sm(context)),
              DateSelector(
                selectedDate: state.selectedDate,
                onDateSelected: (date) =>
                    context.read<CreateBookingCubit>().selectDate(date),
              ),

              SizedBox(height: AppSpacing.md(context)),

              // Time Selection
              Text(
                s.selectTime,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: AppSpacing.sm(context)),
              TimeSelector(
                selectedTime: state.selectedTime,
                onTimeSelected: (time) =>
                    context.read<CreateBookingCubit>().selectTime(time),
              ),

              SizedBox(height: AppSpacing.md(context)),

              // Notes
              Text(
                s.additionalNotes,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: AppSpacing.sm(context)),
              TextField(
                controller: _notesController,
                decoration: InputDecoration(
                  hintText: s.addNotesHint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: AppColors.background(context),
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
                    padding:
                        EdgeInsets.symmetric(vertical: AppSpacing.md(context)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: state.status == CreateBookingStatus.loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          s.confirmBookingWithPrice(
                              widget.service.price.toStringAsFixed(0),
                              s.currency),
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
