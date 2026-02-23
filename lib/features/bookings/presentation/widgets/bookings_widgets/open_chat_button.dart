import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/features/bookings/domain/entities/booking_entity.dart';
import 'package:khadamaty_app/features/chat_system/presentation/cubits/open_chat_cubit/open_chat_cubit.dart';
import 'package:khadamaty_app/features/chat_system/presentation/cubits/open_chat_cubit/open_chat_state.dart';

class OpenChatButton extends StatelessWidget {
  const OpenChatButton({
    super.key,
    required this.booking,
  });

  final BookingEntity booking;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OpenChatCubit, OpenChatState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: state.isLoading
                ? null
                : () => context.read<OpenChatCubit>().openChat(booking),
            icon: state.isLoading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(Icons.chat_outlined, size: 18),
            label: Text(state.isLoading ? 'جاري الفتح...' : 'محادثة'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryBlue,
              side: const BorderSide(
                color: AppColors.primaryBlue,
                width: 1,
              ),
              padding: EdgeInsets.symmetric(
                vertical: AppSpacing.sm(context),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        );
      },
    );
  }
}
