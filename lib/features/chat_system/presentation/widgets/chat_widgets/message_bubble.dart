import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import '../../../domain/Entity/chat_message_entity.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessageEntity message;
  final bool isMine;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMine,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        margin: EdgeInsets.only(
          left: isMine ? AppSpacing.xl(context) : AppSpacing.sm(context),
          right: isMine ? AppSpacing.sm(context) : AppSpacing.xl(context),
          bottom: AppSpacing.xs(context),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.sm(context) + 4,
          vertical: AppSpacing.sm(context),
        ),
        decoration: BoxDecoration(
          color: isMine ? AppColors.primaryBlue : AppColors.surface(context),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMine ? 16 : 4),
            bottomRight: Radius.circular(isMine ? 4 : 16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Message text
            Text(
              message.text,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isMine ? Colors.white : null,
              ),
            ),
            SizedBox(height: AppSpacing.xs(context) / 2),
            // Time + read indicator
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${message.createdAt.hour.toString().padLeft(2, '0')}:${message.createdAt.minute.toString().padLeft(2, '0')}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: isMine
                        ? Colors.white.withValues(alpha: 0.7)
                        : AppColors.textSecondary(context),
                    fontSize: 10,
                  ),
                ),
                if (isMine) ...[
                  const SizedBox(width: 4),
                  Icon(
                    message.isRead ? Icons.done_all : Icons.done,
                    size: 14,
                    color: message.isRead
                        ? Colors.lightBlueAccent
                        : Colors.white.withValues(alpha: 0.7),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
