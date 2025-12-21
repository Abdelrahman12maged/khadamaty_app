import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/utils/responsive_font_size.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';

/// Custom AppBar for Home Screen
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: context.isMobile,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Khadamaty',
            style: Theme.of(context).textTheme.headlineSmall
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {
            // TODO: Navigate to notifications
          },
        ),
        Padding(
          padding: EdgeInsets.only(
              right: context.responsive(mobile: 8, desktop: 32)),
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(
              Icons.person,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
