import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamaty_app/core/di/injection_container.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/core/utils/ui_helpers.dart';
import 'package:khadamaty_app/features/auth/domain/repositories/auth_repository.dart';
import '../../domain/Entity/chat_entity.dart';
import '../cubits/chat_cubit/chat_cubit.dart';
import '../cubits/chat_cubit/chat_state.dart';
import '../widgets/chat_widgets/message_bubble.dart';
import '../widgets/chat_widgets/chat_input_field.dart';

class ChatPage extends StatelessWidget {
  final ChatEntity chat;

  const ChatPage({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    final currentUserId = sl<AuthRepository>().currentUser?.id ?? '';

    return BlocProvider(
      create: (context) => sl<ChatCubit>()..init(chat, currentUserId),
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                chat.serviceName,
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            // Messages list
            Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
                listener: (context, state) {
                  if (state.error != null) {
                    UIHelpers.showErrorSnackbar(
                      context: context,
                      message: state.error!,
                    );
                  }
                },
                builder: (context, state) {
                  if (state.isLoading && state.messages.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.messages.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(AppSpacing.xl(context)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.chat_rounded,
                              size: 64,
                              color: AppColors.textSecondary(context),
                            ),
                            SizedBox(height: AppSpacing.md(context)),
                            Text(
                              'ابدأ المحادثة',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    reverse: true,
                    padding: EdgeInsets.symmetric(
                      vertical: AppSpacing.sm(context),
                    ),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      // Reverse index since list is reversed
                      final message =
                          state.messages[state.messages.length - 1 - index];
                      return MessageBubble(
                        message: message,
                        isMine: message.senderId == currentUserId,
                      );
                    },
                  );
                },
              ),
            ),
            // Input field
            BlocBuilder<ChatCubit, ChatState>(
              buildWhen: (prev, curr) => prev.isSending != curr.isSending,
              builder: (context, state) {
                return ChatInputField(
                  isSending: state.isSending,
                  onSend: (text) {
                    context.read<ChatCubit>().sendMessage(text, currentUserId);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
