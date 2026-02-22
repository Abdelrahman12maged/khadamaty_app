import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamaty_app/core/di/injection_container.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/core/utils/ui_helpers.dart';
import 'package:khadamaty_app/features/auth/domain/repositories/auth_repository.dart';
import '../cubits/chat_list_cubit/chat_list_cubit.dart';
import '../cubits/chat_list_cubit/chat_list_state.dart';
import '../widgets/chat_widgets/chat_list_tile.dart';
import 'chat_page.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ChatListCubit>()..loadChats(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('المحادثات'),
        ),
        body: BlocConsumer<ChatListCubit, ChatListState>(
          listener: (context, state) {
            if (state.error != null) {
              UIHelpers.showErrorSnackbar(
                context: context,
                message: state.error!,
              );
            }
          },
          builder: (context, state) {
            if (state.isLoading && state.chats.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.chats.isEmpty) {
              return _EmptyChatsView();
            }

            final currentUserId = sl<AuthRepository>().currentUser?.id ?? '';

            return ListView.separated(
              padding: EdgeInsets.symmetric(
                vertical: AppSpacing.sm(context),
              ),
              itemCount: state.chats.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                indent: AppSpacing.page(context) + 56,
                color: AppColors.divider(context),
              ),
              itemBuilder: (context, index) {
                final chat = state.chats[index];
                return ChatListTile(
                  chat: chat,
                  currentUserId: currentUserId,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ChatPage(
                          chat: chat,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _EmptyChatsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xl(context)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline_rounded,
              size: 80,
              color: AppColors.textSecondary(context),
            ),
            SizedBox(height: AppSpacing.md(context)),
            Text(
              'لا توجد محادثات',
              style: theme.textTheme.titleMedium,
            ),
            SizedBox(height: AppSpacing.sm(context)),
            Text(
              'ابدأ محادثة من صفحة الحجوزات',
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
